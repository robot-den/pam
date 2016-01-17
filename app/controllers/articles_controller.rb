class ArticlesController < ApplicationController

  def index
    #FIXME - need only approved articles
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
