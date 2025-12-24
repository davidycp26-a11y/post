class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:notice] = "Comment posted successfully"
      redirect_to user_message_path(@comment.user_message), status: :see_other
    else
      flash[:alert] = @comment.errors.full_messages.join(", ")
      redirect_to user_message_path(@comment.user_message), status: :see_other
    end
  end

  def edit
    @user_message = @comment.user_message
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated successfully"
      redirect_to user_message_path(@comment.user_message), status: :see_other
    else
      flash[:alert] = @comment.errors.full_messages.join(", ")
      redirect_to user_message_path(@comment.user_message), status: :see_other
    end
  end

  def destroy
    user_message = @comment.user_message
    @comment.destroy
    flash[:notice] = "Comment deleted"
    redirect_to user_message_path(user_message), status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    unless @comment
      flash[:alert] = "Comment not found"
      redirect_to user_messages_path
    end
  end

  def ensure_correct_user
    unless @comment.user_id == current_user.id
      flash[:alert] = "Unauthorized access"
      redirect_to user_message_path(@comment.user_message)
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :user_message_id)
  end
end
