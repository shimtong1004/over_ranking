#encoding: utf-8
class OverTagsController < ApplicationController
  before_action :set_over_tag, only: [:show, :edit, :update, :destroy, :detail, :update_data]
  skip_before_filter :verify_authenticity_token, :only => [:update_data]

  # GET /over_tags
  # GET /over_tags.json
  def index
    # @over_tags = OverTag.all
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
    @status = 200
    @ary_data = []
    hash_data = {}
      
    main_hero_keyword = "플레이 시간"
    view_group = "상위 영웅"
    over_tags.each do |over_tag|
      competitive_rank = over_tag.over_user_types[0].over_hero_masters.where(play_type: 2, keyword: "competitive_rank").first.value
      main_hero_name = over_tag.over_user_types[0].over_hero_masters.where(play_type: session[:play_type], keyword: main_hero_keyword, view_group: view_group).first.hero_name
      main_hero_level = over_tag.over_user_types[0].over_hero_masters.where(play_type: session[:play_type], keyword: "level").first.value
      hash_data["hero_name"] = main_hero_name
      hash_data["main_hero_level"] = main_hero_level
      hash_data["competitive_rank"] = competitive_rank
          
      hero_name = "모든 영웅"
      keyword = ["점수", "폭주 시간 - 평균", "처치", "죽음", "메달", "칭찬 카드", "승리한 게임", "치른 게임", "플레이 시간", "치유 - 평균", "처치 - 평균"]
      datas = over_tag.over_user_types[0].over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, keyword: keyword)
          
          
      datas.each do |data|
        hash_data[data.keyword] = data.value
      end
        
      # hash_data["user_name"] = over_tag.over_profile.username
      # hash_data["avatar"] = over_tag.over_profile.avatar
#           
      # keyword = "region"
      # hash_data["region"] = over_tag.over_user_types[0].over_hero_masters.where(play_type: session[:play_type], keyword: keyword).pluck(:value)
      @ary_data.push hash_data
    end
    @over_tags = over_tags
    render 'show'
  end
  
  def update_data
    over_user_type = @over_tag.over_user_types.find_by_user_type(session[:user_type])
    # OverTag.update_hero_master(over_user_type, session[:play_type])
    OverTag.update_hero_master(over_user_type)
    
    OverDailyDatum.add_data(over_user_type)
    OverUserScore.add_score(over_user_type)
    
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
    @main_hash = {}
    over_user_type = over_tag.over_user_types.find_by_user_type(session[:user_type])
    @over_user_type = over_user_type
    @hero_names = over_user_type.over_hero_masters.where(play_type: session[:play_type], keyword: "플레이 시간", view_group: "상위 영웅").order("id asc").pluck(:hero_name)
    
    
    
    update_time = UpdateLog.where(over_tag_id: @over_tag.id, table_name: "over_hero_master", log_type: "create", sub_name: "#{over_user_type.user_type}").last
    
    unless update_time
      @update_time = UpdateLog.where(over_tag_id: @over_tag.id, table_name: "over_hero_master", log_type: "create", sub_name: nil).last.created_at
      befor_sec = Time.now.utc - @update_time
    else
      @update_time = update_time.created_at
      befor_sec = Time.now.utc - @update_time
    end
    
    if befor_sec < 60
      @update_time = "방금전"
    elsif befor_sec >= 60 && befor_sec < 3600
      @update_time = (befor_sec.to_i / 60).to_s + "분 전"
    elsif befor_sec >= 3600 && befor_sec < 3600 * 24
      @update_time = (befor_sec.to_i / 3600).to_s + "시간 전"
    else
      @update_time = (befor_sec.to_i / (3600*24)).to_s + "일 전"
    end
    
    @competitive_rank = over_user_type.over_hero_masters.where(play_type: 2, keyword: "competitive_rank").first.value
    @level = over_user_type.over_hero_masters.where(play_type: 1, keyword: "level").first.value
    
    @data_hash = {}
    rank_key = ["플레이 시간", "승률", "KD", "KDA",
                "처치 - 평균", "결정타 - 평균", "치유 - 평균", "준 피해 - 평균", "죽음 - 평균", "단독 처치 - 평균", "근접 공격 결정타 - 평균", "임무 기여 처치 - 평균", "폭주 시간 - 평균", "임무 기여 시간 - 평균",
                "처치", "결정타", "단독 처치", "임무 기여 처치", "준 피해", "동시 처치", "근접 공격 결정타", "임무 기여 시간", "폭주 시간", "환경 요소로 처치", 
                "치유", "자가 치유", "처치 시야 지원", "순간이동기 파괴", "죽음", "환경 요소로 죽음"]
    rank_key_size = rank_key.size
    
    hero_group = ["offense", "defense", "rush", "support"]
    
    hero_group.each do |group|
      for i in 0...rank_key_size
        rank_key.push "#{group}_#{rank_key[i]}"
      end
    end
    
    
    hero_rank_key = ["플레이 시간", "처치 - 평균", "준 피해 - 평균", "명중률", "KDA"]
    hero_rank_key.each do |key|
      HERO_NAME_TO_ENG.keys.each do |hero_name|
        rank_key.push "#{hero_name}_#{key}"
      end
    end
    
    datas = over_user_type.over_user_scores.where(play_type: session[:play_type])
    datas.each do |data|
      @data_hash[data.keyword] = data.score
      if rank_key.index(data.keyword)
        @data_hash["#{data.keyword}_rank"] = OverUserScore.where(keyword: data.keyword, play_type: session[:play_type]).where("score > ?", data.score).count + 1
        @data_hash["#{data.keyword}_local_rank"] = OverUserScore.where(keyword: data.keyword, play_type: session[:play_type], user_type: over_user_type.user_type).where("score > ?", data.score).count + 1
      end
    end
    
    @medal_hash = {}
    
    @hero_circle = Hash.new
    hero_img_name = Hash.new
    
    hero_img_name["D.Va"] = ["dva", "#4473ae"]
    hero_img_name["겐지"] = ["genji", "#cc4548"]
    hero_img_name["라인하르트"] = ["reinhardt", "#4473ae"]
    hero_img_name["로드호그"] = ["roadhog", "#4473ae"]
    hero_img_name["루시우"] = ["lucio", "#cc9e45"]
    hero_img_name["리퍼"] = ["reaper", "#cc4548"]
    hero_img_name["맥크리"] = ["mercy", "#cc4548"]
    hero_img_name["메르시"] = ["mccree", "#cc9e45"]
    hero_img_name["메이"] = ["mei", "#96ceb7"]
    hero_img_name["바스티온"] = ["bastion", "#96ceb7"]
    hero_img_name["솔저: 76"] = ["soldier", "#cc4548"]
    hero_img_name["시메트라"] = ["symmetra", "#cc9e45"]
    hero_img_name["위도우메이커"] = ["widow", "#96ceb7"]
    hero_img_name["윈스턴"] = ["winston", "#4473ae"]
    hero_img_name["자리야"] = ["zarya", "#4473ae"]
    hero_img_name["정크랫"] = ["junkrat", "#96ceb7"]
    hero_img_name["젠야타"] = ["zenyatta", "#cc9e45"]
    hero_img_name["토르비욘"] = ["tor", "#96ceb7"]
    hero_img_name["트레이서"] = ["tracer", "#cc4548"]
    hero_img_name["파라"] = ["pharah", "#cc4548"]
    hero_img_name["한조"] = ["hanzo", "#96ceb7"] 
    
    
    total_play_time = @data_hash["플레이 시간"]
    
    @total_count = OverUserType.all.count
    @total_local_count = OverUserType.where(user_type: over_user_type.user_type).count
    
    @local_hero_count = {}
    @hero_count = {}
    @hero_names.each do |hero_name|
       play_time = @data_hash["#{hero_name}_플레이 시간"]
       hero_per = 0
       hero_per = (play_time / total_play_time) * 100 if play_time 
       
       if play_time.to_i >= 60
         play_time = (play_time.to_i / 60).to_s + " 시간"
       else
         play_time = play_time.to_i.to_s + " 분"
       end
       
       @hero_circle["#{hero_name}"] = {img_name: hero_img_name["#{hero_name}"][0], color: ["#959595", "#{hero_img_name["#{hero_name}"][1]}"], hero_per: hero_per, play_time: play_time}
       
       @local_hero_count[hero_name] = OverUserScore.where(keyword: "#{hero_name}_플레이 시간", play_type: session[:play_type], user_type: over_user_type.user_type).where("score <> ?", 0.00).count
       @hero_count[hero_name] = OverUserScore.where(keyword: "#{hero_name}_플레이 시간", play_type: session[:play_type]).where("score <> ?", 0.00).count
    end
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
