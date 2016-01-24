class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    binding.pry
    if comment_params[:commentable_type] == 'Article' && Article.exists?(comment_params[:article_id]) && comment_params[:commentable_id] == comment_params[:article_id]
      if @comment.save
        redirect_to articles_path
      else
        redirect_to articles_path
      end
    end
    if comment_params[:commentable_type] == 'Comment' && Comment.exists?(comment_params[:commentable_id]) && Comment.find(comment_params[:commentable_id]).article_id == comment_params[:article_id]
      if @comment.save
        redirect_to articles_path
      else
        redirect_to articles_path
      end
    end

    binding.pry
  end

  def destroy
    
  end

  private

    def comment_params
      params.require(:comment).permit(:article_id, :owner_name, :body, :commentable_type, :commentable_id)     
    end

end
