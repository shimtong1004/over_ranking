class OverDailyDatum < ActiveRecord::Base
  belongs_to :over_user_type
  
  def self.add_data(over_user_type)
    over_user_type_id = over_user_type.id    
    play_types = [1,2]
    play_types.each do |play_type|
      heros = over_user_type.heros.where(play_type: play_type)
      heros.each do |hero|
        games_won = hero[KEY["승리한 게임"]]
        games_played = hero[KEY["치른 게임"]]
        games_lost = games_won - games_won
        games_won_per = hero[KEY["승률"]]
        time_played = hero[KEY["플레이 시간"]]
        eliminations = hero[KEY["처치"]]
        deaths = hero[KEY["죽음"]]
        final_blows = hero[KEY["결정타"]]
        kd = hero["KD"]
        kda = hero["KDA"]
        healing_done_avr = hero[KEY["치유 - 평균"]]
        damage_done_avr = hero[KEY["준 피해 - 평균"]]
        
        over_daily_data = OverDailyDatum.where(over_user_type_id: over_user_type_id, play_type: play_type, hero_name: hero.name).where("created_at >= ? and created_at <= ?", Time.now.beginning_of_day, Time.now.end_of_day)
        unless over_daily_data.blank?
          # 당일 데이터가 존재하면 삭제
          over_daily_data.destroy_all
        end
        
        yesterday_data = OverDailyDatum.where(over_user_type_id: over_user_type_id, play_type: play_type, hero_name: hero.name).where("created_at >= ? and created_at <= ?", Time.now.yesterday.beginning_of_day, Time.now.yesterday.end_of_day).first
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
        
        
        
        
        OverDailyDatum.create(over_user_type_id: over_user_type_id, hero_name: hero.name, play_type: play_type, 
                                  games_won: games_won, games_lost: games_lost, games_played: games_played, games_won_per: games_won_per, time_played: time_played, 
                                  eliminations: eliminations, deaths: deaths, final_blows: final_blows, kd: kd, kda: kda, 
                                  healing_done_avr: healing_done_avr, damage_done_avr: damage_done_avr)
      end
    end
  end
end