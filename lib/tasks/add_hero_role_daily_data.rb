#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

play_types = [1, 2]
t = Time.now

search_day = t - 1.days
search_day = t - 0.days


play_types.each do |play_type|
  OFFENSE_HERO.each do |hero|
    hero_data = OverDailyDatum.select("avg(games_won) as games_won, avg(games_lost) as games_lost, 
                                        avg(games_played) as games_played, avg(games_won_per) as games_won_per, sum(time_played) as time_played, 
                                        sum(eliminations) as eliminations, sum(deaths) as deaths, sum(final_blows) as final_blows, 
                                        avg(kd) as kd, avg(kda) as kda,
                                        avg(healing_done_avr) as healing_done_avr, avg(damage_done_avr) as damage_done_avr").
                                        where("hero_name = ? and play_type = ? and created_at between ? and ?", hero, play_type, search_day.beginning_of_day, search_day.end_of_day).first
   OverRoleCalculation.create(hero_name: hero, play_type: play_type, 
                                games_won: hero_data.games_won, games_lost: hero_data.games_lost, games_played: hero_data.games_played, games_won_per: hero_data.games_won_per, time_played: hero_data.time_played,
                                eliminations: hero_data.eliminations, deaths: hero_data.deaths, final_blows: hero_data.final_blows, kd: hero_data.kd, kda: hero_data.kda, 
                                healing_done_avr: hero_data.healing_done_avr, damage_done_avr: hero_data.damage_done_avr)
                                            
  end
  
  DEFENSE_HERO.each do |hero|
    hero_data = OverDailyDatum.select("avg(games_won) as games_won, avg(games_lost) as games_lost, 
                                        avg(games_played) as games_played, avg(games_won_per) as games_won_per, sum(time_played) as time_played, 
                                        sum(eliminations) as eliminations, sum(deaths) as deaths, sum(final_blows) as final_blows, 
                                        avg(kd) as kd, avg(kda) as kda,
                                        avg(healing_done_avr) as healing_done_avr, avg(damage_done_avr) as damage_done_avr").
                                        where("hero_name = ? and play_type = ? and created_at between ? and ?", hero, play_type, search_day.beginning_of_day, search_day.end_of_day).first
   OverRoleCalculation.create(hero_name: hero, play_type: play_type, 
                                games_won: hero_data.games_won, games_lost: hero_data.games_lost, games_played: hero_data.games_played, games_won_per: hero_data.games_won_per, time_played: hero_data.time_played,
                                eliminations: hero_data.eliminations, deaths: hero_data.deaths, final_blows: hero_data.final_blows, kd: hero_data.kd, kda: hero_data.kda, 
                                healing_done_avr: hero_data.healing_done_avr, damage_done_avr: hero_data.damage_done_avr)
  end
  
  RUSH_HERO.each do |hero|
    hero_data = OverDailyDatum.select("avg(games_won) as games_won, avg(games_lost) as games_lost, 
                                        avg(games_played) as games_played, avg(games_won_per) as games_won_per, sum(time_played) as time_played, 
                                        sum(eliminations) as eliminations, sum(deaths) as deaths, sum(final_blows) as final_blows, 
                                        avg(kd) as kd, avg(kda) as kda,
                                        avg(healing_done_avr) as healing_done_avr, avg(damage_done_avr) as damage_done_avr").
                                        where("hero_name = ? and play_type = ? and created_at between ? and ?", hero, play_type, search_day.beginning_of_day, search_day.end_of_day).first
   OverRoleCalculation.create(hero_name: hero, play_type: play_type, 
                                games_won: hero_data.games_won, games_lost: hero_data.games_lost, games_played: hero_data.games_played, games_won_per: hero_data.games_won_per, time_played: hero_data.time_played,
                                eliminations: hero_data.eliminations, deaths: hero_data.deaths, final_blows: hero_data.final_blows, kd: hero_data.kd, kda: hero_data.kda, 
                                healing_done_avr: hero_data.healing_done_avr, damage_done_avr: hero_data.damage_done_avr)
  end
  
  SUPPORT_HERO.each do |hero|
    hero_data = OverDailyDatum.select("avg(games_won) as games_won, avg(games_lost) as games_lost, 
                                        avg(games_played) as games_played, avg(games_won_per) as games_won_per, sum(time_played) as time_played, 
                                        sum(eliminations) as eliminations, sum(deaths) as deaths, sum(final_blows) as final_blows, 
                                        avg(kd) as kd, avg(kda) as kda,
                                        avg(healing_done_avr) as healing_done_avr, avg(damage_done_avr) as damage_done_avr").
                                        where("hero_name = ? and play_type = ? and created_at between ? and ?", hero, play_type, search_day.beginning_of_day, search_day.end_of_day).first
   OverRoleCalculation.create(hero_name: hero, play_type: play_type, 
                                games_won: hero_data.games_won, games_lost: hero_data.games_lost, games_played: hero_data.games_played, games_won_per: hero_data.games_won_per, time_played: hero_data.time_played,
                                eliminations: hero_data.eliminations, deaths: hero_data.deaths, final_blows: hero_data.final_blows, kd: hero_data.kd, kda: hero_data.kda, 
                                healing_done_avr: hero_data.healing_done_avr, damage_done_avr: hero_data.damage_done_avr)
  end
end