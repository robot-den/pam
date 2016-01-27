class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    #FIXME - need only approved articles
    @articles = Article.where(approved: true).order('created_at DESC')
  end

  def show
    @comment = Comment.new
    @article = Article.find(params[:id])
    @comments = take_sort_comments(@article)
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

    def take_sort_comments(article)
      a = []
      b = Comment.where("article_id = #{article.id}")
      unless b.empty?
        a = b.select { |x| x.commentable_type == 'Article' }
        b = b.to_a.reject! { |x| x.commentable_type == 'Article' }
        while b.empty? == false
          a.each_with_index do |elem, i|
            d = b.select { |z| z.commentable_id == elem.id }
            if d != []
                a = a.insert(i+1, d).flatten
                b.reject! { |z| z.commentable_id == elem.id }
                break
            end
          end
        end
      end
      a
    end

end
