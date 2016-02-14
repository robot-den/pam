class CategoriesController < ApplicationController

  def subscribe
    if Category.exists?(name: params[:name])
      Category.sub_unsub_category(take_category, current_user)
      redirect_to :back
    else
      redirect_to articles_path
    end
  end

  def show
    if Category.exists?(name: params[:name])
      @articles = take_category.articles.where(approved: true).order('created_at DESC').page_kaminari(params[:page])
      render 'articles/index'
    else
      redirect_to articles_path
    end
  end

  private

  def take_category
    Category.where(name: params[:name]).first
  end

end
