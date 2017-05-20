class CategoriesController < ApplicationController
  include CategoriesHelper

  def index
    @categories = Category.all
  end

  def show
    @category= Category.find_by_id(params[:id])
  end

  def search
    @category = Category.find_by_id(params[:cat_id])

    case @category.id
    when 1
      @database_results = @category.search_database(params["search"])
      database_ids = @category.database_results_ids(params["search"])
      search_result = omdb_movie_search(database_ids)
      if search_result.class == String
        @errors = "No results found"
      else
        @api_results = search_result
      end
    when 2
      @database_results = @category.search_database(params["search"])
      database_ids = @category.database_results_ids(params["search"])
      search_result = omdb_tv_search(database_ids)
      if search_result.class == String
        @errors = "No results found"
      else
        @api_results = search_result
      end
    when 3
      @database_results = @category.search_database(params["search"])
      database_ids = @category.database_results_ids(params["search"])
      search_result = google_books_search(database_ids)
      if search_result.class == String
        @errors = "No results found"
      else
        @api_results = search_result
      end
    when 4
      @database_results = @category.search_database(params["search"])
      database_ids = @category.database_results_ids(params["search"])
      search_result = google_places_search(database_ids)
      if search_result.class == String
        @errors = "No results found"
      else
        @api_results = search_result.map{|place|place.description}
      end
    when 5
      @database_results = @category.search_database(params["search"])
      database_ids = @category.database_results_ids(params["search"])
      search_result = google_restaurant_search(database_ids)
      if search_result.class == String
        @errors = "No results found"
      else
        @api_results = search_result.map{|eat|eat.name}
      end
    end
  end

end
