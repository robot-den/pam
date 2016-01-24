class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if params[:commentable_type] == 'Article' && Article.exist?(params[:article_id]) && params[:commentable_id] == params[:article_id]
      if @comment.save
        redirect_to articles_path
      else
        redirect_to articles_path
      end
    end
    if params[:commentable_type] == 'Comment' && Comment.exist?(params[:commentable_id]) && Comment.find(params[:commentable_id]).article_id == params[:article_id]
      if @comment.save
        redirect_to articles_path
      else
        redirect_to articles_path
      end
    end
  end

  def destroy
    
  end

  private

    def comment_params
      params.require(:comment).permit(:article_id, :owner_name, :body, :commentable_type, :commentable_id)     
    end

end
