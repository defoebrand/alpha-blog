class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update]
  before_action :new_article, only: %i[new create]
  around_action :save_article, only: %i[create update]


  def index
    @articles = Article.all
  end

  def create; end
  def update; end

  private

  def articles_params
    params.require(:article).permit(:title, :description)
  end

  def new_article
    @article = Article.new
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def save_article
    flash_notice = params[:action] == 'create' ? 'created' : 'updated'
    return_to_page = params[:action] == 'create' ? 'new' : 'edit'

    if @article.update(articles_params)
      flash[:notice] = "Article was #{flash_notice} successfully."
      redirect_to @article
    else
      render return_to_page
    end
  end
end
