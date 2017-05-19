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
      @api_results = omdb_movie_search(database_ids)
    when 2
      @database_results = @category.search_database(params["search"])
      database_ids = @category.database_results_ids(params["search"])
      @api_results = omdb_tv_search(database_ids)
    when 3
      google_books_search
    when 4
      google_places_search
    when 5
      # Will need to update
      PgSearch.multisearch(params["search"])
    when 6
      google_restaurant_search
    end
  end

end
