# Monsters
class
  MonstersController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource only: [:home, :search]

  # Вывод всех монстров
  def index
    authorize! :index, Monster
    @letter   = Monster.letterize(params[:letter])
    @monsters = Monster.letter(@letter).page(1).per(10)
  end

  # Страница результатов поиска монстров
  def search
    search_monsters =
      Monster.where(
        name: params[:search][:name]
      )
    @monsters = search_monsters.page(1).per(10)
  end

  # Страница описания монстра
  def show
    authorize! :read, @monster
    @monster = Monster.find(params[:id])
    user_id = @monster.own
    @own = User.find_by(id: user_id)
  end

  # Форма создания нового монстра
  def new
    authorize! :new, Monster
    @monster = Monster.new
  end

  # Редактирование монстра
  def edit
    @monster = Monster.find(params[:id])
    if check_own?(@monster.own)
      respond_to :html
    else
      redirect_to :back,
                  flash: { error: 'Недостаточно прав для
                     редактирования записи' }
    end
  end

  # Обновление монстра
  def update
    monster = Monster.update(monster_params)
    respond_to do |format|
      if monster.update(monster_params)
        format.html redirect_to monster, notice: 'Монстр обновлен.'
        format.json render :show, status: :ok, location: monster
      end
    end
  end

  private

  # Проверка владельца монстра
  def check_monster_owner?(id)
    @current_user.id == id
  end

  # Обновления счетчика избранных монстров
  def fix_count
    user           = User.find(current_user.id)
    user.fav_count = user.fav_count + 1
    user.save
  end

  def monster_params
    params.require(:monster).permit(:name, :hp, :def, :mdef, :str, :agi,
                                    :vit, :int, :dex, :luk, :scale)
  end

  def comment_params
    params.require(:monster).permit(:content)
  end
end
