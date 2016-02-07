class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]


  def index
    @articles = Article.where(approved: true).order('created_at DESC').page_kaminari(params[:page])
  end

  def show
    if params[:id] && Article.exists?(params[:id])
      @article = Article.find(params[:id])
      #FIXME current_user
      @new_comment = Comment.build_from(@article, commenter_id, "", "")
    else
      redirect_to articles_path
    end
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
    if current_user.try(:admin?)
      @article = Article.find(params[:id])
      @article.destroy!
    end
    redirect_to articles_path
  end

  private

    def article_params
      params.require(:article).permit(:header, :announce, :body)
    end
end
