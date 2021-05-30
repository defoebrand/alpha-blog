class CategoriesController < ApplicationController
  before_action :new_category, only: %i[new create]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new; end

  def show
    @category = Category.find(params[:id])
  end

  def create
    if @category.update(category_params)
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  private

  def new_category
    @category = Category.new
  end

  def category_params
    params.require(:category).permit(:name)
  end
end