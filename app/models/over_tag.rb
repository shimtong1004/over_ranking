#encoding: utf-8
require 'open-uri'

TIME_OUT = 60

class OverTag < ActiveRecord::Base
  has_one :over_all_hero
  
  def self.set_data(tag)
    over_tag = OverTag.create(tag: tag)
    status = get_achievement(tag, over_tag.id)
    status = get_profile(tag, over_tag.id) if status == 200
    status = get_heroes(tag, over_tag.id) if status == 200
    status = get_hero(tag, over_tag.id) if status == 200
    status = get_allHeroes(tag, over_tag.id) if status == 200
    # status = get_platforms(tag, over_tag.id) if status == 200
    
    return over_tag, status
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
            finished = d["finished"]
            image = d["image"]
            OverAchievement.create(over_tag_id: tag_id, finishedAchievements: finished_achievements, name: name, finished: finished, image: image)
          end
          return 200
        else
          return 404
        end
      }
    rescue
    end 
  end
  
  def self.get_profile(tag, tag_id)
    begin
      timeout(TIME_OUT) {
        #tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
        url = "https://api.lootbox.eu/pc/kr/#{tag}/profile"
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
      }
    rescue
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
            playtime = d["playtime"]
            image = d["image"]
            percentage = d["percentage"]
            OverHero.create(over_tag_id: tag_id, name: name, playtime: playtime, image: image, percentage: percentage)
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
    begin
      timeout(TIME_OUT) {
        #tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
    
        jobs = ["Lucio", "Torbjoern", "Soldier76"]
        status = 404
        jobs.each do |job|
          url = "https://api.lootbox.eu/pc/kr/#{tag}/hero/#{job}/"
          uri = Addressable::URI.parse(url)
          url = uri.normalize.to_s
          # url.gsub!(/%/, '%25')
            
          data = JSON.load(open(url))
          if data["statusCode"] != 404
            if job.eql?("Lucio")
              OverTag.create_lucio(data, tag_id)
            elsif job.eql?("Torbjoern")
              OverTag.create_torbjoern(data, tag_id)
            elsif job.eql?("Soldier76")
              OverTag.create_soldier76(data, tag_id)
            end
            status = 200
          else
            status = 404
          end
        end
        return status
      }
    rescue
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
  
  def self.create_lucio(data, tag_id)
    OverHeroLucio.create(
      over_tag_id: tag_id, 
      SoundBarriersProvided: data["SoundBarriersProvided"],
      SoundBarriersProvided_MostinGame: data["SoundBarriersProvided-MostinGame"], 
      MeleeFinalBlows_MostinGame: data["MeleeFinalBlows-MostinGame"], 
      SoundBarriersProvided_Average: data["SoundBarriersProvided-Average"], 
      Eliminations: data["Eliminations"], 
      FinalBlows: data["FinalBlows"],
      SoloKills: data["SoloKills"],
      ShotsFired: data["ShotsFired"], 
      ShotsHit: data["ShotsHit"],
      CriticalHits: data["CriticalHits"], 
      DamageDone: data["DamageDone"],
      ObjectiveKills: data["ObjectiveKills"], 
      Multikills: data["Multikills"],
      EnvironmentalKills: data["EnvironmentalKills"], 
      MeleeFinalBlows: data["MeleeFinalBlows"],
      CriticalHitsperMinute: data["CriticalHitsperMinute"], 
      CriticalHitAccuracy: data["CriticalHitAccuracy"],
      EliminationsperLife: data["EliminationsperLife"],
      WeaponAccuracy: data["WeaponAccuracy"],
      HealingDone: data["HealingDone"],
      TurretsDestroyed: data["TurretsDestroyed"], 
      SelfHealing: data["SelfHealing"],
      Eliminations: data["Eliminations-MostinLife"], 
      MostScorewithinoneLife: data["MostScorewithinoneLife"],
      DamageDone_MostinLife: data["DamageDone-MostinLife"],
      HealingDone_MostinLife: data["HealingDone-MostinLife"], 
      WeaponAccuracy_BestinGame: data["WeaponAccuracy_BestinGame"], 
      KillStreak_Best: data["KillStreak-Best"],
      DamageDone_MostinGame: data["DamageDone-MostinGame"], 
      HealingDone_MostinGame: data["HealingDone-MostinGame"], 
      Eliminations_MostinGame: data["Eliminations-MostinGame"], 
      FinalBlows_MostinGame: data["FinalBlows-MostinGame"],
      ObjectiveKills_MostinGame: data["ObjectiveKills-MostinGame"], 
      ObjectiveTime_MostinGame: data["ObjectiveTime-MostinGame"],
      SoloKills_MostinGame: data["SoloKills-MostinGame"],
      CriticalHits_MostinGame: data["CriticalHits-MostinGame"], 
      CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      SelfHealing_Average: data["SelfHealing-Average"],
      Deaths_Average: data["Deaths-Average"],
      SoloKills_Average: data["SoloKills-Average"], 
      ObjectiveTime_Average: data["ObjectiveTime-Average"], 
      ObjectiveKills_Average: data["ObjectiveKills-Average"], 
      HealingDone_Average: data["HealingDone-Average"],
      FinalBlows_Average: data["FinalBlows-Average"],
      Eliminations_Average: data["Eliminations-Average"], 
      DamageDone_Average: data["DamageDone-Average"],
      Deaths: data["Deaths"],
      EnvironmentalDeaths: data["EnvironmentalDeaths"], 
      Medals_Bronze: data["Medals-Bronze"],
      Medals_Silver: data["Medals-Silver"],
      Medals_Gold: data["Medals-Gold"],
      Medals: data["Medals"],
      Cards: data["Cards"],
      TimePlayed: data["TimePlayed"], 
      GamesPlayed: data["GamesPlayed"], 
      GamesWon: data["GamesWon"],
      Score: data["Score"],
      ObjectiveTime: data["ObjectiveTime"], 
      TimeSpentonFire: data["TimeSpentonFire"], 
      WinPercentage: data["WinPercentage"],
      Multikill_Best: data["Multikill-Best"], 
      OffensiveAssists: data["OffensiveAssists"], 
      OffensiveAssists_MostinGame: data["OffensiveAssists-MostinGame"], 
      DefensiveAssists: data["DefensiveAssists"],
      DefensiveAssists_MostinGame: data["DefensiveAssists-MostinGame"], 
      DefensiveAssists_Average: data["DefensiveAssists-Average"],
      OffensiveAssists_Average: data["OffensiveAssists-Average"]
    )
    
    
  end
  
  def self.create_torbjoern(data, tag_id)
    OverHeroTorbjoern.create(
      over_tag_id: tag_id, 
      ArmorPacksCreated: data["ArmorPacksCreated"], 
      TorbjoernKills: data["Torbj&#xF6;rnKills"], 
      TurretKills: data["TurretKills"], 
      TorbjoernKills_MostinGame: data["Torbj&#xF6;rnKills-MostinGame"], 
      MoltenCoreKills: data["MoltenCoreKills"], 
      MoltenCoreKills_MostinGame: data["MoltenCoreKills-MostinGame"], 
      MeleeFinalBlows_MostinGame: data["MeleeFinalBlows-MostinGame"], 
      TurretKills_Average: data["TurretKills-Average"], 
      TorbjoernKills_Average: data["Torbj&#xF6;rnKills-Average"], 
      MoltenCoreKills_Average: data["MoltenCoreKills-Average"], 
      ArmorPacksCreated_Average: data["ArmorPacksCreated-Average"], 
      Eliminations: data["Eliminations"], 
      FinalBlows: data["FinalBlows"], 
      SoloKills: data["SoloKills"], 
      ShotsFired: data["ShotsFired"], 
      ShotsHit: data["ShotsHit"], 
      CriticalHits: data["CriticalHits"], 
      DamageDone: data["DamageDone"], 
      ObjectiveKills: data["ObjectiveKills"], 
      MeleeFinalBlows: data["MeleeFinalBlows"], 
      CriticalHitsperMinute: data["CriticalHitsperMinute"], 
      CriticalHitAccuracy: data["CriticalHitAccuracy"], 
      EliminationsperLife: data["EliminationsperLife"], 
      WeaponAccuracy: data["WeaponAccuracy"], 
      TurretsDestroyed: data["TurretsDestroyed"], 
      Eliminations_MostinLife: data["Eliminations-MostinLife"], 
      MostScorewithinoneLife: data["MostScorewithinoneLife"], 
      DamageDone_MostinLife: data["DamageDone-MostinLife"], 
      WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"], 
      KillStreak_Best: data["KillStreak-Best"], 
      DamageDone_MostinGame: data["DamageDone-MostinGame"], 
      Eliminations_MostinGame: data["Eliminations-MostinGame"], 
      FinalBlows_MostinGame: data["FinalBlows-MostinGame"], 
      ObjectiveKills_MostinGame: data["ObjectiveKills-MostinGame"], 
      ObjectiveTime_MostinGame: data["ObjectiveTime-MostinGame"], 
      SoloKills_MostinGame: data["SoloKills-MostinGame"], 
      CriticalHits_MostinGame: data["CriticalHits-MostinGame"], 
      CriticalHits_MostinLife: data["CriticalHits-MostinLife"], 
      Deaths_Average: data["Deaths-Average"], 
      SoloKills_Average: data["SoloKills-Average"], 
      ObjectiveTime_Average: data["ObjectiveTime-Average"], 
      ObjectiveKills_Average: data["ObjectiveKills-Average"], 
      FinalBlows_Average: data["FinalBlows-Average"], 
      Eliminations_Average: data["Eliminations-Average"], 
      DamageDone_Average: data["DamageDone-Average"], 
      Deaths: data["Deaths"], 
      Medals_Bronze: data["Medals-Bronze"], 
      Medals_Silver: data["Medals-Silver"], 
      Medals_Gold: data["Medals-Gold"], 
      Medals: data["Medals"], 
      Cards: data["Cards"], 
      TimePlayed: data["TimePlayed"], 
      GamesPlayed: data["GamesPlayed"], 
      GamesWon: data["GamesWon"], 
      Score: data["Score"], 
      ObjectiveTime: data["ObjectiveTime"], 
      TimeSpentonFire: data["TimeSpentonFire"], 
      WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_soldier76(data, tag_id)
    OverHeroSoldier76.create(
      over_tag_id: tag_id, 
      HelixRocketsKills_MostinGame: data["HelixRocketsKills-MostinGame"], 
      HelixRocketsKills: data["HelixRocketsKills"], 
      TacticalVisorKills: data["TacticalVisorKills"], 
      TacticalVisorKills_MostinGame: data["TacticalVisorKills-MostinGame"], 
      BioticFieldsDeployed: data["BioticFieldsDeployed"], 
      BioticFieldHealingDone: data["BioticFieldHealingDone"], 
      MeleeFinalBlows_MostinGame: data["MeleeFinalBlows-MostinGame"], 
      TacticalVisorKills_Average: data["TacticalVisorKills-Average"], 
      HelixRocketsKills_Average: data["HelixRocketsKills-Average"], 
      Eliminations: data["Eliminations"], 
      FinalBlows: data["FinalBlows"], 
      SoloKills: data["SoloKills"], 
      ShotsFired: data["ShotsFired"], 
      ShotsHit: data["ShotsHit"], 
      CriticalHits: data["CriticalHits"], 
      DamageDone: data["DamageDone"], 
      ObjectiveKills: data["ObjectiveKills"], 
      Multikills: data["Multikills"], 
      MeleeFinalBlows: data["MeleeFinalBlows"], 
      CriticalHitsperMinute: data["CriticalHitsperMinute"], 
      CriticalHitAccuracy: data["CriticalHitAccuracy"], 
      EliminationsperLife: data["EliminationsperLife"], 
      WeaponAccuracy: data["WeaponAccuracy"], 
      HealingDone: data["HealingDone"], 
      TeleporterPadsDestroyed: data["TeleporterPadsDestroyed"], 
      TurretsDestroyed: data["TurretsDestroyed"], 
      SelfHealing: data["SelfHealing"], 
      Eliminations_MostinLife: data["Eliminations-MostinLife"], 
      MostScorewithinoneLife: data["MostScorewithinoneLife"], 
      DamageDone_MostinLife: data["DamageDone-MostinLife"],
      HealingDone_MostinLife: data["HealingDone-MostinLife"], 
      WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"], 
      KillStreak_Best: data["KillStreak-Best"], 
      DamageDone_MostinGame: data["DamageDone-MostinGame"], 
      HealingDone_MostinGame: data["HealingDone-MostinGame"], 
      Eliminations_MostinGame: data["Eliminations-MostinGame"], 
      FinalBlows_MostinGame: data["FinalBlows-MostinGame"], 
      ObjectiveKills_MostinGame: data["ObjectiveKills-MostinGame"], 
      ObjectiveTime_MostinGame: data["ObjectiveTime-MostinGame"], 
      SoloKills_MostinGame: data["SoloKills-MostinGame"], 
      CriticalHits_MostinGame: data["CriticalHits-MostinGame"], 
      CriticalHits_MostinLife: data["CriticalHits-MostinLife"], 
      SelfHealing_MostinGame: data["SelfHealing-MostinGame"], 
      SelfHealing_Average: data["SelfHealing-Average"], 
      Deaths_Average: data["Deaths-Average"], 
      SoloKills_Average: data["SoloKills-Average"], 
      ObjectiveTime_Average: data["ObjectiveTime-Average"], 
      ObjectiveKills_Average: data["ObjectiveKills-Average"], 
      HealingDone_Average: data["HealingDone-Average"], 
      FinalBlows_Average: data["FinalBlows-Average"], 
      Eliminations_Average: data["Eliminations-Average"], 
      DamageDone_Average: data["DamageDone-Average"], 
      Deaths: data["Deaths"], 
      EnvironmentalDeaths: data["EnvironmentalDeaths"], 
      Medals_Bronze: data["Medals-Bronze"], 
      Medals_Silver: data["Medals-Silver"], 
      Medals_Gold: data["Medals-Gold"], 
      Medals: data["Medals"], 
      Cards: data["Cards"], 
      TimePlayed: data["TimePlayed"], 
      GamesPlayed: data["GamesPlayed"], 
      GamesWon: data["GamesWon"], 
      Score: data["Score"], 
      ObjectiveTime: data["ObjectiveTime"], 
      TimeSpentonFire: data["TimeSpentonFire"], 
      WinPercentage: data["WinPercentage"], 
      Multikill_Best: data["Multikill-Best"]
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
end
