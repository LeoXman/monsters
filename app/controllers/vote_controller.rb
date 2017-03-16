# Голоса
class VoteController < ApplicationController
  # Создание голоса
  def new
    poll = Poll.find_by_monster_id(params[:monster_id])
    if poll.blank?
      Poll.create(monster_id: params[:monster_id])
      poll = Poll.find_by(monster_id: params[:monster_id])
    end
    if poll.vote.find_by(user_id: current_user.id)
      delete(poll.vote.find_by(user_id: current_user.id))
    else
      create(poll)
    end
  end

  private

  # Добавление голоса в базу
  def create(poll)
    poll.vote.create(like: true, user_id: current_user.id)
    respond_to do |format|
      format.json { render json: poll.vote, status: :created } if
      poll.vote.create
    end
  end

  # Удаление голоса из базы
  def delete(vote)
    vote.destroy
    respond_to do |format|
      format.json { render json: poll.vote, status: :error } if
      poll.vote.create
    end
  end
end
