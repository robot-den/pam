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
  end

  def create
    @article = Article.new(article_params)
    #FIXME Is this normal? Uncomment when devise will work.
    # @article.user_id = current_user.id
    #FIXME delete it
    @article.user_id = 1
    if @article.save
      redirect_to article_path(@article)
    else
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
