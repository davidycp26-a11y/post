class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:user][:name], 
      email: params[:user][:email],
      password: params[:user][:password]
      )
    if @user.save
      flash[:notice] = "User was successfully created."
      redirect_to user_path(@user)
    else
      logger.debug "Validation errors: #{@user.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    if @user.save
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      logger.debug "Validation errors: #{@user.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

end
