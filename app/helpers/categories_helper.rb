module CategoriesHelper

  def omdb_movie_search(database_ids)
    uri = URI.parse("http://www.omdbapi.com/?apikey=#{ENV['IMDB_KEY']}&s=#{params["search"]}")
    response = Net::HTTP.get_response(uri)
    body = JSON.parse(response.body)
    search_params = body["Search"]
    if search_params.class != Array || search_params.length == 0
      "error"
    else
      movies = search_params.select{|film| film["Type"] == "movie" && !database_ids.include?(film["imdbID"])}
      api_results = movies.map do |movie|
        movie_uri = URI.parse("http://www.omdbapi.com/?apikey=#{ENV['IMDB_KEY']}&i=#{movie["imdbID"]}")
        movie_response = Net::HTTP.get_response(movie_uri)
        movie_body = JSON.parse(movie_response.body)
        movie_info = []
        movie_info.push(
          movie_body["Title"],
          movie_body["imdbID"],
          {
            year: movie_body["Year"],
            plot: movie_body["Plot"]
          },
          movie_body["Poster"]
        )
      end
    end
  end

  def omdb_tv_search(database_ids)
    uri = URI.parse("http://www.omdbapi.com/?apikey=#{ENV['IMDB_KEY']}&s=#{params["search"]}")
    response = Net::HTTP.get_response(uri)
    body = JSON.parse(response.body)
    search_params = body["Search"]
    if search_params.class != Array || search_params.length ==0
      "No results found"
    else
      shows = search_params.select{|film| film["Type"] =="series" && !database_ids.include?(film["imdbID"])}
      api_results = shows.map do |show|
        show_uri = URI.parse("http://www.omdbapi.com/?apikey=#{ENV['IMDB_KEY']}&i=#{show["imdbID"]}")
        show_response = Net::HTTP.get_response(show_uri)
        show_body = JSON.parse(show_response.body)
        show_info = []
        show_info.push(
          show_body["Title"],
          show_body["imdbID"],
          {
            year: show_body["Year"],
            plot: show_body["Plot"]
          },
          show_body["Poster"]
        )
      end
    end
  end

  def google_books_search(database_ids)
    search_params = GoogleBooks.search(params["search"])
    if search_params.first.class == NilClass
      "No book found"
    else
      books = search_params.select{|book| !database_ids.include?(book.id)}
      api_results = books.map do |book|
        book_info = []
        book_info.push(
          book.title,
          book.id,
          {
            author: book.authors,
            plot: book.description
          },
          book.image_link
        )
      end
    end
  end

  def google_places_search(database_ids)
    client = GooglePlaces::Client.new(ENV['GOOGLE_KEY'])
    returns = client.predictions_by_input(params["search"], types:'(regions)')
    if returns.length == 0
      @errors = "No results found"
    else
      places = returns.select{ |place| !database_ids.include?(place.place_id)}
      api_results = places.map do |place|
        spot = client.spot(place.place_id)
        place_info = []
        place_info.push(
          place.description,
          place.place_id,
          {},
          spot.photos[0].fetch_url(800)
        )
      end
    end
  end

  def google_restaurant_search(database_ids)
    client = GooglePlaces::Client.new(ENV['GOOGLE_KEY'])
    returns = client.spots_by_query(params["search"], :types => ['restaurant', 'food', 'cafe'])
    if returns.length == 0
      @errors = "No results found"
    else
      eats = returns.select{|place| !database_ids.include?(place.place_id)}
      api_results = eats.map do |eat|
        if eat.opening_hours["open_now"] == true
          open_now = "yes"
        else
          open_now = "no"
        end
        spot = client.spot(eat.place_id)
        place_info = []
        place_info.push(
          eat.name,
          eat.place_id,
          {
            address: eat.formatted_address,
            "open now?": open_now,
            "price level (0-4)": eat.price_level,
            "Google rating": eat.rating
          },
          spot.photos[0].fetch_url(800)
        )
      end
    end
  end
end
