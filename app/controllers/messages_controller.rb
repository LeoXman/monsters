# Сообщения пользователей
class MessagesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    message = @user.messages.new(message_params)
    message.title = @current_user.username
    message.save

    redirect_to user_path(@user)
  end

  private

  def message_params
    params.require(:message).permit(:title, :text)
  end
end
