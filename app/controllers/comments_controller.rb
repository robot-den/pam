class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.commentable_type == 'Article' && Article.exists?(id: @comment.article_id) && @comment.commentable_id == @comment.article_id
      if user_signed_in?
        @comment.owner_name = current_user.name 
      else
        @comment.owner_name += ' (unregistered)'
      end
      if @comment.save
        redirect_to article_path(@comment.article_id)
      else
        redirect_to article_path(@comment.article_id)
      end
    end
    if @comment.commentable_type == 'Comment' && Comment.exists?(id: @comment.commentable_id) && Comment.find(@comment.commentable_id).article_id == @comment.article_id
      if user_signed_in?
        @comment.owner_name = current_user.name 
      else
        @comment.owner_name += ' (unregistered)'
      end
      if @comment.save
        redirect_to article_path(@comment.article_id)
      else
        redirect_to article_path(@comment.article_id)
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
