class ArticlesController < ApplicationController

  layout "article"
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #FIXME - need only approved articles
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = Article.new(article_params)
    #FIXME Is this normal?
    @article.user_id = current_user.id
    #FIXME
    if params[:category] && @article.save
      @article.assign_categories(params.require(:category))
      redirect_to article_path(@article)
    else      
      @categories = Category.all
      render new_article_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!
    redirect_to articles_path
  end

  private

    def article_params
      params.require(:article).permit(:header, :announce, :body)
    end

end
