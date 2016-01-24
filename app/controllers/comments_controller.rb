class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.commentable_type == 'Article' && Article.exists?(@comment.article_id) && @comment.commentable_id == @comment.article_id
      @comment.owner_name = current_user.name if user_signed_in?
      if @comment.save
        redirect_to articles_path
      else
        redirect_to articles_path
      end
    end
    if @comment.commentable_type == 'Comment' && Comment.exists?(@comment.commentable_id) && Comment.find(@comment.commentable_id).article_id == @comment.article_id
      @comment.owner_name = current_user.name if user_signed_in?
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
