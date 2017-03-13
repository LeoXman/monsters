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

  # Форма создание нового монстра
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
                  flash: {
                    error: 'Недостаточно прав для редактирования записи'
                  }
    end
  end

  # Добавление нового монстра в базу
  def create
    @monster     = Monster.create(monster_params)
    @monster.own = @current_user.id
    @monster.save
    respond_to do |format|
      if @monster.save
        format.html do
          redirect_to @monster,
                      notice: 'Монстр создан.'
        end
        format.json do
          render :show,
                 status: :created,
                 location: @monster
        end
      end
    end
  end

  # Обновление монстра
  def update
    @monster = Monster.update(monster_params)
    respond_to do |format|
      if @monster.update(monster_params)
        format.html do
          redirect_to @monster,
                      notice: 'Монстр обновлен.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @monster
        end
      end
    end
  end

  # Действие like
  def like
    monster = Monster.find(params[:id])
    if vote_stamp_check?(monster.id)
      monster.increment!(:like)
      vote_stamp(monster.id)
      respond_to do |format|
        format.json do
          render json: monster,
                 status: :created
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: monster, status: :error
        end
      end
    end
  end

  # Действие dislike
  def dislike
    @monster = Monster.find(params[:id])
    if vote_stamp_check?(@monster.id)
      @monster.increment!(:dislike)
      vote_stamp(@monster.id)
      redirect_to :back, flash: { notice: 'Вы успешно проголосовали!' }
    else
      redirect_to :back, flash: { error: 'Вы уже проголосовали!' }
    end
  end

  # Действие добавления монстра в избранное
  def add_favorite
    @user                 = User.find(current_user.id)
    @monster              = Monster.find(params[:id])
    favoritelist          = @user.favorites.where(monster_id: params[:id])
    favorite              = true if favoritelist.blank?
    favorite              = @user.favorites.new if favorite
    favorite.monster_id   = @monster.id
    favorite.monster_name = @monster.name
    favorite.save
    respond_to do |format|
      format.json do
        render json: @monster, status: :created
      end
      fix_count
    end
  end

  private

  def check_own?(id)
    @current_user.id == id
  end

  # Обновления счетчика избранных монстров
  def fix_count
    user           = User.find(current_user.id)
    user.fav_count = user.fav_count + 1
    user.save
  end

  # Проверка голосовал ли пользователь
  def vote_stamp_check?(monster)
    @monster = Monster.find(monster)
    return true unless @monster.vote_stamps.to_s.include? current_user.id
  end

  # Отметка, что пользователь проголосовал
  def vote_stamp(monster)
    user     = current_user.id
    user     = user.to_s
    @monster = Monster.find(monster)
    stamps   = @monster.vote_stamps
    stamps   = stamps.to_s
    @monster.vote_stamps = stamps + ',' + user
    @monster.save
  end

  def monster_params
    params.require(:monster).permit(:name, :hp, :def, :mdef, :str, :agi,
                                    :vit, :int, :dex, :luk, :scale, :own)
  end

  def comment_params
    params.require(:monster).permit(
      :text
    )
  end
end
