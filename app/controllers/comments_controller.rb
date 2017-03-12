# Комментарии к монстрам
class CommentsController < ApplicationController
  def create
    @monster = Monster.find(params[:monster_id])
    comment = @monster.comments.new(comment_params)
    comment.title = @current_user.username
    comment.save
    redirect_to monster_path(@monster)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end
end
