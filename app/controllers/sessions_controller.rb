class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to user_messages_path
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "Logged out successfully."
    redirect_to root_path
  end
end
