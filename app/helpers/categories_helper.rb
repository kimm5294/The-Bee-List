require 'omdbapi'

AWS::S3::Base.establish_connection!(
 :google_key => ENV['GOOGLE_KEY']
)

module CategoriesHelper

  def omdb_movie_search(database_ids)
    search_params = OMDB.search(params["search"])
    p search_params
    if search_params.class != Array || search_params.length == 0
      "error"
    else
      result.select{|film| film.type == "movie" && !database_ids.include?(film.imdb_id)}.map {|film| {film.title => film.imdb_id}}
    end
  end

  def omdb_tv_search(database_ids)
    result = OMDB.search(params["search"])
    if result.class != Array || result.length ==0
      "No results found"
    else
      api_results = result.select{|film| film.type=="series" && !database_ids.include?(film.imdb_id)}.map{|film| {film.title => film.imdb_id}}
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
        place_info = []
        place_info.push(
          place.description,
          place.place_id
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
        place_info = []
        place_info.push(
          eat.name,
          eat.place_id,
          {
            address: eat.formatted_address,
            "open now?": open_now,
            "price level (0-4)": eat.price_level,
            "Google rating": eat.rating
          }
        )
      end
    end
  end
end
