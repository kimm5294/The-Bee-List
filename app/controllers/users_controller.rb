class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @categories = Category.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render "users/show"
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def friends
    @user = User.find_by(id: params[:user_id])
  end

  def search
    @category = Category.find_by_id(params[:cat_id])

    case @category.id
    when 1
      search_params = OMDB.search(params["search"])
      result = OMDB.search(params["search"]).select{|film| film.type=="movie"}
      if search_params.class != Array || result.length ==0
        @errors= ["No results found"]
      else
        @results= result
      end
    when 2
      search_params = OMDB.search(params["search"])
      result = OMDB.search(params["search"]).select{|film| film.type=="series"}
      puts result
      if search_params.class != Array || result.length ==0
        @errors= ["No results found"]
      else
        @results = result
      end
    when 3


    when 4

    when 5

    when 6

    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end
end
