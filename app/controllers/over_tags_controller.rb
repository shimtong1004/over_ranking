#encoding: utf-8
class OverTagsController < ApplicationController
  @@offense = ["겐지", "리퍼" , "맥크리", "솔저: 76", "트레이서", "파라"] #공격
  @@defense = ["메이", "바스티온", "위도우메이커", "정크랫", "토르비욘", "한조"] #수비
  @@rush = ["D.Va", "라인하르트", "로드호그", "윈스턴", "자리야"] #돌격
  @@support = ["루시우", "메르시", "시메트라", "젠야타"] #지원
  before_action :set_over_tag, only: [:show, :edit, :update, :destroy, :detail]

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
    tag = params[:tag]
    
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
      main_hero_name = over_tag.over_user_types[0].over_hero_masters.where(play_type: 1, keyword: main_hero_keyword, view_group: view_group).first.hero_name
      hash_data["hero_name"] = main_hero_name
      hash_data["hero_avatar"] = OverHeroAvatar.find_by_hero_name(main_hero_name).avatar
          
      hero_name = "모든 영웅"
      keyword = ["점수", "폭주 시간 - 평균", "처치", "죽음", "메달", "칭찬 카드", "승리한 게임", "치른 게임", "플레이 시간"]
      datas = over_tag.over_user_types[0].over_hero_masters.where(play_type: 1, hero_name: hero_name, keyword: keyword)
          
          
      datas.each do |data|
        hash_data[data.keyword] = data.value
      end
        
      hash_data["user_name"] = over_tag.over_profile.username
      hash_data["avatar"] = over_tag.over_profile.avatar
          
      keyword = "region"
      hash_data["region"] = over_tag.over_user_types[0].over_hero_masters.where(play_type: 1, keyword: keyword).pluck(:value)
      @ary_data.push hash_data
    end
    @over_tags = over_tags
    render 'show'
  end
  
  def detail
    over_tag = @over_tag
    
    @main_hash = {}
    over_user_type = over_tag.over_user_types.find_by_user_type(params[:user_type])
    hero_name = "모든 영웅"      
    main_datas = over_user_type.over_hero_masters.where(play_type: 1, hero_name: hero_name)
    main_datas.each do |main_data|
      @main_hash[main_data.keyword] = main_data.value
    end
    
    @heros_hash = {}
    keyword = "플레이 시간"
    view_group = "상위 영웅"
    @hero_names = over_user_type.over_hero_masters.where(play_type: 1, keyword: keyword, view_group: view_group).pluck(:hero_name)
    view_group = "통계"
    @hero_names.each do |hero_name|
      tmp_hash = {}
      hero_datas = over_user_type.over_hero_masters.where(play_type: 1, hero_name: hero_name, view_group: view_group)
      hero_datas.each do |hero_data|
        tmp_hash[hero_data.keyword] = hero_data.value
      end
      @heros_hash[hero_name] = tmp_hash
    end
    
    @main_hash["main_hero"] = @hero_names[0]
    @main_hash["level"] = over_user_type.over_hero_masters.where(play_type: 1, keyword: "level").first.value
    
    @offense_play_time = 0
    @defense_play_time = 0
    @rush_play_time = 0
    @support_play_time = 0
    
    # 자가치유
    @self_healing = 0
    # 지원
    # 방어지원
    # 공격지원
    # 순간이동기 파괴
    @teleporter_destroyed = 0
    # 포탑파괴
    @turrets_destroyed = 0
    
    offense_game_count = 0
    defense_game_count = 0
    rush_game_count = 0
    support_game_count = 0
    
    offense_win_game_count = 0
    defense_win_game_count = 0
    rush_win_game_count = 0
    support_win_game_count = 0
    
    offense_kill = 0
    defense_kill = 0
    rush_kill = 0
    support_kill = 0
    
    offense_death = 0
    defense_death = 0
    rush_death = 0
    support_death = 0
    
    
    
    @hero_names.each do |name|
      if @heros_hash[name]["플레이 시간"].include?("시간")
        tmp_time = @heros_hash[name]["플레이 시간"].to_i * 60
      elsif @heros_hash[name]["플레이 시간"].include?("분")
        tmp_time = @heros_hash[name]["플레이 시간"].to_i
      end
      
      tmp_game_count = @heros_hash[name]["치른 게임"].delete(",").to_i if @heros_hash[name]["치른 게임"]
      tmp_win_game_count = @heros_hash[name]["승리한 게임"].delete(",").to_i if @heros_hash[name]["승리한 게임"]
      
      tmp_death = @heros_hash[name]["죽음"].delete(",").to_i if @heros_hash[name]["죽음"]
      tmp_kill = @heros_hash[name]["처치"].delete(",").to_i if @heros_hash[name]["처치"]
      
      #자가치유
      if @heros_hash[name]["자가 치유"]
        tmp_self_healing = @heros_hash[name]["자가 치유"].delete(",").to_i
        @self_healing += tmp_self_healing
      end
      
      #순간이동기 파괴
      if @heros_hash[name]["순간이동기 파괴"]
        tmp_teleporter_destroyed = @heros_hash[name]["순간이동기 파괴"].delete(",").to_i
        @teleporter_destroyed += tmp_teleporter_destroyed
      end
      
      # 포탑 파괴
      if @heros_hash[name]["포탑 파괴"]
        tmp_turrets_destroyed = @heros_hash[name]["포탑 파괴"].delete(",").to_i
        @turrets_destroyed += tmp_turrets_destroyed
      end
      
      
      
      
      if @@offense.any? {|word| name.include?(word)}
        @offense_play_time += tmp_time
        offense_game_count += tmp_game_count
        offense_win_game_count += tmp_win_game_count
        offense_kill = tmp_kill
        offense_death = tmp_death
        
      elsif @@defense.any? {|word| name.include?(word)}
        @defense_play_time += tmp_time
        defense_game_count += tmp_game_count
        defense_win_game_count += tmp_win_game_count
        defense_kill += tmp_kill
        defense_death += tmp_death
      elsif @@rush.any? {|word| name.include?(word)}
        @rush_play_time += tmp_time
        rush_game_count += tmp_game_count
        rush_win_game_count += tmp_win_game_count
        rush_kill += tmp_kill
        rush_death += tmp_death
      elsif @@support.any? {|word| name.include?(word)}
        @support_play_time += tmp_time
        support_game_count += tmp_game_count
        support_win_game_count += tmp_win_game_count
        support_kill += tmp_kill
        support_death += tmp_death
      end
    end
    
    if @offense_play_time >= 60
      @offense_play_time = (@offense_play_time.to_i/60).to_s + "H" 
    else
      @offense_play_time = @offense_play_time.to_s + "m"
    end
    
    if @defense_play_time >= 60
      @defense_play_time = (@defense_play_time.to_i/60).to_s + "H" 
    else
      @defense_play_time = @defense_play_time.to_s + "m"
    end
    
    if @rush_play_time >= 60
      @rush_play_time = (@rush_play_time.to_i/60).to_s + "H" 
    else
      @rush_play_time = @rush_play_time.to_s + "m"
    end
    
    if @support_play_time >= 60
      @support_play_time = (@support_play_time.to_i/60).to_s + "H" 
    else
      @support_play_time = @support_play_time.to_s + "m"
    end
    
    @offense_win_per = (offense_win_game_count.to_f / offense_game_count.to_f).round(2) * 100
    @defense_win_per = (defense_win_game_count.to_f / defense_game_count.to_f).round(2) * 100
    @rush_win_per = (rush_win_game_count.to_f / rush_game_count.to_f).round(2) * 100
    @support_win_per = (support_win_game_count.to_f / support_game_count.to_f).round(2) * 100
    
    @offense_kd = (offense_kill.to_f / offense_death.to_f).round(2)
    @defense_kd = (defense_kill.to_f / defense_death.to_f).round(2)
    @rush_kd = (rush_kill.to_f / rush_death.to_f).round(2)
    @support_kd = (support_kill.to_f / support_death.to_f).round(2)
    

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
