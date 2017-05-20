module CategoriesHelper

  def omdb_movie_search(database_ids)
    search_params = OMDB.search(params["search"])
    result = OMDB.search(params["search"])
    if search_params.class != Array || result.length == 0
      @errors= "No results found"
    else
      @api_results= result.select{|film| film.type == "movie" && !database_ids.include?(film.imdb_id)}.map {|film| film.title}
    end
  end

  def omdb_tv_search(database_ids)
    search_params = OMDB.search(params["search"])
    result = OMDB.search(params["search"])
    if search_params.class != Array || result.length ==0
      @errors= "No results found"
    else
      @api_results = result.select{|film| film.type=="series" && !database_ids.include?(film.imdb_id)}.map{|film| film.title}
    end
  end

  def google_books_search
    search_params = GoogleBooks.search(params["search"])
    if search_params.first.class == NilClass
      @errors = "No book found"
    else
      @api_results = search_params.map{|book| book.title}
    end
  end

  def google_places_search
    client = GooglePlaces::Client.new(ENV["GOOGLE_PLACES_KEY"])
    returns = client.predictions_by_input(params["search"], types:'(regions)')
    p returns
    if returns.length == 0
      @errors = "No results found"
    else
      @places = returns
    end
  end

  def google_restaurant_search
    client = GooglePlaces::Client.new(ENV["GOOGLE_PLACES_KEY"])
    returns = client.spots_by_query(params["search"], :types => ['restaurant', 'food', 'cafe'])
    if returns.length == 0 || returns.errors.any?
      @errors = "No results found"
    else
      @eats = returns
    end
  end
end
