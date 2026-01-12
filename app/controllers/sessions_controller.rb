class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = t('flash.logged_in')
      redirect_to user_messages_path
    else
      flash.now[:alert] = t('flash.invalid_credentials')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = t('flash.logged_out')
    redirect_to root_path
  end
end
