class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name ||= "default.png"

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = t('flash.user_created')
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
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = t('flash.user_updated')
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id).order(created_at: :desc)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == @current_user.id
      flash[:alert] = t('flash.unauthorized')
      redirect_to user_messages_path
    end
  end

  private

  def user_params
    permitted = [:name, :email, :image_name]
    permitted << :password if action_name == "create" || params[:user][:password].present?
    params.require(:user).permit(*permitted)
  end
end
