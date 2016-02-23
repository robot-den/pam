class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]


  def index
    @articles = Article.where(approved: true).order('created_at DESC').page_kaminari(params[:page])
  end

  def show
    if params[:id] && Article.exists?(params[:id])
      @article = Article.find(params[:id])
      @sub_categories, @unsub_categories = Category.user_categories(@article, current_user) if user_signed_in?
      #FIXME current_user and default values
      @new_comment = Comment.build_from(@article, commenter_id, "", "")
    else
      redirect_to articles_path
    end
  end

  def search
    if params[:search].nil? || params[:search].empty?
      redirect_to root_path
    else
      @articles = Article.search(
        params[:search], 
        with: {approved: true}, 
        page: params[:page], 
        per_page: 6)
      @articles.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
      render 'search'
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
