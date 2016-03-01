class CommentsController < ApplicationController

  def create
    commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(commentable, commenter_id, body, commenter_name)

    respond_to do |format|
      if @comment.save
        make_child_comment
        format.html  { redirect_to(:back, :notice => 'Comment was successfully added.') }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @article = Article.find(@comment.commentable_id)
    @comment.update_attributes(body: 'Комментарий удален. Здесь могла быть ваша реклама')
    respond_to do |format|
      format.html { redirect_to @article }
      format.js { @new_comment = Comment.build_from(@article, commenter_id, "", "") }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = Article.find(@comment.commentable_id)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article }
      format.js { @new_comment = Comment.build_from(@article, commenter_id, "", "") }
    end
  end

  private

  def commenter_name
    if user_signed_in?
      current_user.name
    elsif comment_params[:subject]
      comment_params[:subject] + " (unregistered)"
    else
      "Unregistered"
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id, :subject)
  end

  def commentable_type
    comment_params[:commentable_type]
  end

  def commentable_id
    comment_params[:commentable_id]
  end

  def comment_id
    comment_params[:comment_id]
  end

  def body
    comment_params[:body]
  end

  def make_child_comment
    return "" if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end
  
end
