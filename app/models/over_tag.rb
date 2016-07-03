#encoding: utf-8
require 'open-uri'

TIME_OUT = 60
HEROES = ["Roadhog", "Reaper", "Soldier: 76", "Reinhardt", "Tracer", "Genji", "L&#xFA;cio", "McCree", "Pharah", "Junkrat", "Widowmaker", "Mei", "Zarya", "Zenyatta", "Hanzo", "Mercy", "Torbj&#xF6;rn", "Symmetra", "Winston", "Bastion", "D.Va"]

class OverTag < ActiveRecord::Base
  has_one :over_all_hero
  has_one :over_profile
  
  has_one :over_hero_bastion
  has_one :over_hero_dva
  has_one :over_hero_genji
  has_one :over_hero_hanzo
  has_one :over_hero_junkrat
  has_one :over_hero_lucio
  has_one :over_hero_mc_cree
  has_one :over_hero_mei
  has_one :over_hero_mercy
  has_one :over_hero_pharah
  has_one :over_hero_reaper
  has_one :over_hero_reinhardt
  has_one :over_hero_roadhog
  has_one :over_hero_soldier76
  has_one :over_hero_symmetra
  has_one :over_hero_torbjoern
  has_one :over_hero_tracer
  has_one :over_hero_widowmaker
  has_one :over_hero_winston
  has_one :over_hero_zarya
  has_one :over_hero_zenyattum
  
  has_many :over_heros
  has_many :over_user_types
  has_many :update_logs
  
  after_create :create_log_data
  after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.id, table_name: "over_tag", log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.id, table_name: "over_tag", log_type: "update")
  end
  
  def self.set_data_from_bnet(tag, over_tag_id)
    tag.gsub!(/#/, '-')
    
    urls = [
          "https://playoverwatch.com/ko-kr/career/pc/kr/#{tag}",
          "https://playoverwatch.com/ko-kr/career/pc/eu/#{tag}",
          "https://playoverwatch.com/ko-kr/career/pc/us/#{tag}"
          ]
    
    region = ""
    html_ary = []
    user_type_id_ary = []
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
            user_type = OverUserType.create(over_tag_id: over_tag_id, user_type: user_type)
            user_type_id_ary.push user_type.id
          rescue
          end
        end
      }
    end
    ary_threads.each { |th| th.join }
    
    ActiveRecord::Base.transaction do
      user_type_id_ary.each_with_index do |user_type_id, i|
        html = html_ary[i]
        # OverHeroMaster.create(over_user_type_id: user_type_id, keyword: "user_type", value: user_type)
        
        doc = Nokogiri::HTML(html)
        play_types = []
        play_types.push id: 1, value:"quick-play"
        play_types.push id: 2, value:"competitive-play"
        
        
        
        play_types.each do |play_type|
          play_type_id = play_type[:id]
          play_type_str = play_type[:value]
          
          #level
          level = doc.css(".u-vertical-center").text
          keyword = "level"
          OverHeroMaster.create(over_user_type_id: user_type_id, play_type: play_type_id, keyword: keyword, value: level)
          
          #quick-play 일반
          play_type_doc = doc.css("##{play_type_str}")
          # 주요통계
          
          view_group = play_type_doc.css(".content-box.page-wrapper.highlights-section .h3.header").text
          for i in 0...8
            value = play_type_doc.css(".content-box.page-wrapper.highlights-section .card-heading")[i].text
            keyword = play_type_doc.css(".content-box.page-wrapper.highlights-section .card-copy")[i].text
            OverHeroMaster.create(over_user_type_id: user_type_id, play_type: play_type_id, keyword: keyword, value: value, view_group: view_group)
          end
          
          
          
          
          #상위영웅 start
          view_group = play_type_doc.css(".content-box.page-wrapper.hero-comparison-section .h3.header").text
          
          heroes_sort_condition = play_type_doc.css(".content-box.page-wrapper.hero-comparison-section .js-career-select option")
          hero_sort_datas = play_type_doc.css(".progress-category.toggle-display")
          
          heroes_sort_condition.each_with_index do |sort_condition, hero_sort_index|
            keyword = sort_condition.text
            hero_sort_data = hero_sort_datas[hero_sort_index]
            for i in 0...21
              hero_name = hero_sort_data.css(".bar-text .title")[i].text
              value = hero_sort_data.css(".bar-text .description")[i].text
              OverHeroMaster.create(over_user_type_id: user_type_id, play_type: play_type_id, hero_name: hero_name, keyword: sort_condition.text, value: value, view_group: view_group)
            end
          end
          #상위영웅 end
          
          #통계 start
          view_group = play_type_doc.css(".content-box.page-wrapper.career-stats-section .h3.header").text
          stats = play_type_doc.css(".content-box.page-wrapper.career-stats-section .js-stats.toggle-display")
          stats_names =  play_type_doc.css(".content-box.page-wrapper.career-stats-section .js-career-select option")
          
          
          stats.each_with_index do |data, i|
            hero_name = stats_names[i].text
            tables = data.css(".column.xs-12.md-6.xl-4.margin-xs.margin-no-sides table")
            tables.each do |table|
              view_group_detail = table.css("thead tr").text
              trs = table.css("tbody tr")
                trs.each do |tr|
                keyword = tr.css("td")[0].text
                value = tr.css("td")[1].text
                OverHeroMaster.create(over_user_type_id: user_type_id, play_type: play_type_id, hero_name: hero_name, keyword: keyword, value: value, view_group: view_group, view_group_detail: view_group_detail)
              end
            end
          end
          #통계 end
        end        
      end
    end
    UpdateLog.create(over_tag_id: over_tag_id, table_name: "over_hero_master", log_type: "create")
    
    return region
    
  end
  
  # def self.set_data_from_bnet(tag, over_tag_id)
    # tag.gsub!(/#/, '-')
    # url = "https://playoverwatch.com/ko-kr/career/pc/kr/#{tag}"
    # uri = Addressable::URI.parse(url)
    # url = uri.normalize.to_s
#     
    # html = open(url).read
    # doc = Nokogiri::HTML(html)
#     
    # # 주요통계
    # ActiveRecord::Base.transaction do
      # view_group = doc.css("#highlights-section h1").text
      # for i in 0...8
        # value = doc.css(".card-heading")[i].text
        # keyword = doc.css(".card-copy")[i].text
        # OverHeroMaster.create(over_tag_id: over_tag_id, keyword: keyword, value: value, view_group: view_group)
      # end
#       
      # #상위영웅 start
      # view_group = doc.css("#top-heroes-section h1").text
#       
      # heroes_sort_condition = doc.css("#top-heroes-section .js-career-select option")
      # hero_sort_datas = doc.css(".progress-category.toggle-display")
#       
      # heroes_sort_condition.each_with_index do |sort_condition, hero_sort_index|
        # keyword = sort_condition.text
        # hero_sort_data = hero_sort_datas[hero_sort_index]
        # for i in 0...21
          # hero_name = hero_sort_data.css(".bar-text .title")[i].text
          # value = hero_sort_data.css(".bar-text .description")[i].text
          # OverHeroMaster.create(over_tag_id: over_tag_id, hero_name: hero_name, keyword: sort_condition.text, value: value, view_group: view_group)
        # end
      # end
      # #상위영웅 end    
#       
      # #통계 start
      # stats = doc.css(".js-stats.toggle-display")
      # stats_names =  doc.css(".js-career-select")[1].css("option")
      # view_group = doc.css("#stats-section h1").text
#       
#       
      # stats.each_with_index do |data, i|
        # hero_name = stats_names[i].text
        # tables = data.css(".column.xs-12.md-6.xl-4.margin-xs.margin-no-sides table")
        # tables.each do |table|
          # view_group_detail = table.css("thead tr").text
          # trs = table.css("tbody tr")
            # trs.each do |tr|
            # keyword = tr.css("td")[0].text
            # value = tr.css("td")[1].text
            # OverHeroMaster.create(over_tag_id: over_tag_id, hero_name: hero_name, keyword: keyword, value: value, view_group: view_group, view_group_detail: view_group_detail)
          # end
        # end
      # end
    # end
    # UpdateLog.create(over_tag_id: over_tag_id, table_name: "over_hero_master", log_type: "create")
  # end
  
  def self.set_data(tag)
    over_tag = OverTag.find_by_tag(tag)
    unless over_tag
      tag_ary = tag.split("#")
      over_tag = OverTag.create(tag: tag, tag_name: tag_ary[0])
    end
    
    hero_master_data = over_tag.update_logs.where(table_name: "over_hero_master", log_type: "create")
    
    OverTag.set_data_from_bnet(tag, over_tag.id) if hero_master_data.blank?
    
    if over_tag.over_user_types[0].user_type == "PC - KR"
      region = "pc/kr"
    elsif over_tag.over_user_types[0].user_type == "PC - US"
      region = "pc/us"
    elsif over_tag.over_user_types[0].user_type == "PC - EU"
      region = "pc/eu"
    end
    
    over_profile = over_tag.over_profile
    unless over_profile
      self.get_profile(tag, over_tag.id, region)
    end
    
    return over_tag.id
  end
  
  # def self.set_data(tag)
    # over_tag = OverTag.find_by_tag(tag)
    # if over_tag
      # over_all_hero = over_tag.over_all_hero
      # over_profile = over_tag.over_profile
      # over_heros = over_tag.over_heros.where(name: HEROES)
#       
      # self.get_main_data(over_all_hero, over_profile, over_heros, tag, over_tag.id)
#       
      # # unless over_all_hero
        # # get_allHeroes(tag, over_tag.id)
      # # end
#       
#       
      # # unless over_profile
        # # get_profile(tag, over_tag.id)
      # # end
#       
#       
      # # get_heroes(tag, over_tag.id) if over_heros.size != 21
#       
    # else
      # over_tag = OverTag.create(tag: tag)
      # self.get_main_data(over_all_hero, over_profile, over_heros, tag, over_tag.id)
#     
      # # get_profile(tag, over_tag.id)
      # # get_allHeroes(tag, over_tag.id)
      # # get_heroes(tag, over_tag.id)
    # end
    # # get_platforms(tag, over_tag.id)
#     
    # return over_tag.id
  # end
  
  def self.set_detail_data(over_tag)
    # get_achievement(tag, over_tag.id)
    if over_tag.update_logs.where(table_name: "over_hero_common", log_type: "create").size == 21
    else
      get_hero(over_tag.tag, over_tag.id)
    end
  end
  
  def self.set_all_data(tag)
    over_tag = OverTag.find_by_tag(tag)    
    over_tag = OverTag.create(tag: tag) unless over_tag
    
    get_achievement(tag, over_tag.id)
    
    over_profile = OverProfile.where(over_tag_id: over_tag.id)
    get_profile(tag, over_tag.id) if over_profile.blank?
    
    over_hero = OverHero.where(over_tag_id: over_tag.id)
    get_heroes(tag, over_tag.id) if over_hero.blank?
    
    get_hero(tag, over_tag.id)
    
    over_all_hero = OverAllHero.where(over_tag_id: over_tag.id)
    get_allHeroes(tag, over_tag.id) if over_all_hero.blank?
    # get_platforms(tag, over_tag.id)
    
    return over_tag
  end
  
  def self.set_sub_data(over_tag)
    p "-----------------#{over_tag.id}-----------------------"
    tag = over_tag.tag
    
    get_achievement(tag, over_tag.id)
    over_profile = OverProfile.where(over_tag_id: over_tag.id)
    get_profile(tag, over_tag.id) if over_profile.blank?
    
    
    get_heroes(tag, over_tag.id)
    
    get_hero(tag, over_tag.id)
    
    over_all_hero = OverAllHero.where(over_tag_id: over_tag.id)
    get_allHeroes(tag, over_tag.id) if over_all_hero.blank?
    # get_platforms(tag, over_tag.id)
  end
  
  def self.get_achievement(tag, tag_id)
    begin
      timeout(TIME_OUT) {
        # tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
        url = "https://api.lootbox.eu/pc/kr/#{tag}/achievements"
        uri = Addressable::URI.parse(url)
        url = uri.normalize.to_s
        # url.gsub!(/%/, '%25')
        
        data = JSON.load(open(url))
        if data["statusCode"] != 404
          finished_achievements = data["finishedAchievements"]
          data["achievements"].each do |d|
            name = d["name"]
            over_achievment = OverAchievement.where(over_tag_id: tag_id, name: name)
            if over_achievment.blank?
              finished = d["finished"]
              image = d["image"]
              OverAchievement.create(over_tag_id: tag_id, finishedAchievements: finished_achievements, name: name, finished: finished, image: image)
            end
          end
          return 200
        else
          return 404
        end
      }
    rescue
    end 
  end
  
  def self.get_profile(tag, tag_id, region)
      tag.gsub!(/#/, '-')
      url = "https://api.lootbox.eu/#{region.downcase}/#{tag}/profile"
      uri = Addressable::URI.parse(url)
      url = uri.normalize.to_s
      # url.gsub!(/%/, '%25')
        
      data = JSON.load(open(url))
      if data["statusCode"] != 404
        data = data["data"]
        user_name = data["username"]
        level = data["level"]
        playtime = data["playtime"]
        avatar = data["avatar"]
          
        d = data["games"]
        win_percentage = d["win_percentage"]
        wins = d["wins"]
        lost = d["lost"]
        played = d["played"]
          
        OverProfile.create(over_tag_id: tag_id, username: user_name, level: level, playtime: playtime, avatar: avatar, win_percentage: win_percentage, wins: wins, lost: lost, played: played)
        return 200
      else
        return 404
      end
  end
  
  def self.get_platforms(tag, tag_id)
    begin
      timeout(TIME_OUT) {
        #tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
        url = "https://api.lootbox.eu/pc/kr/#{tag}/get-platforms"
        uri = Addressable::URI.parse(url)
        url = uri.normalize.to_s
        # url.gsub!(/%/, '%25')
        
        data = JSON.load(open(url))
        if data["statusCode"] != 404
          profile = data["profile"]
          profile.each do |p|
            platform = p["platform"]
            region = p["region"]
            has_account = p["hasAccount"]
            OverPlatform.create(over_tag_id: tag_id, platform: platform, region: region, hasAccount: has_account)
          end
          return 200
        else
          return 404
        end
    }
    rescue
    end
    
  end
  
  def self.get_heroes(tag, tag_id)
    begin
      timeout(TIME_OUT) {
        #tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
        url = "https://api.lootbox.eu/pc/kr/#{tag}/heroes"
        uri = Addressable::URI.parse(url)
        url = uri.normalize.to_s
        # url.gsub!(/%/, '%25')
        data = JSON.load(open(url))
        if data.class.eql?(Array)
          data.each do |d|
            name = d["name"]
            over_hero = OverHero.where(over_tag_id: tag_id, name: name)
            if over_hero.blank?
              playtime = d["playtime"]
            
              if playtime.end_with?("1 hour")
                playtime_min = 60
              elsif playtime.end_with?("hours")
                hour = playtime.split(" ")[0].to_i
                playtime_min = hour * 60
              elsif playtime.end_with?("minutes") 
                min = playtime.split(" ")[0].to_i
                playtime_min = min
              end
              
              image = d["image"]
              percentage = d["percentage"]
              
              OverHero.create(over_tag_id: tag_id, name: name, playtime: playtime, playtime_min: playtime_min, image: image, percentage: percentage)
            end
          end
          return 200
        else
          return 404
        end
      }
    rescue
    end
    
  end
  
  def self.get_hero(tag, tag_id)
    tag.gsub!(/#/, '-')
    
    urls = [
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Roadhog/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Reaper/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Soldier76/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Reinhardt/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Tracer/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Genji/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Lucio/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/McCree/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Pharah/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Junkrat/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Widowmaker/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Mei/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Zarya/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Zenyatta/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Hanzo/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Mercy/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Torbjoern/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Symmetra/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Winston/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/Bastion/",
          "https://api.lootbox.eu/pc/kr/#{tag}/hero/DVa/"
          ]
        
    max_thread = 21 # 최대 스레드수
    ary_threads = []
    datas = []
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
            tmp_hash = {}
            data = JSON.load(open(url))
            key =  url.split("/")[-1]
            tmp_hash["#{key}"] = data
            datas.push tmp_hash
          rescue
          end
        end
      }
    end
        
    ary_threads.each { |th| th.join }        
    datas.each do |data|
      hero_name = data.keys[0]
      data = data.values[0]
      if hero_name.eql?("Roadhog")
        obj = OverTag.create_roadhog(data, tag_id)
      elsif hero_name.eql?("Reaper")
        obj = OverTag.create_reaper(data, tag_id)
      elsif hero_name.eql?("Soldier76")
        obj = OverTag.create_soldier76(data, tag_id)
      elsif hero_name.eql?("Reinhardt")
        obj = OverTag.create_reinhardt(data, tag_id)
      elsif hero_name.eql?("Tracer")
        obj = OverTag.create_tracer(data, tag_id)
      elsif hero_name.eql?("Genji")
        obj = OverTag.create_genji(data, tag_id)
      elsif hero_name.eql?("Lucio")
        obj = OverTag.create_lucio(data, tag_id)
      elsif hero_name.eql?("McCree")
        obj = OverTag.create_mccree(data, tag_id)
      elsif hero_name.eql?("Pharah")
        obj = OverTag.create_pharah(data, tag_id)
      elsif hero_name.eql?("Junkrat")
        obj = OverTag.create_junkrat(data, tag_id)
      elsif hero_name.eql?("Widowmaker")
        obj = OverTag.create_widowmaker(data, tag_id)
      elsif hero_name.eql?("Mei")
        obj = OverTag.create_mei(data, tag_id)
      elsif hero_name.eql?("Zarya")
        obj = OverTag.create_zarya(data, tag_id)
      elsif hero_name.eql?("Zenyatta")
        obj = OverTag.create_zenyatta(data, tag_id)
      elsif hero_name.eql?("Hanzo")
        obj = OverTag.create_hanzo(data, tag_id)
      elsif hero_name.eql?("Mercy")
        obj = OverTag.create_mercy(data, tag_id)
      elsif hero_name.eql?("Torbjoern")
        obj = OverTag.create_torbjoern(data, tag_id)
      elsif hero_name.eql?("Symmetra")
        obj = OverTag.create_symmetra(data, tag_id)
      elsif hero_name.eql?("Winston")
        obj = OverTag.create_winston(data, tag_id)
      elsif hero_name.eql?("Bastion")
        obj = OverTag.create_bastion(data, tag_id)
      elsif hero_name.eql?("DVa")
        obj = OverTag.create_dva(data, tag_id)
      end

      OverTag.common_create(obj, data) if obj
    end
  end
  
  
  def self.get_main_data(over_all_hero, over_profile, over_heros, tag, tag_id)
    tag.gsub!(/#/, '-')
    
    urls = []
    max_thread = 0
    unless over_all_hero
      urls.push "https://api.lootbox.eu/pc/kr/#{tag}/allHeroes/"
      max_thread += 1
    end
     
    unless over_profile
      urls.push "https://api.lootbox.eu/pc/kr/#{tag}/profile"
      max_thread += 1
    end
    
    if over_heros.blank?
      urls.push "https://api.lootbox.eu/pc/kr/#{tag}/heroes"
      max_thread += 1
    end
        
    if max_thread != 0
      ary_threads = []
      datas = []
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
              tmp_hash = {}
              data = JSON.load(open(url))
              key =  url.split("/")[-1]
              tmp_hash["#{key}"] = data
              datas.push tmp_hash
            rescue
            end
          end
        }
      end 
      ary_threads.each { |th| th.join }
      datas.each do |data|
        key = data.keys[0]
        data = data.values[0]
        if key.eql?("allHeroes")
          if data["statusCode"] != 404
            OverTag.create_all_hero(data, tag_id)
          end
        elsif key.eql?("profile")
          if data["statusCode"] != 404
            data = data["data"]
            user_name = data["username"]
            level = data["level"]
            playtime = data["playtime"]
            avatar = data["avatar"]
            
            d = data["games"]
            win_percentage = d["win_percentage"]
            wins = d["wins"]
            lost = d["lost"]
            played = d["played"]
            
            OverProfile.create(over_tag_id: tag_id, username: user_name, level: level, playtime: playtime, avatar: avatar, win_percentage: win_percentage, wins: wins, lost: lost, played: played)
          end
        elsif key.eql?("heroes")
          if data.class.eql?(Array)
            data.each do |d|
              name = d["name"]
              over_hero = OverHero.where(over_tag_id: tag_id, name: name)
              if over_hero.blank?
                playtime = d["playtime"]
              
                if playtime.end_with?("1 hour")
                  playtime_min = 60
                elsif playtime.end_with?("hours")
                  hour = playtime.split(" ")[0].to_i
                  playtime_min = hour * 60
                elsif playtime.end_with?("minutes") 
                  min = playtime.split(" ")[0].to_i
                  playtime_min = min
                end
                
                image = d["image"]
                percentage = d["percentage"]
                
                OverHero.create(over_tag_id: tag_id, name: name, playtime: playtime, playtime_min: playtime_min, image: image, percentage: percentage)
              end
            end
          end
        end
      end
    end
  end
  
  def self.get_allHeroes(tag, tag_id)
    begin
      timeout(TIME_OUT) { 
        #tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
        
        url = "https://api.lootbox.eu/pc/kr/#{tag}/allHeroes/"
        uri = Addressable::URI.parse(url)
        url = uri.normalize.to_s
        # url.gsub!(/%/, '%25')
        
        data = JSON.load(open(url))
        if data["statusCode"] != 404
          OverTag.create_all_hero(data, tag_id)
          return 200
        else
          return 404
        end
      }
    rescue
    end
  end
  
  def self.common_create(obj, data)
    over_hero_id = obj.over_tag.over_heros.where(name: obj.name).first.id
    obj.over_hero_common.create(
      over_hero_id: over_hero_id,
      Cards: data["Cards"],
      DamageDone: data["DamageDone"],
      DamageDone_Average: data["DamageDone-Average"],
      DamageDone_MostinGame: data["DamageDone-MostinGame"],
      Deaths: data["Deaths"],
      Deaths_Average: data["Deaths-Average"],
      DefensiveAssists_MostinGame: data["DefensiveAssists-MostinGame"],
      Eliminations: data["Eliminations"],
      Eliminations_Average: data["Eliminations-Average"],
      Eliminations_MostinGame: data["Eliminations-MostinGame"],
      EnvironmentalDeaths: data["EnvironmentalDeaths"],
      EnvironmentalKills: data["EnvironmentalKills"],
      FinalBlows: data["FinalBlows"],
      FinalBlows_Average: data["FinalBlows-Average"],
      FinalBlows_MostinGame: data["FinalBlows-MostinGame"],
      GamesPlayed: data["GamesPlayed"],
      GamesWon: data["GamesWon"],
      HealingDone: data["HealingDone"],
      HealingDone_Average: data["HealingDone-Average"],
      HealingDone_MostinGame: data["HealingDone-MostinGame"],
      Medals: data["Medals"],
      Medals_Bronze: data["Medals-Bronze"],
      Medals_Gold: data["Medals-Gold"],
      Medals_Silver: data["Medals-Silver"],
      MeleeFinalBlows: data["MeleeFinalBlows"],
      MeleeFinalBlows_MostinGame: data["MeleeFinalBlows-MostinGame"],
      Multikill_Best: data["Multikill-Best"],
      Multikills: data["Multikills"],
      ObjectiveKills: data["ObjectiveKills"],
      ObjectiveKills_Average: data["ObjectiveKills-Average"],
      ObjectiveKills_MostinGame: data["ObjectiveKills-MostinGame"],
      ObjectiveTime: data["ObjectiveTime"],
      ObjectiveTime_Average: data["ObjectiveTime-Average"],
      ObjectiveTime_MostinGame: data["ObjectiveTime-MostinGame"],
      OffensiveAssists_MostinGame: data["OffensiveAssists-MostinGame"],
      Score: data["Score"],
      SoloKills: data["SoloKills"],
      SoloKills_Average: data["SoloKills-Average"],
      SoloKills_MostinGame: data["SoloKills-MostinGame"],
      TimePlayed: data["TimePlayed"],
      TimeSpentonFire: data["TimeSpentonFire"],
      TeleporterPadsDestroyed: data["TeleporterPadsDestroyed"],
      ShotsFired: data["ShotsFired"],
      ShotsHit: data["ShotsHit"],
      CriticalHits: data["CriticalHits"],
      CriticalHitsperMinute: data["CriticalHitsperMinute"],
      CriticalHitAccuracy: data["CriticalHitAccuracy"],
      EliminationsperLife: data["EliminationsperLife"],
      WeaponAccuracy: data["WeaponAccuracy"],
      TurretsDestroyed: data["TurretsDestroyed"],
      SelfHealing: data["SelfHealing"],
      Eliminations_MostinLife: data["Eliminations-MostinLife"],
      MostScorewithinoneLife: data["MostScorewithinoneLife"],
      DamageDone_MostinLife: data["DamageDone-MostinLife"],
      HealingDone_MostinLife: data["HealingDone-MostinLife"],
      WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      KillStreak_Best: data["KillStreak-Best"],
      CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      SelfHealing_Average: data["SelfHealing-Average"],
      WinPercentage: data["WinPercentage"],
      DamageBlocked: data["DamageBlocked"],
      DamageBlocked_MostinGame: data["DamageBlocked-MostinGame"],
      DamageBlocked_Average: data["DamageBlocked-Average"],
      OffensiveAssists: data["OffensiveAssists"],
      DefensiveAssists: data["DefensiveAssists"],
      DefensiveAssists_Average: data["DefensiveAssists-Average"],
      OffensiveAssists_Average: data["OffensiveAssists-Average"],
      ReconAssists_MostinGame: data["ReconAssists-MostinGame"],
      ReconAssists_Average: data["ReconAssists-Average"]
    )
  end  
  
  def self.create_roadhog(data, tag_id)
    OverHeroRoadhog.create(
      over_tag_id: tag_id,
      name: HEROES[0],
      EnemiesHooked_MostinGame: data["EnemiesHooked-MostinGame"],
      EnemiesHooked: data["EnemiesHooked"],
      HooksAttempted: data["HooksAttempted"],
      WholeHogKills_MostinGame: data["WholeHogKills-MostinGame"],
      WholeHogKills: data["WholeHogKills"],
      HookAccuracy_BestinGame: data["HookAccuracy-BestinGame"],
      WholeHogKills_Average: data["WholeHogKills-Average"],
      EnemiesHooked_Average: data["EnemiesHooked-Average"],
      HookAccuracy: data["HookAccuracy"]
    )
  end
  
  def self.create_reaper(data, tag_id)
    OverHeroReaper.create(
      over_tag_id: tag_id,
      name: HEROES[1],
      SoulsConsumed: data["SoulsConsumed"],
      DeathBlossomKills: data["DeathBlossomKills"],
      SoulsConsumed_MostinGame: data["SoulsConsumed-MostinGame"],
      DeathBlossomKills_MostinGame: data["DeathBlossomKills-MostinGame"],
      SoulsConsumed_Average: data["SoulsConsumed-Average"],
      DeathBlossomKills_Average: data["DeathBlossomKills-Average"]
    )
  end
  
  def self.create_soldier76(data, tag_id)
    OverHeroSoldier76.create(
      over_tag_id: tag_id,
      name: HEROES[2],
      HelixRocketsKills_MostinGame: data["HelixRocketsKills-MostinGame"],
      HelixRocketsKills: data["HelixRocketsKills"],
      TacticalVisorKills: data["TacticalVisorKills"],
      TacticalVisorKills_MostinGame: data["TacticalVisorKills-MostinGame"],
      BioticFieldsDeployed: data["BioticFieldsDeployed"],
      BioticFieldHealingDone: data["BioticFieldHealingDone"],
      TacticalVisorKills_Average: data["TacticalVisorKills-Average"],
      HelixRocketsKills_Average: data["HelixRocketsKills-Average"]
    )
  end
  
  def self.create_reinhardt(data, tag_id)
    OverHeroReinhardt.create(
      over_tag_id: tag_id,
      name: HEROES[3],
      ChargeKills: data["ChargeKills"],
      ChargeKills_MostinGame: data["ChargeKills-MostinGame"],
      FireStrikeKills: data["FireStrikeKills"],
      FireStrikeKills_MostinGame: data["FireStrikeKills-MostinGame"],
      EarthshatterKills: data["EarthshatterKills"],
      EarthshatterKills_MostinGame: data["EarthshatterKills-MostinGame"],
      FireStrikeKills_Average: data["FireStrikeKills-Average"],
      EarthshatterKills_Average: data["EarthshatterKills-Average"],
      ChargeKills_Average: data["ChargeKills-Average"]
    )
  end
  
  def self.create_tracer(data, tag_id)
    OverHeroTracer.create(
      over_tag_id: tag_id,
      name: HEROES[4],
      PulseBombKills: data["PulseBombKills"],
      PulseBombKills_MostinGame: data["PulseBombKills-MostinGame"],
      PulseBombsAttached_MostinGame: data["PulseBombsAttached-MostinGame"],
      PulseBombsAttached: data["PulseBombsAttached"],
      PulseBombKills_Average: data["PulseBombKills-Average"],
      PulseBombsAttached_Average: data["PulseBombsAttached-Average"]
    )
  end
  
  def self.create_genji(data, tag_id)
    OverHeroGenji.create(
      over_tag_id: tag_id,
      name: HEROES[5],
      DragonbladeKills: data["DragonbladeKills"],
      DragonbladeKills_MostinGame: data["DragonbladeKills-MostinGame"],
      DamageReflected: data["DamageReflected"],
      DamageReflected_MostinGame: data["DamageReflected-MostinGame"],
      Dragonblades: data["Dragonblades"],
      DragonbladeKills_Average: data["DragonbladeKills-Average"],
      DamageReflected_Average: data["DamageReflected-Average"]
    )
  end
              
  def self.create_lucio(data, tag_id)
    OverHeroLucio.create(
      over_tag_id: tag_id,
      name: HEROES[6],
      SoundBarriersProvided: data["SoundBarriersProvided"],
      SoundBarriersProvided_MostinGame: data["SoundBarriersProvided-MostinGame"],
      SoundBarriersProvided_Average: data["SoundBarriersProvided-Average"]
    )
  end
  
  def self.create_mccree(data, tag_id)
    OverHeroMcCree.create(
      over_tag_id: tag_id,
      name: HEROES[7],
      DeadeyeKills: data["DeadeyeKills"],
      DeadeyeKills_MostinGame: data["DeadeyeKills-MostinGame"],
      FantheHammerKills: data["FantheHammerKills"],
      FantheHammerKills_Average: data["FantheHammerKills-Average"],
      DeadeyeKills_Average: data["DeadeyeKills-Average"],
      FantheHammerKills_MostinGame: data["FantheHammerKills-MostinGame"]
    )
    
  end
  
  def self.create_pharah(data, tag_id)
    OverHeroPharah.create(
      over_tag_id: tag_id,
      name: HEROES[8],
      RocketDirectHits: data["RocketDirectHits"],
      BarrageKills: data["BarrageKills"],
      RocketDirectHits_MostinGame: data["RocketDirectHits-MostinGame"],
      BarrageKills_MostinGame: data["BarrageKills-MostinGame"],
      RocketDirectHits_Average: data["RocketDirectHits-Average"],
      BarrageKills_Average: data["BarrageKills-Average"]
    )
  end
  
  def self.create_junkrat(data, tag_id)
    OverHeroJunkrat.create(
      over_tag_id: tag_id,
      name: HEROES[9],
      EnemiesTrapped_MostinGame: data["EnemiesTrapped-MostinGame"],
      EnemiesTrapped: data["EnemiesTrapped"],
      RIP_TireKills_MostinGame: data["RIP-TireKills-MostinGame"],
      RIP_TireKills: data["RIP-TireKills"],
      EnemiesTrappedaMinute: data["EnemiesTrappedaMinute"],
      RIP_TireKills_Average: data["RIP-TireKills-Average"]
    )
  end
  
  def self.create_widowmaker(data, tag_id)
    OverHeroWidowmaker.create(
      over_tag_id: tag_id,
      name: HEROES[10],
      VenomMineKills: data["VenomMineKills"],
      ScopedHits: data["ScopedHits"],
      ScopedShots: data["ScopedShots"],
      ScopedCriticalHits: data["ScopedCriticalHits"],
      ScopedCriticalHits_MostinGame: data["ScopedCriticalHits-MostinGame"],
      VenomMineKills_MostinGame: data["VenomMineKills-MostinGame"],
      ScopedAccuracy_BestinGame: data["ScopedAccuracy-BestinGame"],
      VenomMineKills_Average: data["VenomMineKills-Average"],
      ScopedCriticalHits_Average: data["ScopedCriticalHits-Average"],
      ScopedAccuracy: data["ScopedAccuracy"]
    )
  end
  
  def self.create_mei(data, tag_id)
    OverHeroMei.create(
      over_tag_id: tag_id,
      name: HEROES[11],
      EnemiesFrozen: data["EnemiesFrozen"],
      EnemiesFrozen_MostinGame: data["EnemiesFrozen-MostinGame"],
      BlizzardKills_MostinGame: data["BlizzardKills-MostinGame"],
      BlizzardKills: data["BlizzardKills"],
      EnemiesFrozen_Average: data["EnemiesFrozen-Average"],
      BlizzardKills_Average: data["BlizzardKills-Average"]
    )
  end
  
  def self.create_zarya(data, tag_id)
    OverHeroZarya.create(
      over_tag_id: tag_id,
      name: HEROES[12],
      LifetimeGravitonSurgeKills: data["LifetimeGravitonSurgeKills"],
      GravitonSurgeKills_MostinGame: data["GravitonSurgeKills-MostinGame"],
      HighEnergyKills_MostinGame: data["HighEnergyKills-MostinGame"],
      HighEnergyKills: data["HighEnergyKills"],
      LifetimeEnergyAccumulation: data["LifetimeEnergyAccumulation"],
      EnergyMaximum: data["EnergyMaximum"],
      ProjectedBarriersApplied: data["ProjectedBarriersApplied"],
      AverageEnergy_BestinGame: data["AverageEnergy-BestinGame"],
      ProjectedBarriersApplied_Average: data["ProjectedBarriersApplied-Average"],
      HighEnergyKills_Average: data["HighEnergyKills-Average"],
      GravitonSurgeKills_Average: data["GravitonSurgeKills-Average"],
      LifetimeAverageEnergy: data["LifetimeAverageEnergy"],
      ProjectedBarriersApplied_MostinGame: data["ProjectedBarriersApplied-MostinGame"]
    )
  end
  
  def self.create_zenyatta(data, tag_id)
    OverHeroZenyattum.create(
      over_tag_id: tag_id,
      name: HEROES[13],
      TranscendenceHealing_Best: data["TranscendenceHealing-Best"],
      TranscendenceHealing: data["TranscendenceHealing"]
    )
  end
  
  def self.create_hanzo(data, tag_id)
    OverHeroHanzo.create(
      over_tag_id: tag_id,
      name: HEROES[14],
      DragonstrikeKills: data["DragonstrikeKills"],
      DragonstrikeKills_MostinGame: data["DragonstrikeKills-MostinGame"],
      ScatterArrowKills: data["ScatterArrowKills"],
      ScatterArrowKills_MostinGame: data["ScatterArrowKills-MostinGame"],
      ScatterArrowKills_Average: data["ScatterArrowKills-Average"],
      DragonstrikeKills_Average: data["DragonstrikeKills-Average"]
    )
  end
  
  def self.create_mercy(data, tag_id)
    OverHeroMercy.create(
      over_tag_id: tag_id,
      name: HEROES[15],
      PlayersResurrected: data["PlayersResurrected"],
      PlayersResurrected_MostinGame: data["PlayersResurrected-MostinGame"],
      PlayersSaved: data["PlayersSaved"],
      MostPlayersSavedinaGame: data["MostPlayersSavedinaGame"],
      PlayersSaved_Average: data["PlayersSaved-Average"],
      PlayersResurrected_Average: data["PlayersResurrected-Average"],
      BlasterKills: data["BlasterKills"],
      BlasterKills_MostinGame: data["BlasterKills-MostinGame"],
      BlasterKills_Average: data["BlasterKills-Average"]
    )
  end
  
  def self.create_torbjoern(data, tag_id)
    OverHeroTorbjoern.create(
      over_tag_id: tag_id,
      name: HEROES[16], 
      ArmorPacksCreated: data["ArmorPacksCreated"],
      TorbjoernKills: data["Torbj&#xF6;rnKills"],
      TurretKills: data["TurretKills"],
      TorbjoernKills_MostinGame: data["Torbj&#xF6;rnKills-MostinGame"],
      MoltenCoreKills: data["MoltenCoreKills"],
      MoltenCoreKills_MostinGame: data["MoltenCoreKills-MostinGame"],
      TurretKills_Average: data["TurretKills-Average"],
      TorbjoernKills_Average: data["Torbj&#xF6;rnKills-Average"],
      MoltenCoreKills_Average: data["MoltenCoreKills-Average"],
      ArmorPacksCreated_Average: data["ArmorPacksCreated-Average"]
    )
  end
  
  def self.create_symmetra(data, tag_id)
    OverHeroSymmetra.create(
      over_tag_id: tag_id,
      name: HEROES[17],
      SentryTurretKills: data["SentryTurretKills"],
      SentryTurretKills_MostinGame: data["SentryTurretKills-MostinGame"],
      PlayersTeleported: data["PlayersTeleported"],
      PlayersTeleported_MostinGame: data["PlayersTeleported-MostinGame"],
      ShieldsProvided: data["ShieldsProvided"],
      ShieldsProvided_MostinGame: data["ShieldsProvided-MostinGame"],
      TeleporterUptime: data["TeleporterUptime"],
      TeleporterUptime_BestinGame: data["TeleporterUptime-BestinGame"],
      ShieldsProvided_Average: data["ShieldsProvided-Average"],
      SentryTurretKills_Average: data["SentryTurretKills-Average"],
      PlayersTeleported_Average: data["PlayersTeleported-Average"],
      TeleporterUptime_Average: data["TeleporterUptime-Average"]
    )
  end
  
  def self.create_winston(data, tag_id)
    OverHeroWinston.create(
      over_tag_id: tag_id,
      name: HEROES[18],
      PlayersKnockedBack: data["PlayersKnockedBack"],
      PlayersKnockedBack_MostinGame: data["PlayersKnockedBack-MostinGame"],
      MeleeKills: data["MeleeKills"],
      MeleeKills_MostinGame: data["MeleeKills-MostinGame"],
      JumpPackKills: data["JumpPackKills"],
      JumpPackKills_MostinGame: data["JumpPackKills-MostinGame"],
      PlayersKnockedBack_Average: data["PlayersKnockedBack-Average"],
      MeleeKills_Average: data["MeleeKills-Average"],
      JumpPackKills_Average: data["JumpPackKills-Average"],
      PrimalRageKills: data["PrimalRageKills"],
      PrimalRageKills_MostinGame: data["PrimalRageKills-MostinGame"],
      PrimalRageKills_Average: data["PrimalRageKills-Average"]
    )
  end
  
  def self.create_bastion(data, tag_id)
    OverHeroBastion.create(
      over_tag_id: tag_id,
      name: HEROES[19],
      ReconKills: data["ReconKills"],
      SentryKills: data["SentryKills"],
      TankKills: data["TankKills"],
      SentryKills_MostinGame: data["SentryKills-MostinGame"],
      ReconKills_MostinGame: data["ReconKills-MostinGame"],
      TankKills_MostinGame: data["TankKills-MostinGame"],
      TankKills_Average: data["TankKills-Average"],
      SentryKills_Average: data["SentryKills-Average"],
      ReconKills_Average: data["ReconKills-Average"]
    )
  end
  
  def self.create_dva(data, tag_id)
    OverHeroDva.create(
      over_tag_id: tag_id,
      name: HEROES[20],
      MechsCalled: data["MechsCalled"],
      MechsCalled_MostinGame: data["MechsCalled-MostinGame"],
      MechDeaths: data["MechDeaths"],
      MechsCalled_Average: data["MechsCalled-Average"],
      Self_DestructKills: data["Self-DestructKills"],
      Self_DestructKills_MostinGame: data["Self-DestructKills-MostinGame"],
      Self_DestructKills_Average: data["Self-DestructKills-Average"]
    )
  end
  
  
  def self.create_all_hero(data, tag_id)
    OverAllHero.create(
      over_tag_id: tag_id,
      MeleeFinalBlows: data["MeleeFinalBlows"], 
      SoloKills: data["SoloKills"], 
      ObjectiveKills: data["ObjectiveKills"], 
      FinalBlows: data["FinalBlows"], 
      DamageDone: data["DamageDone"], 
      Eliminations: data["Eliminations"], 
      EnvironmentalKills: data["EnvironmentalKills"], 
      Multikills: data["Multikills"], 
      HealingDone: data["HealingDone"], 
      ReconAssists: data["ReconAssists"], 
      TeleporterPadsDestroyed: data["TeleporterPadsDestroyed"], 
      Eliminations_MostinGame: data["Eliminations-MostinGame"], 
      FinalBlows_MostinGame: data["FinalBlows-MostinGame"], 
      DamageDone_MostinGame: data["DamageDone-MostinGame"], 
      HealingDone_MostinGame: data["HealingDone-MostinGame"], 
      DefensiveAssists_MostinGame: data["DefensiveAssists-MostinGame"], 
      OffensiveAssists_MostinGame: data["OffensiveAssists-MostinGame"], 
      ObjectiveKills_MostinGame: data["ObjectiveKills-MostinGame"], 
      ObjectiveTime_MostinGame: data["ObjectiveTime-MostinGame"], 
      Multikill_Best: data["Multikill-Best"], 
      SoloKills_MostinGame: data["SoloKills-MostinGame"], 
      TimeSpentonFire_MostinGame: data["TimeSpentonFire-MostinGame"], 
      MeleeFinalBlows_Average: data["MeleeFinalBlows-Average"], 
      FinalBlows_Average: data["FinalBlows-Average"], 
      TimeSpentonFire_Average: data["TimeSpentonFire-Average"], 
      SoloKills_Average: data["SoloKills-Average"], 
      ObjectiveTime_Average: data["ObjectiveTime-Average"], 
      ObjectiveKills_Average: data["ObjectiveKills-Average"], 
      HealingDone_Average: data["HealingDone-Average"], 
      Deaths_Average: data["Deaths-Average"], 
      DamageDone_Average: data["DamageDone-Average"], 
      Eliminations_Average: data["Eliminations-Average"], 
      Deaths: data["Deaths"], 
      EnvironmentalDeaths: data["EnvironmentalDeaths"], 
      Cards: data["Cards"], 
      Medals: data["Medals"], 
      Medals_Gold: data["Medals-Gold"], 
      Medals_Silver: data["Medals-Silver"], 
      Medals_Bronze: data["Medals-Bronze"], 
      GamesWon: data["GamesWon"], 
      GamesPlayed: data["GamesPlayed"], 
      TimeSpentonFire: data["TimeSpentonFire"], 
      ObjectiveTime: data["ObjectiveTime"], 
      Score: data["Score"], 
      TimePlayed: data["TimePlayed"], 
      MeleeFinalBlows_MostinGame: data["MeleeFinalBlows-MostinGame"], 
      DefensiveAssists: data["DefensiveAssists"], 
      DefensiveAssists_Average: data["DefensiveAssists-Average"], 
      OffensiveAssists: data["OffensiveAssists"], 
      OffensiveAssists_Average: data["OffensiveAssists-Average"]
    )
  end
  
  
  # def a
    # tag = "아아아퍼때리지마#3725"
    # tag.gsub!(/#/, '-')
    # k = ["Cards", "DamageDone", "DamageDone-Average", "DamageDone-MostinGame", "Deaths", "Deaths-Average", "DefensiveAssists-MostinGame", "Eliminations", "Eliminations-Average", "Eliminations-MostinGame","EnvironmentalDeaths","EnvironmentalKills", "FinalBlows", "FinalBlows-Average", "FinalBlows-MostinGame", "GamesPlayed", "GamesWon", "HealingDone", "HealingDone-Average", "HealingDone-MostinGame", "Medals", "Medals-Bronze", "Medals-Gold", "Medals-Silver", "MeleeFinalBlows", "MeleeFinalBlows-MostinGame", "Multikill-Best", "Multikills", "ObjectiveKills", "ObjectiveKills-Average", "ObjectiveKills-MostinGame", "ObjectiveTime", "ObjectiveTime-Average", "ObjectiveTime-MostinGame", "OffensiveAssists-MostinGame", "Score", "SoloKills", "SoloKills-Average", "SoloKills-MostinGame", "TimePlayed", "TimeSpentonFire", "TeleporterPadsDestroyed"]
    # jobs = ["Roadhog", "Reaper", "Soldier76", "Reinhardt", "Tracer", "Genji", "Lucio", "McCree", "Pharah", "Junkrat", "Widowmaker", "Mei", "Zarya", "Zenyatta", "Hanzo", "Mercy", "Torbjoern", "Symmetra", "Winston", "Bastion", "DVa"]
    # cf = ["MeleeFinalBlows", "SoloKills", "ObjectiveKills", "FinalBlows", "DamageDone", "Eliminations", "EnvironmentalKills", "Multikills", "HealingDone", "ReconAssists", "TeleporterPadsDestroyed", "Eliminations-MostinGame", "FinalBlows-MostinGame", "DamageDone-MostinGame", "HealingDone-MostinGame", "DefensiveAssists-MostinGame", "OffensiveAssists-MostinGame", "ObjectiveKills-MostinGame", "ObjectiveTime-MostinGame", "Multikill-Best", "SoloKills-MostinGame", "TimeSpentonFire-MostinGame", "MeleeFinalBlows-Average", "FinalBlows-Average", "TimeSpentonFire-Average", "SoloKills-Average", "ObjectiveTime-Average", "ObjectiveKills-Average", "HealingDone-Average", "Deaths-Average", "DamageDone-Average", "Eliminations-Average", "Deaths", "EnvironmentalDeaths", "Cards", "Medals", "Medals-Gold", "Medals-Silver", "Medals-Bronze", "GamesWon", "GamesPlayed", "TimeSpentonFire", "ObjectiveTime", "Score", "TimePlayed", "MeleeFinalBlows-MostinGame"]
    # jobs.each do |job|
      # url = "https://api.lootbox.eu/pc/kr/#{tag}/hero/#{job}/"
      # uri = Addressable::URI.parse(url)
      # url = uri.normalize.to_s
      # data = JSON.load(open(url))
      # keys = data.keys
#       
      # sw = []
#       
      # keys.each do |key|
        # cf.any? { |word|
          # sw.push key if word == key
        # }        
      # end
      # pp = keys-sw
      # p "----#{job}----"
      # pp.each do |p|
        # p p
      # end
#       
      # # sw2 = []
      # # sw.each do |s|
        # # k.any? { |word|
          # # p sw2.push word if word == s
        # # }
      # # end
      # # p "====================#{job} => error" if sw!=sw2
    # end
  # end

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
  
  def self.is_hero_data?(tag_id, job)
    if job.eql?("Roadhog")
      data = OverHeroRoadhog.where(over_tag_id: tag_id)
    elsif job.eql?("Reaper")
      data = OverHeroReaper.where(over_tag_id: tag_id)
    elsif job.eql?("Soldier76")
      data = OverHeroSoldier76.where(over_tag_id: tag_id)
    elsif job.eql?("Reinhardt")
      data = OverHeroReinhardt.where(over_tag_id: tag_id)
    elsif job.eql?("Tracer")
      data = OverHeroTracer.where(over_tag_id: tag_id)
    elsif job.eql?("Genji")
      data = OverHeroGenji.where(over_tag_id: tag_id)
    elsif job.eql?("Lucio")
      data = OverHeroLucio.where(over_tag_id: tag_id)
    elsif job.eql?("McCree")
      data = OverHeroMcCree.where(over_tag_id: tag_id)
    elsif job.eql?("Pharah")
      data = OverHeroPharah.where(over_tag_id: tag_id)
    elsif job.eql?("Junkrat")
      data = OverHeroJunkrat.where(over_tag_id: tag_id)
    elsif job.eql?("Widowmaker")
      data = OverHeroWidowmaker.where(over_tag_id: tag_id)
    elsif job.eql?("Mei")
      data = OverHeroMei.where(over_tag_id: tag_id)
    elsif job.eql?("Zarya")
      data = OverHeroZarya.where(over_tag_id: tag_id)
    elsif job.eql?("Zenyatta")
      data = OverHeroZenyattum.where(over_tag_id: tag_id)
    elsif job.eql?("Hanzo")
      data = OverHeroHanzo.where(over_tag_id: tag_id)
    elsif job.eql?("Mercy")
      data = OverHeroMercy.where(over_tag_id: tag_id)
    elsif job.eql?("Torbjoern")
      data = OverHeroTorbjoern.where(over_tag_id: tag_id)
    elsif job.eql?("Symmetra")
      data = OverHeroSymmetra.where(over_tag_id: tag_id)
    elsif job.eql?("Winston")
      data = OverHeroWinston.where(over_tag_id: tag_id)
    elsif job.eql?("Bastion")
      data = OverHeroBastion.where(over_tag_id: tag_id)
    elsif job.eql?("DVa")
      data = OverHeroDva.where(over_tag_id: tag_id)
    end
    unless data.blank?
      return true
    else
      return false
    end
  end

end








