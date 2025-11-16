class UserMessagesController < ApplicationController
  def index
    @posts = UserMessage.all.order(created_at: :desc)
  end

  def show
    @post = UserMessage.find_by(id: params[:id])
  end

  def new
  end

  def create
    @post = UserMessage.new(content: params[:content], user_id: 1)
    @post.save
    redirect_to("/posts/index")
  end
end
