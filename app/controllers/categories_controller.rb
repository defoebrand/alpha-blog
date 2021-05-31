class CategoriesController < ApplicationController
  before_action :new_category, only: %i[new create]
  before_action :set_category, only: %i[show edit update destroy]
  around_action :save_category, only: %i[create update]
  before_action :require_admin, except: %i[index show]


  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end


  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destroy
    @categroy.destroy
    redirect_to categories_path
  end

  private

  def new_category
    @category = Category.new
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def save_category
    flash_notice = params[:action] == 'create' ? 'created' : 'updated'
    return_to_page = params[:action] == 'create' ? 'new' : 'edit'

    if @category.update(category_params)
      flash[:notice] = "Category was #{flash_notice} successfully."
      redirect_to @category
    else
      render return_to_page
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless (logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end