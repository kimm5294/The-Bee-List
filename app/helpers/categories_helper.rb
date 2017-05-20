require 'omdbapi'
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
      api_results = search_params.select{|book| !database_ids.include?(book.id)}.map{|book| {book.title => book.id}}
    end
  end

  def google_places_search(database_ids)
    client = GooglePlaces::Client.new("AIzaSyBjfu4hhTsevzx0eYFeqjzzsZ_TmktebN0")
    returns = client.predictions_by_input(params["search"], types:'(regions)')
    if returns.length == 0
      @errors = "No results found"
    else
      @places = returns.select{|place| !database_ids.include?(place.place_id)}.map{|place| {place.description => place.place_id}}
    end
  end

  def google_restaurant_search(database_ids)
    client = GooglePlaces::Client.new("AIzaSyBjfu4hhTsevzx0eYFeqjzzsZ_TmktebN0")
    returns = client.spots_by_query(params["search"], :types => ['restaurant', 'food', 'cafe'])
    if returns.length == 0
      @errors = "No results found"
    else
      @eats = returns.select{|place| !database_ids.include?(place.place_id)}.map{|eat| {eat.name => eat.place_id}}
    end
  end
end
