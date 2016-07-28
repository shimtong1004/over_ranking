class HeroGroup < ActiveRecord::Base
  belongs_to :over_user_type
  
  def self.set_group_data(user_type)
      over_user_type_id = user_type.id
      play_types = [1,2]
      
      tmp_hash = {}
      ActiveRecord::Base.transaction do
        play_types.each do |play_type|
          hero_datas = user_type.heros.where(play_type: play_type)
          self_healing = 0
          win_per = 0
          
          offense_cnt = 0
          defense_cnt = 0
          rush_cnt = 0
          support_cnt = 0
          
          offense_hash = self.get_total_hash
          defense_hash = self.get_total_hash
          rush_hash = self.get_total_hash
          support_hash = self.get_total_hash
          hero_datas.each do |hero_data|
            if OFFENSE_HERO.index(hero_data.name)
              offense_cnt += 1
            elsif DEFENSE_HERO.index(hero_data.name)
              defense_cnt += 1
            elsif RUSH_HERO.index(hero_data.name)
              rush_cnt += 1
            elsif SUPPORT_HERO.index(hero_data.name)
              support_cnt += 1
            end 
            GROUP_KEYS.each do |key|
              if OFFENSE_HERO.index(hero_data.name)
                offense_hash[key] += hero_data[key] if hero_data[key]
              elsif DEFENSE_HERO.index(hero_data.name)
                defense_hash[key] += hero_data[key] if hero_data[key]
              elsif RUSH_HERO.index(hero_data.name)
                rush_hash[key] += hero_data[key] if hero_data[key]
              elsif SUPPORT_HERO.index(hero_data.name)
                support_hash[key] += hero_data[key] if hero_data[key]
              end
            end
            
            self_healing += hero_data.Self_Healing if hero_data.name != "ALL HEROES" && hero_data.Self_Healing
            win_per += hero_data.Win_Percentage if hero_data.name != "ALL HEROES" && hero_data.Win_Percentage
          end
          hero = user_type.heros.where(play_type: play_type, name: "ALL HEROES").first
          hero.update(Self_Healing: self_healing, Win_Percentage: (win_per / (hero_datas.count-1)) ) if hero
          offense_hash[KEY["승률"]] = offense_hash[KEY["승률"]] / offense_cnt.to_f
          defense_hash[KEY["승률"]] = defense_hash[KEY["승률"]] / defense_cnt.to_f
          rush_hash[KEY["승률"]] = rush_hash[KEY["승률"]] / rush_cnt.to_f
          support_hash[KEY["승률"]] = support_hash[KEY["승률"]] / support_cnt.to_f
          self.create_group_data(user_type, offense_hash, play_type, "offense")
          self.create_group_data(user_type, defense_hash, play_type, "defense")
          self.create_group_data(user_type, rush_hash, play_type, "rush")
          self.create_group_data(user_type, support_hash, play_type, "support")
        end
      end 
  end
  
  def self.create_group_data(user_type, offense_hash, play_type, group_name)
    group_data = user_type.hero_groups.where(name: group_name, play_type: play_type).first
    group_data = HeroGroup.create(over_user_type_id: user_type.id, name: group_name, play_type: play_type, user_type: user_type.user_type) unless group_data
    GROUP_KEYS.each do |key|
      group_data[key] = offense_hash[key]
    end
    group_data.save
  end
  
  
  def self.get_total_hash
    tmp_hash = {}
    GROUP_KEYS.each do |key|
      tmp_hash[key] = 0
    end
    return tmp_hash
  end
end
