class UserMessagesController < ApplicationController

  before_action :require_login
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @sort_by = params[:sort_by] || 'recent'

    if @sort_by == 'likes'
      # Sort by number of likes (most liked first)
      @user_messages = UserMessage.left_joins(:likes)
                                   .group(:id)
                                   .order('COUNT(likes.id) DESC, user_messages.created_at DESC')
    else
      # Default: sort by creation time (newest first)
      @user_messages = UserMessage.all.order(created_at: :desc)
    end
  end

  def show
    @user_message = UserMessage.find_by(id: params[:id])
    @user = @user_message.user
    @likes_count = Like.where(user_message_id: @user_message.id).count
    @comments = @user_message.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @user_message = UserMessage.new
  end

  def create
    @user_message = UserMessage.new(user_message_params)
    @user_message.user_id = @current_user.id
    if @user_message.save
      flash[:notice] = t('flash.post_created')
      redirect_to user_messages_path
    else
      logger.debug "Validation errors: #{@user_message.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user_message = UserMessage.find_by(id: params[:id])
  end

  def update
    @user_message = UserMessage.find_by(id: params[:id])
    if @user_message.update(user_message_params)
      flash[:notice] = t('flash.post_updated')
      redirect_to user_messages_path, status: :see_other
    else
      flash[:alert] = @user_message.errors.full_messages.join(", ")
      redirect_to user_message_path(@user_message), status: :see_other
    end
  end

  def destroy
    @user_message = UserMessage.find_by(id: params[:id])
    @user_message.destroy
    redirect_to user_messages_path
  end

  def ensure_correct_user
    @user_message = UserMessage.find_by(id: params[:id])
    unless @user_message.user_id == @current_user.id
      flash[:alert] = t('flash.unauthorized')
      redirect_to user_messages_path
    end
  end

  private

  def user_message_params
    params.require(:user_message).permit(:content)
  end
end
