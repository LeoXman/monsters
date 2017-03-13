# Админка
class AdministratorController < ApplicationController
  before_action :access
  def index
    @letter   = Monster.letterize(params[:letter])
    @monsters = Monster.letter(@letter).page(1).per(10)
    @comments = Comment.all.page(1).per(10)
    @users = User.all.page(1).per(10)
  end
end
