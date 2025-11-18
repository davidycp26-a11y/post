class UserMessagesController < ApplicationController
  def index
    @user_messages = UserMessage.all.order(created_at: :desc)
  end

  def show
    @user_message = UserMessage.find_by(id: params[:id])
  end

  def new
    @user_message = UserMessage.new
  end

  def create
    @user_message = UserMessage.new(content: params[:user_message][:content], user_id: 1)
    if @user_message.save
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
    @user_message.content = params[:user_message][:content]
    if @user_message.save
      flash[:notice] = "Post was successfully updated."
      redirect_to user_messages_path
    else
      logger.debug "Validation errors: #{@user_message.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_message = UserMessage.find_by(id: params[:id])
    @user_message.destroy
    redirect_to user_messages_path
  end
end
