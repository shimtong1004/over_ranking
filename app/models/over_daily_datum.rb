class OverDailyDatum < ActiveRecord::Base
  
  def self.add_data(over_user_type)
    play_types = [1,2]
    keyword = "플레이 시간"
    heros_hash = {}
    over_tag_id = over_user_type.over_tag.id
    
    play_types.each do |play_type|
      view_group = "상위 영웅"
      hero_names = over_user_type.over_hero_masters.where(play_type: play_type, keyword: keyword, view_group: view_group).pluck(:hero_name)
      hero_names.each do |hero_name|
        tmp_hash = {}
        view_group = "통계"
        hero_datas = over_user_type.over_hero_masters.where(play_type: play_type, hero_name: hero_name, view_group: view_group)
        hero_datas.each do |hero_data|
          hero_data[""]
          tmp_hash[hero_data.keyword] = hero_data.value
        end
        if tmp_hash["치른 게임"] && tmp_hash["치른 게임"].delete(",").to_i != 0
          games_played = tmp_hash["치른 게임"].delete(",").to_i
          games_won = 0
          games_won = tmp_hash["승리한 게임"].delete(",").to_i if tmp_hash["승리한 게임"]
          
          games_lost = games_played - games_won
          games_won_per = ((games_won.to_f / games_played.to_f) * 100).round(2)
          
          
          time_played = tmp_hash["플레이 시간"]
          
          if time_played.include?("시간")
            time_played = time_played.delete("시간").to_i * 60
          elsif time_played.include?("분")
            time_played = time_played.delete("분").to_i
          elsif time_played.include?("초")
            time_played = 1 #초는 1분으로 계산함
          end
          
          eliminations = tmp_hash["처치"].delete(",").to_i
          deaths = tmp_hash["죽음"].delete(",").to_i
          
          final_blows = 0
          kd = 0
          kda = 0
          #결정타 없음는 영웅 있음. - 메르시
          if tmp_hash["결정타"]
            final_blows = tmp_hash["결정타"].delete(",").to_i
            kd = final_blows / deaths
            kda = eliminations / deaths
          end
          
          
          healing_done_avr = 0
          damage_done_avr = 0
          # 치유없음 - 트레이서/한조/토르비욘/라인하르트/파라...
          healing_done_avr = tmp_hash["치유 - 평균"].delete(",").to_f if tmp_hash["치유 - 평균"]
          damage_done_avr = tmp_hash["준 피해 - 평균"].delete(",").to_f if tmp_hash["준 피해 - 평균"]
          
          
          over_daily_data = OverDailyDatum.where(over_tag_id: over_tag_id, play_type: play_type, hero_name: hero_name).where("created_at >= ? and created_at <= ?", Time.now.beginning_of_day, Time.now.end_of_day)
          unless over_daily_data.blank?
            # 당일 데이터가 존재하면 삭제
            over_daily_data.destroy_all
          end
          yesterday_data = OverDailyDatum.where(over_tag_id: over_tag_id, play_type: play_type, hero_name: hero_name).where("created_at >= ? and created_at <= ?", Time.now.yesterday.beginning_of_day, Time.now.yesterday.end_of_day).first
          if yesterday_data
            games_won -= yesterday_data.games_won
            games_lost -= yesterday_data.games_lost
            games_played -= yesterday_data.games_played
            games_won_per -= yesterday_data.games_won_per
            time_played -= yesterday_data.time_played
            eliminations -= yesterday_data.eliminations
            deaths -= yesterday_data.deaths
            final_blows -= yesterday_data.final_blows
            kd -= yesterday_data.kd
            kda -= yesterday_data.kda
            healing_done_avr -= yesterday_data.healing_done_avr
            damage_done_avr -= yesterday_data.damage_done_avr
          end
          OverDailyDatum.create(over_tag_id: over_tag_id, hero_name: hero_name, play_type: play_type, 
                                games_won: games_won, games_lost: games_lost, games_played: games_played, games_won_per: games_won_per, time_played: time_played, 
                                eliminations: eliminations, deaths: deaths, final_blows: final_blows, kd: kd, kda: kda, 
                                healing_done_avr: healing_done_avr, damage_done_avr: damage_done_avr) if games_played != 0
        end
      end
    end
  end
end