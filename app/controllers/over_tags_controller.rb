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
      
      hash_data["hero_avatar"] = OverHeroAvatar.find_by_hero_name(main_hero_name).avatar
          
      hero_name = "모든 영웅"
      keyword = ["점수", "폭주 시간 - 평균", "처치", "죽음", "메달", "칭찬 카드", "승리한 게임", "치른 게임", "플레이 시간", "치유 - 평균", "처치 - 평균"]
      datas = over_tag.over_user_types[0].over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, keyword: keyword)
          
          
      datas.each do |data|
        hash_data[data.keyword] = data.value
      end
        
      hash_data["user_name"] = over_tag.over_profile.username
      hash_data["avatar"] = over_tag.over_profile.avatar
          
      keyword = "region"
      hash_data["region"] = over_tag.over_user_types[0].over_hero_masters.where(play_type: session[:play_type], keyword: keyword).pluck(:value)
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
    @hero_names.each do |hero_name|
       medal = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, keyword: "메달 - 금", view_group: "통계").first
       @medal_hash[hero_name] = 0
       @medal_hash[hero_name] = medal.value.to_i if medal
       play_time = @data_hash["#{hero_name}_플레이 시간"]
       hero_per = 0
       hero_per = (play_time / total_play_time) * 100 if play_time 
       
       if play_time.to_i >= 60
         play_time = (play_time.to_i / 60).to_s + " 시간"
       else
         play_time = play_time.to_i.to_s + " 분"
       end
       
       @hero_circle["#{hero_name}"] = {img_name: hero_img_name["#{hero_name}"][0], color: ["#959595", "#{hero_img_name["#{hero_name}"][1]}"], hero_per: hero_per, play_time: play_time}
    end
    
    
    
    
    
    
    
    
    
    
    
    
    # @played_time = over_user_type.over_user_scores.where(keyword: "플레이 시간", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @played_time_rank = over_user_type.over_user_scores.where(keyword: "플레이 시간", user_type: over_user_type.user_type, play_type: session[:play_type]).where("score >= ?", @played_time.score).count + 1
    # @played_time_kr_rank = over_user_type.over_user_scores.where(keyword: "플레이 시간", user_type: over_user_type.user_type, play_type: session[:play_type], user_type: "PC - KR").where("score >= ?", @played_time.score).count + 1
#     
    # @offense_kd = over_user_type.over_user_scores.where(keyword: "offense_KD", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @offense_won_per = over_user_type.over_user_scores.where(keyword: "offense_승률", user_type: over_user_type.user_type, play_type: session[:play_type]).first
#     
    # @support_kd = over_user_type.over_user_scores.where(keyword: "support_KD", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @support_won_per = over_user_type.over_user_scores.where(keyword: "support_승률", user_type: over_user_type.user_type, play_type: session[:play_type]).first
#     
    # @rush_kd = over_user_type.over_user_scores.where(keyword: "rush_KD", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @rush_won_per = over_user_type.over_user_scores.where(keyword: "rush_승률", user_type: over_user_type.user_type, play_type: session[:play_type]).first
#     
    # @defense_kd = over_user_type.over_user_scores.where(keyword: "defense_KD", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @defense_won_per = over_user_type.over_user_scores.where(keyword: "defense_승률", user_type: over_user_type.user_type, play_type: session[:play_type]).first
#     
    # @won_per = over_user_type.over_user_scores.where(keyword: "승률", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @won_per_kr_rank = over_user_type.over_user_scores.where(keyword: "승률", user_type: over_user_type.user_type, play_type: session[:play_type], user_type: "PC - KR").where("score >= ?", @won_per.score).count + 1
    # @won_per_rank = over_user_type.over_user_scores.where(keyword: "승률", user_type: over_user_type.user_type, play_type: session[:play_type]).where("score >= ?", @won_per.score).count + 1
#     
#     
    # @won = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: "모든 영웅", keyword: "승리한 게임", view_group: "통계").first.value
    # @played_count = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: "모든 영웅", keyword: "치른 게임", view_group: "통계").first
    # @lost = @played_count.value.to_i - @won.to_i
#     
#     
    # @kd = over_user_type.over_user_scores.where(keyword: "KD", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @kd_kr_rank = over_user_type.over_user_scores.where(keyword: "KD", user_type: over_user_type.user_type, play_type: session[:play_type], user_type: "PC - KR").where("score >= ?", @kd.score).count + 1
    # @kd_rank = over_user_type.over_user_scores.where(keyword: "KD", user_type: over_user_type.user_type, play_type: session[:play_type]).where("score >= ?", @kd.score).count + 1
#     
    # @kda = over_user_type.over_user_scores.where(keyword: "KDA", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @kda_kr_rank = over_user_type.over_user_scores.where(keyword: "KDA", user_type: over_user_type.user_type, play_type: session[:play_type], user_type: "PC - KR").where("score >= ?", @kda.score).count + 1
    # @kda_rank = over_user_type.over_user_scores.where(keyword: "KDA", user_type: over_user_type.user_type, play_type: session[:play_type]).where("score >= ?", @kda.score).count + 1
#     
    # @final_blows = over_user_type.over_user_scores.where(keyword: "결정타", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @deaths = over_user_type.over_user_scores.where(keyword: "죽음", user_type: over_user_type.user_type, play_type: session[:play_type]).first
    # @eliminations = over_user_type.over_user_scores.where(keyword: "처치", user_type: over_user_type.user_type, play_type: session[:play_type]).first
#     
    # @hero_names = over_user_type.over_hero_masters.where(play_type: session[:play_type], keyword: "플레이 시간", view_group: "상위 영웅").order("id asc").pluck(:hero_name)
#     
#     
    # @heros_ary = []
    # heros_hash = {}
    # @hero_names.each do |hero_name|
      # heros_hash["치른 게임"] = 0
      # games_played = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, keyword: "치른 게임", view_group: "통계").first
#       
      # if games_played
        # heros_hash["플레이 시간"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_플레이 시간", play_type: session[:play_type]).first.score
        # heros_hash["승률"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_승률", play_type: session[:play_type]).first.score
        # heros_hash["승리한 게임"] = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, keyword: "승리한 게임", view_group: "통계").first.value.to_i
        # heros_hash["치른 게임"] = games_played.value.to_i if games_played
        # heros_hash["진 게임"] = heros_hash["치른 게임"] - heros_hash["승리한 게임"]
        # heros_hash["패배율"] = 100.0 - heros_hash["승률"]
        # heros_hash["메달 - 금"] = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, keyword: "메달 - 금", view_group: "통계").first.value.to_i
        # heros_hash["처치 - 평균"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_처치 - 평균", play_type: session[:play_type]).first.score
        # heros_hash["eliminations_rank"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_처치 - 평균", play_type: session[:play_type]).where("score >= ?", heros_hash["처치 - 평균"]).count + 1
        # heros_hash["eliminations_kr_rank"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_처치 - 평균", play_type: session[:play_type], user_type: over_user_type.user_type).where("score >= ?", heros_hash["처치 - 평균"]).count + 1
#         
        # heros_hash["준 피해 - 평균"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_준 피해 - 평균", play_type: session[:play_type]).first.score
        # heros_hash["준 피해 - 평균"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_준 피해 - 평균", play_type: session[:play_type]).where("score >= ?", heros_hash["준 피해 - 평균"]).count + 1
        # heros_hash["준 피해 - 평균"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_준 피해 - 평균", play_type: session[:play_type], user_type: over_user_type.user_type).where("score >= ?", heros_hash["준 피해 - 평균"]).count + 1
#         
        # heros_hash["명중률"] = "-"
        # heros_hash["명중률_rank"] = "-"
        # heros_hash["명중률_kr_rank"] = "-"
        # weapon_accuracy = over_user_type.over_user_scores.where(keyword: "#{hero_name}_명중률", play_type: session[:play_type]).first
        # if weapon_accuracy
          # heros_hash["명중률"] = weapon_accuracy.score
          # heros_hash["명중률_rank"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_명중률", play_type: session[:play_type]).where("score >= ?", heros_hash["명중률"]).count + 1
          # heros_hash["명중률_kr_rank"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_명중률", play_type: session[:play_type], user_type: over_user_type.user_type).where("score >= ?", heros_hash["명중률"]).count + 1
        # end
#          
#         
        # heros_hash["kda"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_KDA", play_type: session[:play_type]).first.score
        # heros_hash["kda_rank"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_KDA", play_type: session[:play_type]).where("score >= ?", heros_hash["KDA"]).count + 1
        # heros_hash["kda_kr_rank"] = over_user_type.over_user_scores.where(keyword: "#{hero_name}_KDA", play_type: session[:play_type], user_type: over_user_type.user_type).where("score >= ?", heros_hash["KDA"]).count + 1
      # end
      # @heros_ary.push heros_hash
    # end
#     
    # @eliminations_avg = over_user_type.over_user_scores.where(keyword: "처치 - 평균", play_type: session[:play_type]).first.score
    # @final_blows_avg = over_user_type.over_user_scores.where(keyword: "결정타 - 평균", play_type: session[:play_type]).first.score
    # @healings_avg = over_user_type.over_user_scores.where(keyword: "치유 - 평균", play_type: session[:play_type]).first.score
    # @damages_avg  = over_user_type.over_user_scores.where(keyword: "준 피해 - 평균", play_type: session[:play_type]).first.score
    # @deaths_avr = over_user_type.over_user_scores.where(keyword: "죽음 - 평균", play_type: session[:play_type]).first.score
    # @solo_kills_avg = over_user_type.over_user_scores.where(keyword: "단독 처치 - 평균", play_type: session[:play_type]).first.score
    # @melee_final_blows_avg = over_user_type.over_user_scores.where(keyword: "근접 공격 결정타 - 평균", play_type: session[:play_type]).first.score
    # @objective_kills_avg = over_user_type.over_user_scores.where(keyword: "임무 기여 처치 - 평균", play_type: session[:play_type]).first.score
    # @time_spent_fire_avg = over_user_type.over_user_scores.where(keyword: "폭주 시간 - 평균", play_type: session[:play_type]).first.score
    # @objective_time_avg = over_user_type.over_user_scores.where(keyword: "임무 기여 시간 - 평균", play_type: session[:play_type]).first.score
    # @score = "-"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    # hero_name = "모든 영웅"
    # main_datas = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name)
    # main_datas.each do |main_data|
      # @main_hash[main_data.keyword] = main_data.value
    # end
#     
    # @heros_hash = {}
    # keyword = "플레이 시간"
    # view_group = "상위 영웅"
    # @hero_names = over_user_type.over_hero_masters.where(play_type: session[:play_type], keyword: keyword, view_group: view_group).order("id asc").pluck(:hero_name)
    # view_group = "통계"
    # @hero_names.each do |hero_name|
      # tmp_hash = {}
      # hero_datas = over_user_type.over_hero_masters.where(play_type: session[:play_type], hero_name: hero_name, view_group: view_group)
      # hero_datas.each do |hero_data|
        # tmp_hash[hero_data.keyword] = hero_data.value
      # end
      # @heros_hash[hero_name] = tmp_hash
    # end
#     
    # @main_hash["main_hero"] = @hero_names[0]
    # @main_hash["level"] = over_user_type.over_hero_masters.where(play_type: session[:play_type], keyword: "level").first.value
#     
    # @offense_play_time = 0
    # @defense_play_time = 0
    # @rush_play_time = 0
    # @support_play_time = 0
#     
    # # 자가치유
    # @self_healing = 0
    # # 지원
    # # 방어지원
    # # 공격지원
    # # 순간이동기 파괴
    # @teleporter_destroyed = 0
    # # 포탑파괴
    # @turrets_destroyed = 0
#     
    # offense_game_count = 0
    # defense_game_count = 0
    # rush_game_count = 0
    # support_game_count = 0
#     
    # offense_win_game_count = 0
    # defense_win_game_count = 0
    # rush_win_game_count = 0
    # support_win_game_count = 0
#     
    # offense_kill = 0
    # defense_kill = 0
    # rush_kill = 0
    # support_kill = 0
#     
    # offense_finishing_blow = 0
    # defense_finishing_blow = 0
    # rush_finishing_blow = 0
    # support_finishing_blow = 0
#     
#     
    # offense_death = 0
    # defense_death = 0
    # rush_death = 0
    # support_death = 0
    # tmp_time = 0
#     
#     
    # @hero_circle = Hash.new
    # hero_img_name = Hash.new
#     
#     
#     
    # hero_img_name["D.Va"] = ["dva", "#4473ae"]
    # hero_img_name["겐지"] = ["genji", "#cc4548"]
    # hero_img_name["라인하르트"] = ["reinhardt", "#4473ae"]
    # hero_img_name["로드호그"] = ["roadhog", "#4473ae"]
    # hero_img_name["루시우"] = ["lucio", "#cc9e45"]
    # hero_img_name["리퍼"] = ["reaper", "#cc4548"]
    # hero_img_name["맥크리"] = ["mercy", "#cc4548"]
    # hero_img_name["메르시"] = ["mccree", "#cc9e45"]
    # hero_img_name["메이"] = ["mei", "#96ceb7"]
    # hero_img_name["바스티온"] = ["bastion", "#96ceb7"]
    # hero_img_name["솔저: 76"] = ["soldier", "#cc4548"]
    # hero_img_name["시메트라"] = ["symmetra", "#cc9e45"]
    # hero_img_name["위도우메이커"] = ["widow", "#96ceb7"]
    # hero_img_name["윈스턴"] = ["winston", "#4473ae"]
    # hero_img_name["자리야"] = ["zarya", "#4473ae"]
    # hero_img_name["정크랫"] = ["junkrat", "#96ceb7"]
    # hero_img_name["젠야타"] = ["zenyatta", "#cc9e45"]
    # hero_img_name["토르비욘"] = ["tor", "#96ceb7"]
    # hero_img_name["트레이서"] = ["tracer", "#cc4548"]
    # hero_img_name["파라"] = ["pharah", "#cc4548"]
    # hero_img_name["한조"] = ["hanzo", "#96ceb7"]
#     
#     
#     
    # total_play_time_min = 0
    # @hero_names.each do |name|
      # if @heros_hash[name]["플레이 시간"] == nil
      # elsif @heros_hash[name]["플레이 시간"].include?("시간")
        # tmp_time = @heros_hash[name]["플레이 시간"].to_i * 60
      # elsif @heros_hash[name]["플레이 시간"].include?("분")
        # tmp_time = @heros_hash[name]["플레이 시간"].to_i
      # elsif @heros_hash[name]["플레이 시간"].include?("초")
        # tmp_time = 1
      # end
      # total_play_time_min += tmp_time
    # end
#     
    # @hero_names.each do |name|
      # if @heros_hash[name]["플레이 시간"] == nil
      # elsif @heros_hash[name]["플레이 시간"].include?("시간")
        # tmp_time = @heros_hash[name]["플레이 시간"].to_i * 60
      # elsif @heros_hash[name]["플레이 시간"].include?("분")
        # tmp_time = @heros_hash[name]["플레이 시간"].to_i
      # elsif @heros_hash[name]["플레이 시간"].include?("초")
        # tmp_time = 1
      # end
#       
      # if tmp_time != 0 && total_play_time_min != 0
        # hero_per = (tmp_time.to_f / total_play_time_min.to_f) * 100
      # else
        # hero_per = 0
      # end
      # @heros_hash["#{name}"]["플레이 시간"] = nil if @heros_hash["#{name}"]["플레이 시간"] == "--"
      # unless @heros_hash["#{name}"]["플레이 시간"]
        # play_time = "-"
      # else
        # play_time2 = @heros_hash["#{name}"]["플레이 시간"]
        # play_time = play_time2.split(" ")[0].to_i.to_s + " "  + play_time2.split(" ")[1]
      # end
#       
      # @hero_circle["#{name}"] = {img_name: hero_img_name["#{name}"][0], color: ["#959595", "#{hero_img_name["#{name}"][1]}"], hero_per: hero_per, play_time: play_time}
#       
#       
      # tmp_game_count = 0
      # tmp_win_game_count = 0
      # tmp_death = 0
      # tmp_kill = 0
      # tmp_finishing_blow = 0
      # tmp_game_count = @heros_hash[name]["치른 게임"].delete(",").to_i if @heros_hash[name]["치른 게임"]
      # tmp_win_game_count = @heros_hash[name]["승리한 게임"].delete(",").to_i if @heros_hash[name]["승리한 게임"]
      # tmp_death = @heros_hash[name]["죽음"].delete(",").to_i if @heros_hash[name]["죽음"]
      # tmp_kill = @heros_hash[name]["처치"].delete(",").to_i if @heros_hash[name]["처치"]
      # tmp_finishing_blow = @heros_hash[name]["결정타"].delete(",").to_i if @heros_hash[name]["결정타"]
#       
#       
      # #자가치유
      # if @heros_hash[name]["자가 치유"]
        # tmp_self_healing = @heros_hash[name]["자가 치유"].delete(",").to_i
        # @self_healing += tmp_self_healing
      # end
#       
      # #순간이동기 파괴
      # if @heros_hash[name]["순간이동기 파괴"]
        # tmp_teleporter_destroyed = @heros_hash[name]["순간이동기 파괴"].delete(",").to_i
        # @teleporter_destroyed += tmp_teleporter_destroyed
      # end
#       
      # # 포탑 파괴
      # if @heros_hash[name]["포탑 파괴"]
        # tmp_turrets_destroyed = @heros_hash[name]["포탑 파괴"].delete(",").to_i
        # @turrets_destroyed += tmp_turrets_destroyed
      # end
#       
      # if OFFENSE_HERO.any? {|word| name.include?(word)}
        # @offense_play_time += tmp_time
        # offense_game_count += tmp_game_count
        # offense_win_game_count += tmp_win_game_count
        # offense_kill += tmp_kill
        # offense_finishing_blow += tmp_finishing_blow
        # offense_death += tmp_death
#         
      # elsif DEFENSE_HERO.any? {|word| name.include?(word)}
        # @defense_play_time += tmp_time
        # defense_game_count += tmp_game_count
        # defense_win_game_count += tmp_win_game_count
        # defense_kill += tmp_kill
        # defense_finishing_blow += tmp_finishing_blow
        # defense_death += tmp_death
      # elsif RUSH_HERO.any? {|word| name.include?(word)}
        # @rush_play_time += tmp_time
        # rush_game_count += tmp_game_count
        # rush_win_game_count += tmp_win_game_count
        # rush_kill += tmp_kill
        # rush_finishing_blow += tmp_finishing_blow
        # rush_death += tmp_death
      # elsif SUPPORT_HERO.any? {|word| name.include?(word)}
        # @support_play_time += tmp_time
        # support_game_count += tmp_game_count
        # support_win_game_count += tmp_win_game_count
        # support_kill += tmp_kill
        # support_finishing_blow += tmp_finishing_blow
        # support_death += tmp_death
      # end
    # end
#     
#     
    # @offense_play_time_min = @offense_play_time
    # if @offense_play_time >= 60
      # @offense_play_time = (@offense_play_time.to_i/60).to_s + "H"  
    # else
      # @offense_play_time = @offense_play_time.to_s + "m"
    # end
#     
    # @defense_play_time_min = @defense_play_time
    # if @defense_play_time >= 60
      # @defense_play_time = (@defense_play_time.to_i/60).to_s + "H" 
    # else
      # @defense_play_time = @defense_play_time.to_s + "m"
    # end
#     
    # @rush_play_time_min = @rush_play_time
    # if @rush_play_time >= 60
      # @rush_play_time = (@rush_play_time.to_i/60).to_s + "H" 
    # else
      # @rush_play_time = @rush_play_time.to_s + "m"
    # end
#     
    # @support_play_time_min = @support_play_time
    # if @support_play_time >= 60
      # @support_play_time = (@support_play_time.to_i/60).to_s + "H" 
    # else
      # @support_play_time = @support_play_time.to_s + "m"
    # end
#     
    # @offense_win_per = (offense_win_game_count.to_f / offense_game_count.to_f).round(2) * 100
    # @defense_win_per = (defense_win_game_count.to_f / defense_game_count.to_f).round(2) * 100
    # @rush_win_per = (rush_win_game_count.to_f / rush_game_count.to_f).round(2) * 100
    # @support_win_per = (support_win_game_count.to_f / support_game_count.to_f).round(2) * 100
#     
    # @offense_win_per = 0 if @offense_win_per.nan?
    # @defense_win_per = 0 if @defense_win_per.nan?
    # @rush_win_per = 0 if @rush_win_per.nan?
    # @support_win_per = 0 if @support_win_per.nan?
    # # @offense_kda = (offense_kill.to_f / offense_death.to_f).round(2)
    # # @defense_kda = (defense_kill.to_f / defense_death.to_f).round(2)
    # # @rush_kda = (rush_kill.to_f / rush_death.to_f).round(2)
    # # @support_kda = (support_kill.to_f / support_death.to_f).round(2)
#     
    # @offense_kd = (offense_finishing_blow.to_f / offense_death.to_f).round(2)
    # @defense_kd = (defense_finishing_blow.to_f / defense_death.to_f).round(2)
    # @rush_kd = (rush_finishing_blow.to_f / rush_death.to_f).round(2)
    # @support_kd = (support_finishing_blow.to_f / support_death.to_f).round(2)
#     
    # @total_play_time_min = total_play_time_min
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
