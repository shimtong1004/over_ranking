#encoding: utf-8
class OverTagsController < ApplicationController
  before_action :set_over_tag, only: [:show, :edit, :update, :destroy, :detail, :update_data]
  skip_before_filter :verify_authenticity_token, :only => [:update_data]

  # GET /over_tags
  # GET /over_tags.json
  def index
    user_type_ids = OverUserType.where(user_type: "PC - KR").pluck(:id)
    @offense_heros = Hero.where(name: OFFENSE_HERO, over_user_type_id: user_type_ids).order("sum_#{KEY["플레이 시간"]} desc").group(:name).sum(KEY["플레이 시간"])
    @offense_playtime_sum = Hero.where(name: OFFENSE_HERO, over_user_type_id: user_type_ids).sum(KEY["플레이 시간"])
    
    @defense_heros = Hero.where(name: DEFENSE_HERO, over_user_type_id: user_type_ids).order("sum_#{KEY["플레이 시간"]} desc").group(:name).sum(KEY["플레이 시간"])
    @defense_playtime_sum = Hero.where(name: DEFENSE_HERO, over_user_type_id: user_type_ids).sum(KEY["플레이 시간"])
    
    @rush_heros = Hero.where(name: RUSH_HERO, over_user_type_id: user_type_ids).order("sum_#{KEY["플레이 시간"]} desc").group(:name).sum(KEY["플레이 시간"])
    @rush_playtime_sum = Hero.where(name: RUSH_HERO, over_user_type_id: user_type_ids).sum(KEY["플레이 시간"])
    
    @support_heros = Hero.where(name: SUPPORT_HERO, over_user_type_id: user_type_ids).order("sum_#{KEY["플레이 시간"]} desc").group(:name).sum(KEY["플레이 시간"])
    @support_playtime_sum = Hero.where(name: SUPPORT_HERO, over_user_type_id: user_type_ids).sum(KEY["플레이 시간"])
  end

  # GET /over_tags/1
  # GET /over_tags/1.json
  def show
  end

  # GET /over_tags/new
  def new
    session[:tag] = params[:tag] if params[:tag]
    tag = session[:tag]
    
    
    unless params[:play_type]
      session[:play_type] = "2"
    else
      session[:play_type] = params[:play_type]
    end
    
    tag.gsub!(/-/, '#')
    tag_ary = tag.split("#")
    if tag_ary.size == 2
      over_tag_id = OverTag.set_data(tag)
      over_tags = OverTag.where(id: over_tag_id)
    else
      over_tags = OverTag.where(tag_name: tag_ary[0])
    end
    @hero_ranks = {}
    @heros = []
    over_tags.each do |over_tag|
      over_tag.over_user_types.each do |user_type|
        hero = user_type.heros.where(name: "ALL HEROES", play_type: session[:play_type]).first
        next unless hero
        @heros.push hero
        hero_rank = (Hero.where(name: "ALL HEROES", play_type: session[:play_type]).where("#{KEY["플레이 시간"]} > ?", hero[KEY["플레이 시간"]]).count) + 1
        @hero_ranks[hero.id] = hero_rank
      end
    end
    render 'show'
  end
  
  def update_data
    over_user_type = @over_tag.over_user_types.find_by_user_type(session[:user_type])
    OverTag.update_hero_from_bnet(over_user_type)
    HeroGroup.set_group_data(over_user_type)
    @over_tag.update(data_updated_at: Time.now)
    render json: {status: :ok}
  end
  
  def over_role_rank
    play_type = 1
    t = Time.now
    start_day = t - 7.days
    end_day = t.end_of_day
    
    time = []
    won_per = []
    done = [] #힐링 or 피해
    kda = []
    
    @offense_hero_hash = {}
    @defense_hero_hash = {}
    @rush_hero_hash = {}
    @support_hero_hash = {}
    
    OFFENSE_HERO.each do |hero|
      @offense_hero_hash[hero] = OverRoleCalculation.where("play_type = ? and hero_name = ? and created_at between ? and ?", play_type, hero, t.beginning_of_day, t.end_of_day).first
      time.push @offense_hero_hash[hero].time_played
      won_per.push @offense_hero_hash[hero].games_won_per
      done.push @offense_hero_hash[hero].damage_done_avr
      kda.push @offense_hero_hash[hero].kda
    end
    @offense_time_top = time.sort[-1]
    @offense_won_top = won_per.sort[-1]
    @offense_done_top = done.sort[-1]
    @offense_kda_top = kda.sort[-1]
    
    time = []
    won_per = []
    done = [] #힐링 or 피해
    kda = []
    
    
    DEFENSE_HERO.each do |hero|
      @defense_hero_hash[hero] = OverRoleCalculation.where("play_type = ? and hero_name = ? and created_at between ? and ?", play_type, hero, t.beginning_of_day, t.end_of_day).first
      time.push @defense_hero_hash[hero].time_played
      won_per.push @defense_hero_hash[hero].games_won_per
      done.push @defense_hero_hash[hero].damage_done_avr
      kda.push @defense_hero_hash[hero].kda
    end
    @defense_time_top = time.sort[-1]
    @defense_won_top = won_per.sort[-1]
    @defense_done_top = done.sort[-1]
    @defense_kda_top = kda.sort[-1]
    
    time = []
    won_per = []
    done = [] #힐링 or 피해
    kda = []
    
    RUSH_HERO.each do |hero|
      @rush_hero_hash[hero] = OverRoleCalculation.where("play_type = ? and hero_name = ? and created_at between ? and ?", play_type, hero, t.beginning_of_day, t.end_of_day).first
      time.push @rush_hero_hash[hero].time_played
      won_per.push @rush_hero_hash[hero].games_won_per
      done.push @rush_hero_hash[hero].damage_done_avr
      kda.push @rush_hero_hash[hero].kda
    end
    @rush_time_top = time.sort[-1]
    @rush_won_top = won_per.sort[-1]
    @rush_done_top = done.sort[-1]
    @rush_kda_top = kda.sort[-1]
    
    time = []
    won_per = []
    done = [] #힐링 or 피해
    kda = []
    
    SUPPORT_HERO.each do |hero|
      @support_hero_hash[hero] = OverRoleCalculation.where("play_type = ? and hero_name = ? and created_at between ? and ?", play_type, hero, t.beginning_of_day, t.end_of_day).first
      time.push @support_hero_hash[hero].time_played
      won_per.push @support_hero_hash[hero].games_won_per
      done.push @support_hero_hash[hero].healing_done_avr
      kda.push @support_hero_hash[hero].kda
    end
    @support_time_top = time.sort[-1]
    @support_won_top = won_per.sort[-1]
    @support_done_top = done.sort[-1]
    @support_kda_top = kda.sort[-1]
    
    @total_time_played = OverRoleCalculation.where("play_type = ? and created_at between ? and ?", play_type, t.beginning_of_day, t.end_of_day).sum(:time_played)
    
    @date = Time.now.yesterday.year.to_s + ". " + Time.now.yesterday.month.to_s + ". " + Time.now.yesterday.day.to_s
    
  end
  
  def detail
    session[:user_type] = params[:user_type] if params[:user_type]
    if session[:play_type] == nil
      session[:play_type] = "2"
    elsif params[:play_type]
      session[:play_type] = params[:play_type]
    end
    
    unless params[:info_type]
      session[:info_type] = "1"
    else
      session[:info_type] = params[:info_type]
    end
    
    over_tag = @over_tag
    over_user_type = over_tag.over_user_types.find_by_user_type(session[:user_type])
    @over_user_type = over_user_type
    
    @main_hero_data = over_user_type.heros.where(play_type: session[:play_type], name: "ALL HEROES").first
    
    @heros = over_user_type.heros.where(play_type: session[:play_type]).where("name <> ?", "ALL HEROES").order("Time_Played desc")
        
    @offense_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "offense").first
    @defense_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "defense").first
    @rush_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "rush").first
    @support_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "support").first
    
    @hero_name = params[:hero_name]
    if @hero_name
      @hero = over_user_type.heros.where(play_type: session[:play_type], name: @hero_name).first
      @hero_rank = Hero.where(play_type: session[:play_type], name: @hero_name).where("Time_Played > ?", @hero.Time_Played).count + 1
      @hero_local_rank = Hero.where(play_type: session[:play_type], user_type: over_user_type.user_type, name: @hero_name).where("Time_Played > ?", @hero.Time_Played).count + 1
    end
    
  end
  
  def get_ranks
    over_tag = OverTag.find(params[:id])
    over_user_type = over_tag.over_user_types.find_by_user_type(session[:user_type])
    
    main_hero_data = over_user_type.heros.where(play_type: session[:play_type], name: "ALL HEROES").first
        
    offense_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "offense").first
    defense_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "defense").first
    rush_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "rush").first
    support_data = over_user_type.hero_groups.where(play_type: session[:play_type], name: "support").first
    
    hero_rank = {}
    sql_ary = []
    con = ActiveRecord::Base.connection
    sql = "SELECT "
    MAIN_RANK_KEY.each do |r_key|
      sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{main_hero_data[r_key]}' ) AS #{r_key}_rank, "
      sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{main_hero_data[r_key]}' and user_type = '#{session[:user_type]}' ) AS #{r_key}_local_rank, "
      
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{offense_data[r_key]}' ) AS offense_#{r_key}_rank, "
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{offense_data[r_key]}' and user_type = '#{session[:user_type]}' ) AS offense_#{r_key}_local_rank, "
      
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{defense_data[r_key]}' ) AS defense_#{r_key}_rank, "
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{defense_data[r_key]}' and user_type = '#{session[:user_type]}' ) AS defense_#{r_key}_local_rank, "
      
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{rush_data[r_key]}' ) AS rush_#{r_key}_rank, "
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{rush_data[r_key]}' and user_type = '#{session[:user_type]}' ) AS rush_#{r_key}_local_rank, "
      
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{support_data[r_key]}' ) AS support_#{r_key}_rank, "
      sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='ALL HEROES' and #{r_key} > '#{support_data[r_key]}' and user_type = '#{session[:user_type]}' ) AS support_#{r_key}_local_rank, "
      # sql_ary.push sql
    end
    # sql = "SELECT " + sql_ary.join(",")
    sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='ALL HEROES' ) AS total_rank, "
    sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='ALL HEROES' and user_type = '#{session[:user_type]}' ) AS total_local_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='offense' ) AS total_offense_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='offense' and user_type = '#{session[:user_type]}' ) AS total_offense_local_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='defense' ) AS total_defense_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='defense' and user_type = '#{session[:user_type]}' ) AS total_defense_local_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='rush' ) AS total_rush_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='rush' and user_type = '#{session[:user_type]}' ) AS total_rush_local_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='support' ) AS total_support_rank, "
    sql += "(SELECT COUNT(id) FROM  hero_groups where play_type = '#{session[:play_type]}' and name='support' and user_type = '#{session[:user_type]}' ) AS total_support_local_rank "
    rank = con.select_all(sql)
    hero_rank["main"] = rank.to_hash[0]

    heros = over_user_type.heros.where(play_type: session[:play_type]).where("name <> ?", "ALL HEROES").order("Time_Played desc").limit(3)
    
    sql_ary = []
    heros.each do |hero|
      sql = ""
      sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' ) AS total_#{hero.id}_rank, "
      sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' and user_type = '#{session[:user_type]}' ) AS total_#{hero.id}_local_rank "
      sql_ary.push sql
      HERO_RANK_KEY.each do |r_key|
        sql = ""        
        sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' and #{r_key} > '#{hero[r_key]}' ) AS #{hero.id}_#{r_key}_rank, "
        sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' and #{r_key} > '#{hero[r_key]}' and user_type = '#{session[:user_type]}' ) AS #{hero.id}_#{r_key}_local_rank "
        sql_ary.push sql
      end
    end
    sql = "SELECT " + sql_ary.join(",")
    rank = con.select_all(sql)
    hero_rank["hero"] = rank.to_hash[0]
    render json: hero_rank
    
  end
  
  def more_hero_get_ranks
    over_tag = OverTag.find(params[:id])
    over_user_type = over_tag.over_user_types.find_by_user_type(session[:user_type])
    
    main_hero_data = over_user_type.heros.where(play_type: session[:play_type], name: "ALL HEROES").first
    
    hero_rank = {}
    sql_ary = []
    heros = over_user_type.heros.where(play_type: session[:play_type]).where("name <> ?", "ALL HEROES").order("Time_Played desc").limit(25).offset(3)
    
    sql_ary = []
    heros.each do |hero|
      sql = ""
      sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' ) AS total_#{hero.id}_rank, "
      sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' and user_type = '#{session[:user_type]}' ) AS total_#{hero.id}_local_rank "
      sql_ary.push sql
      HERO_RANK_KEY.each do |r_key|
        sql = ""        
        sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' and #{r_key} > '#{hero[r_key]}' ) AS #{hero.id}_#{r_key}_rank, "
        sql += "(SELECT COUNT(id) FROM  heros where play_type = '#{session[:play_type]}' and name='#{hero.name}' and #{r_key} > '#{hero[r_key]}' and user_type = '#{session[:user_type]}' ) AS #{hero.id}_#{r_key}_local_rank "
        sql_ary.push sql
      end
    end
    sql = "SELECT " + sql_ary.join(",")
    con = ActiveRecord::Base.connection
    rank = con.select_all(sql)
    hero_rank["hero"] = rank.to_hash[0]
    render json: hero_rank
  end

  # GET /over_tags/1/edit
  def edit
  end

  # POST /over_tags
  # POST /over_tags.json
  def create
    @over_tag = OverTag.new(over_tag_params)

    respond_to do |format|
      if @over_tag.save
        format.html { redirect_to @over_tag, notice: 'Over tag was successfully created.' }
        format.json { render :show, status: :created, location: @over_tag }
      else
        format.html { render :new }
        format.json { render json: @over_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_tags/1
  # PATCH/PUT /over_tags/1.json
  def update
    respond_to do |format|
      if @over_tag.update(over_tag_params)
        format.html { redirect_to @over_tag, notice: 'Over tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_tag }
      else
        format.html { render :edit }
        format.json { render json: @over_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_tags/1
  # DELETE /over_tags/1.json
  def destroy
    @over_tag.destroy
    respond_to do |format|
      format.html { redirect_to over_tags_url, notice: 'Over tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_tag
      @over_tag = OverTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_tag_params
      params.fetch(:over_tag, {})
    end
end
