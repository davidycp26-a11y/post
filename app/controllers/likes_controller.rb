class LikesController < ApplicationController
  def create
    like = Like.new(
      user_id: current_user.id,
      user_message_id: params[:user_message_id]
    )
    if like.save
      redirect_to user_message_path(params[:user_message_id])
    else
      render plain: like.errors.full_messages[0], status: :bad_request
    end
  end

  def destroy
    like = Like.find(params[:id])
      if like.user_id == current_user.id
      like.destroy
      redirect_to user_message_path(like.user_message_id)
    else
      render plain: "Like not found", status: :not_found
    end
  end
end