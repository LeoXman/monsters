class MonstersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:home, :search]
  def home

  end

  def index
    authorize! :index, Monster
    @letter   = Monster.letterize(params[:letter])
    @monsters = Monster.letter(@letter).page(1).per(10)
  end

  def search
    search_monsters =
      Monster.where(
        name: params[:search][:name]
      )
    @monsters = search_monsters.page(1).per(10)
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
    authorize! :read, @monster
    @monster = Monster.find(params[:id])
    user_id = @monster.own
    @own = User.find_by(id: user_id)
  end

  # GET /monsters/new
  def new
    authorize! :new, Monster
    @monster = Monster.new
  end

  # GET /monsters/1/edit
  def edit
    @monster = Monster.find(params[:id])
    if check_own?(@monster.own)
      respond_to :html
    else
      redirect_to :back, flash: { error: 'Недостаточно прав для редактирования записи' }
    end
  end

  # POST /monsters
  # POST /monsters.json
  def create
    @monster = Monster.create(monster_params)
    @monster.own = @current_user.id
    @monster.save
    respond_to do |format|
      if @monster.save
        format.html { redirect_to @monster, notice: 'Monster was successfully created.' }
        format.json { render :show, status: :created, location: @monster }
      else
        format.html { render :new }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monsters/1
  # PATCH/PUT /monsters/1.json
  def update
    @monster = Monster.update(monster_params)
    respond_to do |format|
      if @monster.update(monster_params)
        format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster }
      else
        format.html { render :edit }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1
  # DELETE /monsters/1.json
  def destroy

  end

  def like
    @monster = Monster.find(params[:id])
    if vote_stamp_check(@monster.id)
      @monster.increment!(:like)
      vote_stamp(@monster.id)
      respond_to do |format|
        format.json { render json: @monster, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @monster, status: :error }
      end
    end
  end

  def dislike
    @monster = Monster.find(params[:id])
    if vote_stamp_check(@monster.id)
      @monster.increment!(:dislike)
      vote_stamp(@monster.id)
      redirect_to :back, flash: { notice: 'Вы успешно проголосовали!' }
    else
      redirect_to :back, flash: { error: 'Вы уже проголосовали!' }
    end
  end

  def add_favorite
    @user = User.find(current_user.id)
    @monster = Monster.find(params[:id])
    favoritelist = @user.favorites.where(monster_id: params[:id])
    favorite = true if favoritelist.blank?
    favorite = @user.favorites.new if favorite
    favorite.monster_id = @monster.id
    favorite.monster_name = @monster.name
    favorite.save
    respond_to do |format|
      format.json { render json: @monster, status: :created }
      fix_count
    end
  end

  private

    def check_own?(id)
      @current_user.id == id
    end

    def fix_count
      user = User.find(current_user.id)
      user.fav_count = user.fav_count + 1
      user.save
    end

    def vote_stamp_check(monster)
      user = current_user.id
      user = user.to_s
      @monster = Monster.find(monster)
      stamps = @monster.vote_stamps.to_s
      if stamps.include? user
        return false
      else
        return true
      end
    end

    def vote_stamp(monster)
      user = current_user.id
      user = user.to_s
      @monster = Monster.find(monster)
      stamps = @monster.vote_stamps
      stamps = stamps.to_s
      @monster.vote_stamps = stamps + "," + user
      @monster.save
    end

    # # Use callbacks to share common setup or constraints between actions.
    # def set_monster
    #   @monster = Monster.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_params
    params.require(:monster).permit(
      :name,
      :hp,
      :def,
      :mdef,
      :str,
      :agi,
      :vit,
      :int,
      :dex,
      :luk,
      :scale,
      :own
    )
    end
    def comment_params
    params.require(:monster).permit(
      :text
    )
    end
end
