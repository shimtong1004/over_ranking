#encoding: utf-8
require 'open-uri'

TIME_OUT = 60
HEROES = ["Roadhog", "Reaper", "Soldier: 76", "Reinhardt", "Tracer", "Genji", "L&#xFA;cio", "McCree", "Pharah", "Junkrat", "Widowmaker", "Mei", "Zarya", "Zenyatta", "Hanzo", "Mercy", "Torbj&#xF6;rn", "Symmetra", "Winston", "Bastion", "D.Va"]

class OverTag < ActiveRecord::Base
  has_many :over_user_types
  has_many :update_logs
  
  # after_create :create_log_data
  # after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.id, table_name: "over_tag", log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.id, table_name: "over_tag", log_type: "update")
  end
  
  def self.create_hero_from_bnet(tag, over_tag_id)
    tag.gsub!(/#/, '-')
    
    urls = [
          "https://playoverwatch.com/en-us/career/pc/kr/#{tag}",
          "https://playoverwatch.com/en-us/career/pc/eu/#{tag}",
          "https://playoverwatch.com/en-us/career/pc/us/#{tag}"
          ]
    
    region = ""
    html_ary = []
    user_type_id_ary = []
    user_type_hash = {}
    max_thread = 3 # 최대 스레드수
    ary_threads = []
    locker = Mutex::new
    # max_thread로 설정한수의 스레드로 시작
    max_thread.times do |i|
      ary_threads << Thread.start { # 스레드 작성
        loop do
          url = locker.synchronize { urls.pop } # url을 뽑아냄. 병합처리를 위해 synchronize사용.
          break unless url # url이 더이상 루프 없으면 종료
          uri = Addressable::URI.parse(url)
          url = uri.normalize.to_s
          begin
            html = open(url).read
            html_ary.push html
            if html.include?("pc/kr")
              user_type = "PC - KR"
            elsif html.include?("pc/us")
              user_type = "PC - US"
            elsif html.include?("pc/eu")
              user_type = "PC - EU"
            end
            over_user_type = OverUserType.where(over_tag_id: over_tag_id, user_type: user_type).first
            over_user_type = OverUserType.create(over_tag_id: over_tag_id, user_type: user_type) unless over_user_type
            user_type_id_ary.push over_user_type.id
            user_type_hash[over_user_type.id] = [over_user_type.id, user_type]
          rescue
          end
        end
      }
    end
    ary_threads.each { |th| th.join }
    # user_type_id_ary.each do |id|
      # self.create_test(id)  
    # end
      user_type_id_ary.each_with_index do |user_type_id, i|
        html = html_ary[i]
        ActiveRecord::Base.transaction do
          doc = Nokogiri::HTML(html)
          play_types = []
          play_types.push id: 1, value:"quick-play"
          play_types.push id: 2, value:"competitive-play"
          
          
          level = doc.css(".u-vertical-center").text
          competitive_rank = doc.css(".competitive-rank").text
          
          play_types.each do |play_type|
            play_type_id = play_type[:id]
            play_type_str = play_type[:value]
            #quick-play 일반
            play_type_doc = doc.css("##{play_type_str}")
            
            #통계 start
            # view_group = play_type_doc.css(".content-box.page-wrapper.career-stats-section .h3.header").text
            stats = play_type_doc.css(".content-box.page-wrapper.career-stats-section .js-stats.toggle-display")
            stats_names =  play_type_doc.css(".content-box.page-wrapper.career-stats-section .js-career-select option")
            
            stats.each_with_index do |data, i|
              hero_name = stats_names[i].text
              hero_data = Hero.new
              hero_data["level"] = level.to_i
              hero_data["competitive_rank"] = competitive_rank.to_i
              hero_data.over_user_type_id = user_type_id
              hero_data.play_type = play_type_id
              hero_data.name = hero_name
              tables = data.css(".column.xs-12.md-6.xl-4.margin-xs.margin-no-sides table")
              tables.each do |table|
                view_group_detail = table.css("thead tr").text
                trs = table.css("tbody tr")
                  trs.each do |tr|
                  keyword = tr.css("td")[0].text
                  next if keyword.start_with?("overwatch.guid")
                  value = tr.css("td")[1].text
                  
                  if value.include?("hours")
                    value = value.to_i * 60
                  elsif value.include?("minutes")
                    value = value.to_i
                  elsif value.include?("seconds")
                    value = 1
                  end
                  
                  value = value.to_s.delete(",").to_f
                  
                  keyword.gsub!(' - ', '_')
                  keyword.gsub!('-', '_')
                  keyword.gsub!(' ', '_')
                  keyword = self.chk_keyword(keyword)
                  
                  hero_data[keyword] = value.to_f
                end
              end
              
              #main_hero_name
              hero_sort_data = play_type_doc.css(".progress-category.toggle-display")[0]
              hero_name = hero_sort_data.css(".bar-text .title")[0].text
              hero_data["main_hero_name"] = hero_name
              
              
              hero_data["KD"] = hero_data["Final_Blows"] / hero_data["Deaths"] if hero_data["Final_Blows"] != 0 && hero_data["Deaths"] != 0
              hero_data["KDA"] = hero_data["Eliminations"] / hero_data["Deaths"] if  hero_data["Eliminations"] != 0 && hero_data["Deaths"] != 0
              hero_data["user_type"] = user_type_hash[user_type_id][1]
              hero_data.save 
            end
          end
        end
      end
    
  end
  
  
  
  def self.update_hero_from_bnet(over_user_type)
    tag = over_user_type.over_tag.tag
    tag.gsub!(/#/, '-')
    
    user_type = over_user_type.user_type
    user_type_id = over_user_type.id
    if user_type == "PC - KR"
      region = "pc/kr"
    elsif user_type == "PC - US"
      region = "pc/us"
    elsif user_type == "PC - EU"
      region = "pc/eu"
    end
    url = "https://playoverwatch.com/en-us/career/#{region}/#{tag}"
    uri = Addressable::URI.parse(url)
    url = uri.normalize.to_s
    html = open(url).read
    
    ActiveRecord::Base.transaction do
      doc = Nokogiri::HTML(html)
      play_types = []
      play_types.push id: 1, value:"quick-play"
      play_types.push id: 2, value:"competitive-play"
      
      level = doc.css(".u-vertical-center").text
      competitive_rank = doc.css(".competitive-rank").text
        
      play_types.each do |play_type|
        play_type_id = play_type[:id]
        play_type_str = play_type[:value]
        #quick-play 일반
        play_type_doc = doc.css("##{play_type_str}")
          
        #통계 start
        # view_group = play_type_doc.css(".content-box.page-wrapper.career-stats-section .h3.header").text
        stats = play_type_doc.css(".content-box.page-wrapper.career-stats-section .js-stats.toggle-display")
        stats_names =  play_type_doc.css(".content-box.page-wrapper.career-stats-section .js-career-select option")
          
          
        stats.each_with_index do |data, i|
            hero_name = stats_names[i].text
            
            over_user_type = OverUserType.find(user_type_id)
            over_user_type.heros.where(play_type: play_type_id, name: hero_name)
            hero_data = over_user_type.heros.where(play_type: play_type_id, name: hero_name).first
            hero_data["level"] = level.to_i
            hero_data["competitive_rank"] = competitive_rank.to_i
            
            
            tables = data.css(".column.xs-12.md-6.xl-4.margin-xs.margin-no-sides table")
            tables.each do |table|
              view_group_detail = table.css("thead tr").text
              trs = table.css("tbody tr")
                trs.each do |tr|
                keyword = tr.css("td")[0].text
                next if keyword.start_with?("overwatch.guid")
                value = tr.css("td")[1].text
                
                if value.include?("hours")
                  value = value.to_i * 60
                elsif value.include?("minutes")
                  value = value.to_i
                elsif value.include?("seconds")
                  value = 1
                end
                
                value = value.to_s.delete(",").to_f
                
                keyword.gsub!(' - ', '_')
                keyword.gsub!('-', '_')
                keyword.gsub!(' ', '_')
                keyword = self.chk_keyword(keyword)
                
                hero_data[keyword] = value.to_f
              end
            end
            
            #main_hero_name
            hero_sort_data = play_type_doc.css(".progress-category.toggle-display")[0]
            hero_name = hero_sort_data.css(".bar-text .title")[0].text
            hero_data["main_hero_name"] = hero_name
            
            
            hero_data["KD"] = hero_data["Final_Blows"] / hero_data["Deaths"] if hero_data["Final_Blows"] != 0 && hero_data["Deaths"] != 0
            hero_data["KDA"] = hero_data["Eliminations"] / hero_data["Deaths"] if  hero_data["Eliminations"] != 0 && hero_data["Deaths"] != 0
            hero_data.save
        end
      end
    end
  end
  
  def self.set_data(tag)
    
    over_tag = OverTag.find_by_tag(tag)
    unless over_tag
      tag_ary = tag.split("#")
      over_tag = OverTag.create(tag: tag, tag_name: tag_ary[0])
    end
    
    unless over_tag.data_updated_at
      OverTag.create_hero_from_bnet(tag, over_tag.id)
      user_types = over_tag.over_user_types
      user_types.each do |user_type|
        HeroGroup.set_group_data(user_type)
        OverDailyDatum.add_data(user_type)
      end
      over_tag.update(data_updated_at: Time.now)
    end
    return over_tag.id
    
    
  end

  def self.get_tag_from_inven(max_cnt)
    max = max_cnt
    while max
      begin
        url = "http://www.inven.co.kr/board/powerbbs.php?come_idx=4679&l=#{max.to_s}"
        
        html = open(url).read
        doc = Nokogiri::HTML(html)
          
        if doc.css("#powerbbsContent").size > 1
          content = doc.css("#powerbbsContent")[1].children
        else
          content = doc.css("#powerbbsContent").children
        end
        
        tmp_arys = content.to_s.delete("\t\n\r").split(/[;,<,>,\s,\xc2\xa0]/)
        tmp_arys.each do |t|
          if t.include?("#")
            break if t.include?('=')
            #aaa#23434aaa#23455 의 경우
            if t.count("#") != 1
              t_ary = t.split("#")
              t = t_ary[0] + "#" + t_ary[1]
            end
                
            i = t.index('#')
            break if i == 0
            break if t[i+1].to_i.to_s != t[i+1]
                
            chk_flg = false
            chk_cnt = 0
            while 1
              if t[-1].to_i.to_s == t[-1]
                chk_flg = true
                break
              else
                t = t[0..-2]
                chk_cnt += 1
                break if chk_cnt > 20
              end
            end
                
            if chk_flg
              over_tag = OverTag.find_by_tag(t)
              OverTag.create(tag: t, site_url: url) unless over_tag
            end
          end
        end
        max = max - 1
        break if max==0
      rescue
      end
    end
  end
  
  def self.chk_keyword(keyword)
    case keyword
      when "Melee_Final_Blow_Most_in_Game" then
        keyword = "Melee_Final_Blows_Most_in_Game"
      when "Teleporter_Pad_Destroyed" then
        keyword = "Teleporter_Pads_Destroyed"
      when "Elimination" then
        keyword = "Eliminations"
      when "Elimination_Most_in_Life" then
        keyword = "Eliminations_Most_in_Life"
      when "Elimination_Most_in_Game" then
        keyword = "Eliminations_Most_in_Game"
      when "Environmental_Death" then
        keyword = "Environmental_Deaths"
      when "Multikill" then
        keyword = "Multikills"
      when "Melee_Final_Blow" then
        keyword = "Melee_Final_Blows"
      when "Environmental_Kill" then
        keyword = "Environmental_Kills"
      when "Card" then
        keyword = "Cards"
      when "Final_Blow" then
        keyword = "Final_Blows"  
      when "Solo_Kill" then
        keyword = "Solo_Kills"
      when "Final_Blow_Most_in_Game" then
        keyword = "Final_Blows_Most_in_Game"
      when "Solo_Kill_Most_in_Game" then
        keyword = "Solo_Kills_Most_in_Game"
      when "Recon_Assist" then
        keyword = "Recon_Assists"
      when "Pulse_Bomb_Kill" then
        keyword = "Pulse_Bomb_Kills"
      when "Pulse_Bomb_Kill_Most_in_Game" then
        keyword = "Pulse_Bomb_Kills_Most_in_Game"
      when "Pulse_Bomb_Attached_Most_in_Game" then
        keyword = "Pulse_Bombs_Attached_Most_in_Game"
      when "Pulse_Bomb_Attached" then
        keyword = "Pulse_Bombs_Attached"
      when "Critical_Hit" then
        keyword = "Critical_Hits"
      when "Critical_Hit_Most_in_Game" then
        keyword = "Critical_Hits_Most_in_Game"
      when "Critical_Hit_Most_in_Life" then
        keyword = "Critical_Hits_Most_in_Life"
      when "Recon_Assist_Most_in_Game" then
        keyword = "Recon_Assists_Most_in_Game"
      when "Objective_Kill" then
        keyword = "Objective_Kills"
      when "Elimination_per_Life" then
        keyword = "Eliminations_per_Life"
      when "Objective_Kill_Most_in_Game" then
        keyword = "Objective_Kills_Most_in_Game"
      when "Death" then
        keyword = "Deaths"
      when "RIP_Tire_Kill_Most_in_Game" then
        keyword = "RIP_Tire_Kills_Most_in_Game"
      when "RIP_Tire_Kill" then
        keyword = "RIP_Tire_Kills"
      when "Primal_Rage_Kills__Average" then
        keyword = "Primal_Rage_Kills_Average"
      when "Blaster_Kills" then
        keyword = "Blaster_Kill"
      when "Blaster_Kills_Most_in_Game" then
        keyword = "Blaster_Kill_Most_in_Game"
      when "Offensive_Assist_Most_in_Game" then
        keyword = "Offensive_Assists_Most_in_Game"
      when "Self_Destruct_Kill_Most_in_Game" then
        keyword = "Self_Destruct_Kills_Most_in_Game"
      when "Self_Destruct_Kill" then
        keyword = "Self_Destruct_Kills"
      when "Enemy_Slept" then
        keyword = "Enemies_Slept"
      when "Torbjörn_Kill" then
        keyword = "Torbjörn_Kills"
      when "Torbjörn_Kill_Most_in_Game" then
        keyword = "Torbjörn_Kills_Most_in_Game"
      when "Molten_Core_Kill" then
        keyword = "Molten_Core_Kills"
      when "Molten_Core_Kill_Most_in_Game" then
        keyword = "Molten_Core_Kills_Most_in_Game"
      when "Sentry_Kill" then
        keyword = "Sentry_Kills"
      when "Sentry_Kill_Most_in_Game" then
        keyword = "Sentry_Kills_Most_in_Game"
      when "Sentry_Turret_Kill" then
        keyword = "Sentry_Turret_Kills"
      when "Sentry_Turret_Kill_Most_in_Game" then
        keyword = "Sentry_Turret_Kills_Most_in_Game"
      when "Fan_the_Hammer_Kill_Most_in_Game" then
        keyword = "Fan_the_Hammer_Kills_Most_in_Game"
      when "Offensive_Assist" then
        keyword = "Offensive_Assists"
      when "Offensive_Assist_Most_in_Game" then
        keyword = "Offensive_Assists_Most_in_Game"
      when "Fire_Strike_Kill" then
        keyword = "Fire_Strike_Kills"
      when "Fire_Strike_Kill_Most_in_Game" then
        keyword = "Fire_Strike_Kills_Most_in_Game"
      when "Earthshatter_Kill" then
        keyword = "Earthshatter_Kills"
      when "Earthshatter_Kill_Most_in_Game" then
        keyword = "Earthshatter_Kills_Most_in_Game"
      when "Venom_Mine_Kill" then
        keyword = "Venom_Mine_Kills"
      when "Venom_Mine_Kill_Most_in_Game" then
        keyword = "Venom_Mine_Kills_Most_in_Game"
      when "Player_Knocked_Back" then
        keyword = "Players_Knocked_Back"
      when "Player_Knocked_Back_Most_in_Game" then
        keyword = "Players_Knocked_Back_Most_in_Game"
      when "Defensive_Assist" then
        keyword = "Defensive_Assists"
      when "Defensive_Assist_Most_in_Game" then
        keyword = "Defensive_Assists_Most_in_Game"
      when "Jump_Pack_Kill" then
        keyword = "Jump_Pack_Kills"
      when "Jump_Pack_Kill_Most_in_Game" then
        keyword = "Jump_Pack_Kills_Most_in_Game"
      when "Fan_the_Hammer_Kill" then
        keyword = "Fan_the_Hammer_Kills"
      when "Fan_the_Hammer_Kill_Most_in_Game" then
        keyword = "Fan_the_Hammer_Kills_Most_in_Game"
      when "Melee_Kill" then
        keyword = "Melee_Kills"
      when "Melee_Kill_Most_in_Game" then
        keyword = "Melee_Kills_Most_in_Game"
      when "Recon_Kill" then
        keyword = "Recon_Kills"
      when "Recon_Kill_Most_in_Game" then
        keyword = "Recon_Kills_Most_in_Game"
      when "Enemie_Trapped_Most_in_Game" then
        keyword = "Enemies_Trapped_Most_in_Game"
      when "Enemie_Trapped" then
        keyword = "Enemies_Trapped"
      when "Charge_Kill" then
        keyword = "Charge_Kills"
      when "Charge_Kill_Most_in_Game" then
        keyword = "Charge_Kills_Most_in_Game"
        
      when "Mech_Called" then
        keyword = "Mechs_Called"
      when "Mech_Called_Most_in_Game" then
        keyword = "Mechs_Called_Most_in_Game"
      when "Blizzard_Kill_Most_in_Game" then
        keyword = "Blizzard_Kills_Most_in_Game"
      when "Blizzard_Kill" then
        keyword = "Blizzard_Kills"
      when "Scoped_Critical_Hit" then
        keyword = "Scoped_Critical_Hits"
      when "Scoped_Critical_Hit_Most_in_Game" then
        keyword = "Scoped_Critical_Hits_Most_in_Game"
      when "Primal_Rage_Kill_Most_in_Game" then
        keyword = "Primal_Rage_Kills_Most_in_Game"
      when "Primal_Rage_Kill_Most_in_Game" then
        keyword = "Primal_Rage_Kills_Most_in_Game"
      when "Dragonblade_Kill" then
        keyword = "Dragonblade_Kills"
      when "Dragonblade_Kill_Most_in_Game" then
        keyword = "Dragonblade_Kills_Most_in_Game"
      when "Player_Resurrected" then
        keyword = "Players_Resurrected"
      when "Player_Resurrected_Most_in_Game" then
        keyword = "Players_Resurrected_Most_in_Game"
      when "Primal_Rage_Kill" then
        keyword = "Primal_Rage_Kills"
      when "Primal_Rage_Kill_Most_in_Game" then
        keyword = "Primal_Rage_Kills_Most_in_Game"
      when "Death_Blossom_Kill_Most_in_Game" then
        keyword = "Death_Blossom_Kills_Most_in_Game"
      when "Death_Blossom_Kill" then
        keyword = "Death_Blossom_Kills"
      when "Player_Teleported" then
        keyword = "Players_Teleported"
      when "Player_Teleported_Most_in_Game" then
        keyword = "Players_Teleported_Most_in_Game"
      when "Shield_Provided" then
        keyword = "Shields_Provided"
      when "Shield_Provided_Most_in_Game" then
        keyword = "Shields_Provided_Most_in_Game"
      when "Soul_Consumed" then
        keyword = "Souls_Consumed"
      when "Soul_Consumed_Most_in_Game" then
        keyword = "Souls_Consumed_Most_in_Game"
      when "Nano_Boost_Assist" then
        keyword = "Nano_Boost_Assists"
      when "Nano_Boost_Assist_Most_in_Game" then
        keyword = "Nano_Boost_Assists_Most_in_Game"
      when "Dragonstrike_Kill" then
        keyword = "Dragonstrike_Kills"
      when "Dragonstrike_Kill_Most_in_Game" then
        keyword = "Dragonstrike_Kills_Most_in_Game"
      when "Tank_Kill_Most_in_Game" then
        keyword = "Tank_Kills_Most_in_Game"
      when "Tank_Kill" then
        keyword = "Tank_Kills"
      when "Whole_Hog_Kill_Most_in_Game" then
        keyword = "Whole_Hog_Kills_Most_in_Game"
      when "Whole_Hog_Kill" then
        keyword = "Whole_Hog_Kills"
      when "Lifetime_Graviton_Surge_Kill" then
        keyword = "Lifetime_Graviton_Surge_Kills"
      when "Graviton_Surge_Kill_Most_in_Game" then
        keyword = "Graviton_Surge_Kills_Most_in_Game"
      when "Graviton_Surge_Kill" then
        keyword = "Graviton_Surge_Kills"
      when "High_Energy_Kill_Most_in_Game" then
        keyword = "High_Energy_Kills_Most_in_Game"
      when "High_Energy_Kill" then
        keyword = "High_Energy_Kills"
      when "Scatter_Arrow_Kill" then
        keyword = "Scatter_Arrow_Kills"
      when "Scatter_Arrow_Kill_Most_in_Game" then
        keyword = "Scatter_Arrow_Kills_Most_in_Game"
      when "Nano_Boost_Applied" then
        keyword = "Nano_Boosts_Applied"
      when "Enemie_Frozen_Most_in_Game" then
        keyword = "Enemies_Frozen_Most_in_Game"
      when "Enemie_Frozen" then
        keyword = "Enemies_Frozen"
      when "Mech_Death" then
        keyword = "Mech_Deaths"
      when "Turret_Kill" then
        keyword = "Turret_Kills"
      when "Armor_Pack_Created" then
        keyword = "Armor_Packs_Created"
        
        
        
        
        
        
        
        
        
      when "" then
        keyword = ""
        
        
        
        
        
        
        
        
        
    end
    return keyword
  end
  
  def self.create_test(over_user_type_id)
    columns = Hero.column_names
    over_user_type = OverUserType.find(6)
    over_user_type.heros.each do |hero|
      her = Hero.new
      columns.each do |col|
        if col == "main_hero_name" || col == "name" || col == "play_type" || col == "user_type"
          her[col] = hero[col]
        elsif col == "id" || col == "is_update"
        elsif col == "over_user_type_id"
          her[col] = over_user_type_id
        else
          her[col] = hero[col]
        end
      end
      her.save
    end
  end
  
  
  def self.test
    columns = Hero.column_names
    over_user_type = OverUserType.last
    (0...100000).each do |cnt|
      over_user_type.heros.each do |hero|
        her = Hero.new
        columns.each do |col|
          if col == "main_hero_name" || col == "name" || col == "play_type" || col == "user_type"
            her[col] = hero[col]
          elsif col == "id" || col == "is_update"
          else
            her[col] = hero[col] + cnt.to_f + 1.to_f
          end
        end
        her.save
      end
    end
  end
  
  def self.test2
    columns = Hero.column_names
    over_user_type = OverUserType.last
    (100001...200000).each do |cnt|
      over_user_type.heros.each do |hero|
        her = Hero.new
        columns.each do |col|
          if col == "main_hero_name" || col == "name" || col == "play_type" || col == "user_type"
            her[col] = hero[col]
          elsif col == "id" || col == "is_update"
          else
            her[col] = hero[col] + cnt.to_f + 1.to_f
          end
        end
        her.save
      end
    end
  end
  
  def self.test3
    columns = Hero.column_names
    over_user_type = OverUserType.last
    (200001...300000).each do |cnt|
      over_user_type.heros.each do |hero|
        her = Hero.new
        columns.each do |col|
          if col == "main_hero_name" || col == "name" || col == "play_type" || col == "user_type"
            her[col] = hero[col]
          elsif col == "id" || col == "is_update"
          else
            her[col] = hero[col] + cnt.to_f + 1.to_f
          end
        end
        her.save
      end
    end
  end
  
  def self.test4
    over_user_type = OverUserType.find(1)
    (0...1000000).each do |cnt|
      OverTag.create
    end
  end

end








