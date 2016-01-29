class CategoriesController < ApplicationController

  def show
    if Category.exists?(name: params[:name])
      @articles = Category.where(name: params[:name]).first.articles.where(approved: true).order('created_at DESC').page_kaminari(params[:page])
      render 'articles/index'
    else
      redirect_to articles_path
    end
  end
end
