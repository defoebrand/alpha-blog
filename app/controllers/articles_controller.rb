class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :new_article, only: %i[new create]
  around_action :save_article, only: %i[create update]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]


  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def create; end

  def update; end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def articles_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def new_article
    @article = Article.new
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def save_article
    @article.user = current_user
    flash_notice = params[:action] == 'create' ? 'created' : 'updated'
    return_to_page = params[:action] == 'create' ? 'new' : 'edit'

    if @article.update(articles_params)
      flash[:notice] = "Article was #{flash_notice} successfully."
      redirect_to @article
    else
      render return_to_page
    end
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end
