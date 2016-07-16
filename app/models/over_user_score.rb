class OverUserScore < ActiveRecord::Base
  belongs_to :over_user_type
  
  def self.add_score(user_type)
    over_user_type_id = user_type.id
    view_group = "통계"
    keywords = ["처치 - 평균", "결정타 - 평균", "치유 - 평균", "준 피해 - 평균", "죽음 - 평균", "단독 처치 - 평균", "근접 공격 결정타 - 평균", "임무 기여 처치 - 평균", "폭주 시간 - 평균", "임무 기여 시간 - 평균", "점수", 
                "처치", "결정타", "단독 처치", "임무 기여 처치", "준 피해", "동시 처치", "근접 공격 결정타", "임무 기여 시간", "폭주 시간", "환경 요소로 처치", 
                "치유", "자가 치유", "처치 시야 지원", "순간이동기 파괴", "죽음", "환경 요소로 죽음", 
                "플레이 시간", "명중률", "승률", "승리한 게임", "치른 게임"]
                
    hero_names = HERO_NAME_TO_ENG.keys
    hero_names.push "모든 영웅"
    play_types = [1,2]
    tmp_hash = {}
    user_type.over_user_scores.destroy_all
    ActiveRecord::Base.transaction do
      play_types.each do |play_type|
        self_healing = 0
        total_hash = self.get_total_hash
        offense_hash = self.get_total_hash
        defense_hash = self.get_total_hash
        rush_hash = self.get_total_hash
        support_hash = self.get_total_hash
        
        hero_names.each do |hero_name|
          hero_datas = user_type.over_hero_masters.where(keyword: keywords, view_group: view_group, hero_name: hero_name, play_type: play_type, over_user_type_id: over_user_type_id)
          
          eliminations = 0
          deaths = 0
          final_blows = 0
          kda = 0
          kd = 0
          
          hero_datas.each do |data|
            value = data.value
            if data.keyword == "플레이 시간"
              if data.value.include?("시간")
                value = data.value.to_i * 60
              elsif data.value.include?("분")
                value = data.value.to_i
              elsif data.value.include?("초")
                value = 1
              end
            end
            
            if data.keyword == "임무 기여 시간 - 평균" || data.keyword ==  "폭주 시간 - 평균"
              tmp = value.split(":")
              min = tmp[0].to_i
              sec = tmp[1].to_i
              value = min * 60 + sec
            end
            
            value = value.to_s
            
            if hero_name == "모든 영웅"
             total_hash[data.keyword] = value.delete(",").to_f if data.keyword && total_hash[data.keyword] #total
            else
              offense_hash[data.keyword] += value.delete(",").to_f if data.keyword && offense_hash[data.keyword] && OFFENSE_HERO.index(hero_name) #공격
              defense_hash[data.keyword] += value.delete(",").to_f if data.keyword && defense_hash[data.keyword] && DEFENSE_HERO.index(hero_name) #수비
              rush_hash[data.keyword] += value.delete(",").to_f if data.keyword && rush_hash[data.keyword] && RUSH_HERO.index(hero_name) #돌격
              support_hash[data.keyword] += value.delete(",").to_f if data.keyword && support_hash[data.keyword] && SUPPORT_HERO.index(hero_name) #지원
              
              OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{hero_name}_#{data.keyword}", score: value.delete(",").to_f)
              eliminations = value.delete(",") if data.keyword == "처치"
              deaths = value.delete(",") if data.keyword == "죽음"
              final_blows = value.delete(",") if data.keyword == "결정타"
              self_healing += value.delete(",").to_i if data.keyword == "자가 치유"
            end
                 
          end
          
          #KDA
          if eliminations != 0 && deaths != 0
            kda = eliminations.to_f / deaths.to_f
            OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{hero_name}_KDA", score: kda)
          end
          
          #KD
          if final_blows != 0 && deaths != 0
            kd = final_blows.to_f / deaths.to_f
            OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{hero_name}_KD", score: kd)
          end
          
          #자가치유
          if self_healing != 0
            kd = final_blows.to_f / deaths.to_f
            OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{hero_name}_자가 치유", score: self_healing)
          end
          
        end
        self.insert_total_data(user_type, total_hash, over_user_type_id, play_type)
        self.insert_total_data(user_type, offense_hash, over_user_type_id, play_type, "offense")
        self.insert_total_data(user_type, defense_hash, over_user_type_id, play_type, "defense")
        self.insert_total_data(user_type, rush_hash, over_user_type_id, play_type, "rush")
        self.insert_total_data(user_type, support_hash, over_user_type_id, play_type, "support")
      end
      
      
    end 
  end
  
  def self.insert_total_data(user_type, total_hash, over_user_type_id, play_type, hero_type=nil)
    keyword_head = ""
    eliminations = 0
    deaths = 0
    final_blows = 0
    
    avr_key = ["처치 - 평균", "결정타 - 평균", "치유 - 평균", "준 피해 - 평균", "죽음 - 평균", "단독 처치 - 평균", "근접 공격 결정타 - 평균", "임무 기여 처치 - 평균", "폭주 시간 - 평균", "임무 기여 시간 - 평균", "승률"]
    view_group = "상위 영웅"
    keyword = "플레이 시간"
    if hero_type == "offense"
      hero_name = OFFENSE_HERO
    elsif hero_type == "defense"
      hero_name = DEFENSE_HERO
    elsif hero_type == "rush"
      hero_name = RUSH_HERO
    elsif hero_type == "support"
      hero_name = SUPPORT_HERO
    else
      hero_name = HERO_NAME_TO_ENG.keys
    end
    hero_cnt = user_type.over_hero_masters.where(play_type: play_type, view_group: view_group, keyword: keyword, hero_name: hero_name).where(" value <> ?", "--").count
     
    total_hash.each do |key, value|
      eliminations += value if key == "처치"
      deaths += value if key == "죽음"
      final_blows += value if key == "결정타"
      value = value.to_f / hero_cnt.to_f if avr_key.index(key) && hero_type
      keyword_head = "#{hero_type}_" if hero_type
      OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{keyword_head}#{key}", score: value)
    end
    
    #KDA
    if eliminations != 0 && deaths != 0
      kda = eliminations.to_f / deaths.to_f
      OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{keyword_head}KDA", score: kda)
    end
            
    #KD
    if final_blows != 0 && deaths != 0
      kd = final_blows.to_f / deaths.to_f
      OverUserScore.create(over_user_type_id: over_user_type_id, user_type: user_type.user_type, play_type: play_type, keyword: "#{keyword_head}KD", score: kd)
    end
  end
  
  def self.get_total_hash
    tmp_hash = {}
    tmp_hash["처치 - 평균"] = 0
    tmp_hash["결정타 - 평균"] = 0
    tmp_hash["치유 - 평균"] = 0
    tmp_hash["준 피해 - 평균"] = 0
    tmp_hash["죽음 - 평균"] = 0
    tmp_hash["단독 처치 - 평균"] = 0
    tmp_hash["근접 공격 결정타 - 평균"] = 0
    tmp_hash["임무 기여 처치 - 평균"] = 0
    tmp_hash["폭주 시간 - 평균"] = 0
    tmp_hash["임무 기여 시간 - 평균"] = 0
    tmp_hash["점수"] = 0
        
    tmp_hash["처치"] = 0
    tmp_hash["결정타"] = 0
    tmp_hash["단독 처치"] = 0
    tmp_hash["임무 기여 처치"] = 0
    tmp_hash["준 피해"] = 0
    tmp_hash["동시 처치"] = 0
    tmp_hash["근접 공격 결정타"] = 0
    tmp_hash["임무 기여 시간"] = 0
    tmp_hash["폭주 시간"] = 0
    tmp_hash["환경 요소로 처치"] = 0
        
    tmp_hash["치유"] = 0
    tmp_hash["자가 치유"] = 0
    tmp_hash["처치 시야 지원"] = 0
    tmp_hash["순간이동기 파괴"] = 0
    tmp_hash["죽음"] = 0
    tmp_hash["환경 요소로 죽음"] = 0
    
    tmp_hash["플레이 시간"] = 0
    tmp_hash["명중률"] = 0
    tmp_hash["승률"] = 0
    tmp_hash["승리한 게임"] = 0
    tmp_hash["치른 게임"] = 0
    
    return tmp_hash
  end
  
  def self.get_hero_hash
    tmp_hash = Hash.new
    tmp_hash["처치 - 평균"] = 0
    tmp_hash["준 피해 - 평균"] = 0
    tmp_hash["처치"] = 0
    tmp_hash["죽음"] = 0
    tmp_hash["플레이 시간"] = 0
    tmp_hash["명중률"] = 0
    tmp_hash["결정타"] = 0
    tmp_hash["자가 치유"] = 0
    tmp_hash["승률"] = 0
    tmp_hash["승리한 게임"] = 0
    tmp_hash["치른 게임"] = 0
    
    return tmp_hash
  end
end
