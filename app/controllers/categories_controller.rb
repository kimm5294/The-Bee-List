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

    @database_results = @category.search_database(params["search"])
    database_ids = @category.database_results_ids(params["search"])

    case @category.id
    when 1
      search_result = omdb_movie_search(database_ids)
    when 2
      search_result = omdb_tv_search(database_ids)
    when 3
      search_result = google_books_search(database_ids)
    when 4
      search_result = google_places_search(database_ids)
    when 5
      search_result = google_restaurant_search(database_ids)
    end

    if search_result.class == String
      @errors = "No results found"
    else
      @api_results = search_result
    end

  end

end
