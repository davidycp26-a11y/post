class UserMessagesController < ApplicationController
  def index
    @posts = UserMessage.all
  end
end
