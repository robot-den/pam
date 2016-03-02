# Articles Controller
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:search, :index, :show, :show_by_tag]

  def index
    @articles = Article.where(approved: true).order('created_at DESC').page_kaminari(params[:page])
  end

  def show
    @article = Article.find(params[:id])
    if @article.approved
      @new_comment = Comment.build_from(@article, commenter_id)
    else
      redirect_to articles_url
    end
  end

  # FIXME: MOVE IT TO INDEX METHOD
  def show_by_tag
    @articles = Article.tagged_with(params[:tag]).page_kaminari(params[:page])
    render 'index'
  end

  def search
    if params[:search].nil? || params[:search].empty?
      redirect_to root_url
    elsif params[:search_by] == 'tags'
      @articles = Article.tagged_with(params[:search]).page_kaminari(params[:page])
      render 'index'
    elsif params[:search_by] == 'words'
      @articles = Article.search(params[:search], with: { approved: true }, page: params[:page], per_page: 6)
      @articles.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
      render 'search'
    else
      redirect_to root_url
    end
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = Article.new(article_params)
    # FIXME: IS THIS NORMAL?
    @article.user_id = current_user.id
    # FIXME
    if params[:preview]
      render 'preview'
    elsif params[:category] && @article.save
      @article.assign_categories(params.require(:category))
      redirect_to articles_url
    else
      @categories = Category.all
      # FIXME
      render new_article_path
    end
  end

  def update
    if current_user.try(:admin?)
      @article = Article.find(params[:id])
      @article.update_attributes(approved: false)
    end
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.js
    end
  end

  private

  def article_params
    params.require(:article).permit(:header, :announce, :body, :tag_list)
  end
end
