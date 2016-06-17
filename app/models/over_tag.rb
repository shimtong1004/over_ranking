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
      timeout(300) {
        #tag = "아아아퍼때리지마#3725"
        tag.gsub!(/#/, '-')
    
        jobs = ["Roadhog", "Reaper", "Soldier76", "Reinhardt", "Tracer", "Genji", "Lucio", "McCree", "Pharah", "Junkrat", "Widowmaker", "Mei", "Zarya", "Zenyatta", "Hanzo", "Mercy", "Torbjoern", "Symmetra", "Winston", "Bastion", "DVa"]
        status = 404
        jobs.each do |job|
          url = "https://api.lootbox.eu/pc/kr/#{tag}/hero/#{job}/"
          uri = Addressable::URI.parse(url)
          url = uri.normalize.to_s
          data = JSON.load(open(url))
          
          if data["statusCode"] != 404
            if job.eql?("Roadhog")
              obj = OverTag.create_roadhog(data, tag_id)
            elsif job.eql?("Reaper")
              obj = OverTag.create_reaper(data, tag_id)
            elsif job.eql?("Soldier76")
              obj = OverTag.create_soldier76(data, tag_id)
            elsif job.eql?("Reinhardt")
              obj = OverTag.create_reinhardt(data, tag_id)
            elsif job.eql?("Tracer")
              obj = OverTag.create_tracer(data, tag_id)
            elsif job.eql?("Genji")
              obj = OverTag.create_genji(data, tag_id)
            elsif job.eql?("Lucio")
              obj = OverTag.create_lucio(data, tag_id)
            elsif job.eql?("McCree")
              obj = OverTag.create_mccree(data, tag_id)
            elsif job.eql?("Pharah")
              obj = OverTag.create_pharah(data, tag_id)
            elsif job.eql?("Junkrat")
              obj = OverTag.create_junkrat(data, tag_id)
            elsif job.eql?("Widowmaker")
              obj = OverTag.create_widowmaker(data, tag_id)
            elsif job.eql?("Mei")
              obj = OverTag.create_mei(data, tag_id)
            elsif job.eql?("Zarya")
              obj = OverTag.create_zarya(data, tag_id)
            elsif job.eql?("Zenyatta")
              obj = OverTag.create_zenyatta(data, tag_id)
            elsif job.eql?("Hanzo")
              obj = OverTag.create_hanzo(data, tag_id)
            elsif job.eql?("Mercy")
              obj = OverTag.create_mercy(data, tag_id)
            elsif job.eql?("Torbjoern")
              obj = OverTag.create_torbjoern(data, tag_id)
            elsif job.eql?("Symmetra")
              obj = OverTag.create_symmetra(data, tag_id)
            elsif job.eql?("Winston")
              obj = OverTag.create_winston(data, tag_id)
            elsif job.eql?("Bastion")
              obj = OverTag.create_bastion(data, tag_id)
            elsif job.eql?("DVa")
              obj = OverTag.create_dva(data, tag_id)
            end
            OverTag.common_create(obj, data)
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
  
  def self.common_create(obj, data)
    obj.over_hero_common.create(
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
      EnemiesHooked_MostinGame: data["EnemiesHooked-MostinGame"],
      EnemiesHooked: data["EnemiesHooked"],
      HooksAttempted: data["HooksAttempted"],
      WholeHogKills_MostinGame: data["WholeHogKills-MostinGame"],
      WholeHogKills: data["WholeHogKills"],
      HookAccuracy_BestinGame: data["HookAccuracy-BestinGame"],
      WholeHogKills_Average: data["WholeHogKills-Average"],
      EnemiesHooked_Average: data["EnemiesHooked-Average"],
      HookAccuracy: data["HookAccuracy"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_reaper(data, tag_id)
    OverHeroReaper.create(
      over_tag_id: tag_id, 
      SoulsConsumed: data["SoulsConsumed"],
      DeathBlossomKills: data["DeathBlossomKills"],
      SoulsConsumed_MostinGame: data["SoulsConsumed-MostinGame"],
      DeathBlossomKills_MostinGame: data["DeathBlossomKills-MostinGame"],
      SoulsConsumed_Average: data["SoulsConsumed-Average"],
      DeathBlossomKills_Average: data["DeathBlossomKills-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"]
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
      TacticalVisorKills_Average: data["TacticalVisorKills-Average"],
      HelixRocketsKills_Average: data["HelixRocketsKills-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_reinhardt(data, tag_id)
    OverHeroReinhardt.create(
      over_tag_id: tag_id,
      # DamageBlocked: data["DamageBlocked"],
      # DamageBlocked_MostinGame: data["DamageBlocked-MostinGame"],
      ChargeKills: data["ChargeKills"],
      ChargeKills_MostinGame: data["ChargeKills-MostinGame"],
      FireStrikeKills: data["FireStrikeKills"],
      FireStrikeKills_MostinGame: data["FireStrikeKills-MostinGame"],
      EarthshatterKills: data["EarthshatterKills"],
      EarthshatterKills_MostinGame: data["EarthshatterKills-MostinGame"],
      FireStrikeKills_Average: data["FireStrikeKills-Average"],
      EarthshatterKills_Average: data["EarthshatterKills-Average"],
      # DamageBlocked_Average: data["DamageBlocked-Average"],
      ChargeKills_Average: data["ChargeKills-Average"]
      # EliminationsperLife: data["EliminationsperLife"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # KillStreak_Best: data["KillStreak-Best"],
      # WinPercentage: data["WinPercentage"]
    )
    
  end
  
  def self.create_tracer(data, tag_id)
    OverHeroTracer.create(
      over_tag_id: tag_id,
      PulseBombKills: data["PulseBombKills"],
      PulseBombKills_MostinGame: data["PulseBombKills-MostinGame"],
      PulseBombsAttached_MostinGame: data["PulseBombsAttached-MostinGame"],
      PulseBombsAttached: data["PulseBombsAttached"],
      PulseBombKills_Average: data["PulseBombKills-Average"],
      PulseBombsAttached_Average: data["PulseBombsAttached-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"]
    )
    
  end
  
  def self.create_genji(data, tag_id)
    OverHeroGenji.create(
      over_tag_id: tag_id,
      DragonbladeKills: data["DragonbladeKills"],
      DragonbladeKills_MostinGame: data["DragonbladeKills-MostinGame"],
      DamageReflected: data["DamageReflected"],
      DamageReflected_MostinGame: data["DamageReflected-MostinGame"],
      Dragonblades: data["Dragonblades"],
      DragonbladeKills_Average: data["DragonbladeKills-Average"],
      DamageReflected_Average: data["DamageReflected-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # WinPercentage: data["WinPercentage"]
    )
  end
              
  def self.create_lucio(data, tag_id)
    OverHeroLucio.create(
      over_tag_id: tag_id, 
      SoundBarriersProvided: data["SoundBarriersProvided"],
      SoundBarriersProvided_MostinGame: data["SoundBarriersProvided-MostinGame"],
      SoundBarriersProvided_Average: data["SoundBarriersProvided-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"],
      # OffensiveAssists: data["OffensiveAssists"],
      # DefensiveAssists: data["DefensiveAssists"],
      # DefensiveAssists_Average: data["DefensiveAssists-Average"],
      # OffensiveAssists_Average: data["OffensiveAssists-Average"]
    )
  end
  
  def self.create_mccree(data, tag_id)
    OverHeroMcCree.create(
      over_tag_id: tag_id,
      DeadeyeKills: data["DeadeyeKills"],
      DeadeyeKills_MostinGame: data["DeadeyeKills-MostinGame"],
      FantheHammerKills: data["FantheHammerKills"],
      FantheHammerKills_Average: data["FantheHammerKills-Average"],
      DeadeyeKills_Average: data["DeadeyeKills-Average"],
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # WinPercentage: data["WinPercentage"],
      FantheHammerKills_MostinGame: data["FantheHammerKills-MostinGame"]
    )
    
  end
  
  def self.create_pharah(data, tag_id)
    OverHeroPharah.create(
      over_tag_id: tag_id,
      RocketDirectHits: data["RocketDirectHits"],
      BarrageKills: data["BarrageKills"],
      RocketDirectHits_MostinGame: data["RocketDirectHits-MostinGame"],
      BarrageKills_MostinGame: data["BarrageKills-MostinGame"],
      RocketDirectHits_Average: data["RocketDirectHits-Average"],
      BarrageKills_Average: data["BarrageKills-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_junkrat(data, tag_id)
    OverHeroJunkrat.create(
      over_tag_id: tag_id,
      EnemiesTrapped_MostinGame: data["EnemiesTrapped-MostinGame"],
      EnemiesTrapped: data["EnemiesTrapped"],
      RIP_TireKills_MostinGame: data["RIP-TireKills-MostinGame"],
      RIP_TireKills: data["RIP-TireKills"],
      EnemiesTrappedaMinute: data["EnemiesTrappedaMinute"],
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # WinPercentage: data["WinPercentage"],
      RIP_TireKills_Average: data["RIP-TireKills-Average"]
    )
  end
  
  def self.create_widowmaker(data, tag_id)
    OverHeroWidowmaker.create(
      over_tag_id: tag_id,
      VenomMineKills: data["VenomMineKills"],
      ScopedHits: data["ScopedHits"],
      ScopedShots: data["ScopedShots"],
      ScopedCriticalHits: data["ScopedCriticalHits"],
      ScopedCriticalHits_MostinGame: data["ScopedCriticalHits-MostinGame"],
      VenomMineKills_MostinGame: data["VenomMineKills-MostinGame"],
      # ReconAssists_MostinGame: data["ReconAssists-MostinGame"],
      ScopedAccuracy_BestinGame: data["ScopedAccuracy-BestinGame"],
      VenomMineKills_Average: data["VenomMineKills-Average"],
      ScopedCriticalHits_Average: data["ScopedCriticalHits-Average"],
      ScopedAccuracy: data["ScopedAccuracy"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # WinPercentage: data["WinPercentage"],
      # ReconAssists_Average: data["ReconAssists-Average"]
    )
  end
  
  def self.create_mei(data, tag_id)
    OverHeroMei.create(
      over_tag_id: tag_id,
      EnemiesFrozen: data["EnemiesFrozen"],
      EnemiesFrozen_MostinGame: data["EnemiesFrozen-MostinGame"],
      BlizzardKills_MostinGame: data["BlizzardKills-MostinGame"],
      BlizzardKills: data["BlizzardKills"],
      # DamageBlocked_MostinGame: data["DamageBlocked-MostinGame"],
      # DamageBlocked: data["DamageBlocked"],
      EnemiesFrozen_Average: data["EnemiesFrozen-Average"],
      # DamageBlocked_Average: data["DamageBlocked-Average"],
      BlizzardKills_Average: data["BlizzardKills-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_zarya(data, tag_id)
    OverHeroZarya.create(
      over_tag_id: tag_id,
      # DamageBlocked: data["DamageBlocked"],
      # DamageBlocked_MostinGame: data["DamageBlocked-MostinGame"],
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
      # DamageBlocked_Average: data["DamageBlocked-Average"],
      LifetimeAverageEnergy: data["LifetimeAverageEnergy"],
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # WinPercentage: data["WinPercentage"],
      ProjectedBarriersApplied_MostinGame: data["ProjectedBarriersApplied-MostinGame"]
    )
  end
  
  def self.create_zenyatta(data, tag_id)
    OverHeroZenyattum.create(
      over_tag_id: tag_id,
      TranscendenceHealing_Best: data["TranscendenceHealing-Best"],
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"],
      TranscendenceHealing: data["TranscendenceHealing"]
      # OffensiveAssists: data["OffensiveAssists"],
      # DefensiveAssists: data["DefensiveAssists"],
      # DefensiveAssists_Average: data["DefensiveAssists-Average"],
      # OffensiveAssists_Average: data["OffensiveAssists-Average"]
    )
  end
  
  def self.create_hanzo(data, tag_id)
    OverHeroHanzo.create(
      over_tag_id: tag_id,
      DragonstrikeKills: data["DragonstrikeKills"],
      DragonstrikeKills_MostinGame: data["DragonstrikeKills-MostinGame"],
      ScatterArrowKills: data["ScatterArrowKills"],
      ScatterArrowKills_MostinGame: data["ScatterArrowKills-MostinGame"],
      # ReconAssists_MostinGame: data["ReconAssists-MostinGame"],
      ScatterArrowKills_Average: data["ScatterArrowKills-Average"],
      DragonstrikeKills_Average: data["DragonstrikeKills-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # WinPercentage: data["WinPercentage"],
      # ReconAssists_Average: data["ReconAssists-Average"]
    )
  end
  
  def self.create_mercy(data, tag_id)
    OverHeroMercy.create(
      over_tag_id: tag_id,
      PlayersResurrected: data["PlayersResurrected"],
      PlayersResurrected_MostinGame: data["PlayersResurrected-MostinGame"],
      PlayersSaved: data["PlayersSaved"],
      MostPlayersSavedinaGame: data["MostPlayersSavedinaGame"],
      PlayersSaved_Average: data["PlayersSaved-Average"],
      PlayersResurrected_Average: data["PlayersResurrected-Average"],
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"],
      BlasterKills: data["BlasterKills"],
      BlasterKills_MostinGame: data["BlasterKills-MostinGame"],
      # OffensiveAssists: data["OffensiveAssists"],
      # DefensiveAssists: data["DefensiveAssists"],
      # DefensiveAssists_Average: data["DefensiveAssists-Average"],
      # OffensiveAssists_Average: data["OffensiveAssists-Average"],
      BlasterKills_Average: data["BlasterKills-Average"]
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
      TurretKills_Average: data["TurretKills-Average"],
      TorbjoernKills_Average: data["Torbj&#xF6;rnKills-Average"],
      MoltenCoreKills_Average: data["MoltenCoreKills-Average"],
      ArmorPacksCreated_Average: data["ArmorPacksCreated-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_symmetra(data, tag_id)
    OverHeroSymmetra.create(
      over_tag_id: tag_id,
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
      # EliminationsperLife: data["EliminationsperLife"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # KillStreak_Best: data["KillStreak-Best"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_winston(data, tag_id)
    OverHeroWinston.create(
      over_tag_id: tag_id,
      PlayersKnockedBack: data["PlayersKnockedBack"],
      # DamageBlocked: data["DamageBlocked"],
      # DamageBlocked_MostinGame: data["DamageBlocked-MostinGame"],
      PlayersKnockedBack_MostinGame: data["PlayersKnockedBack-MostinGame"],
      MeleeKills: data["MeleeKills"],
      MeleeKills_MostinGame: data["MeleeKills-MostinGame"],
      JumpPackKills: data["JumpPackKills"],
      JumpPackKills_MostinGame: data["JumpPackKills-MostinGame"],
      PlayersKnockedBack_Average: data["PlayersKnockedBack-Average"],
      MeleeKills_Average: data["MeleeKills-Average"],
      JumpPackKills_Average: data["JumpPackKills-Average"],
      # DamageBlocked_Average: data["DamageBlocked-Average"],
      # EliminationsperLife: data["EliminationsperLife"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # KillStreak_Best: data["KillStreak-Best"],
      # WinPercentage: data["WinPercentage"],
      PrimalRageKills: data["PrimalRageKills"],
      PrimalRageKills_MostinGame: data["PrimalRageKills-MostinGame"],
      PrimalRageKills_Average: data["PrimalRageKills-Average"]
    )
  end
  
  def self.create_bastion(data, tag_id)
    OverHeroBastion.create(
      over_tag_id: tag_id,
      ReconKills: data["ReconKills"],
      SentryKills: data["SentryKills"],
      TankKills: data["TankKills"],
      SentryKills_MostinGame: data["SentryKills-MostinGame"],
      ReconKills_MostinGame: data["ReconKills-MostinGame"],
      TankKills_MostinGame: data["TankKills-MostinGame"],
      TankKills_Average: data["TankKills-Average"],
      SentryKills_Average: data["SentryKills-Average"],
      ReconKills_Average: data["ReconKills-Average"]
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # SelfHealing: data["SelfHealing"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # HealingDone_MostinLife: data["HealingDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # SelfHealing_MostinGame: data["SelfHealing-MostinGame"],
      # SelfHealing_Average: data["SelfHealing-Average"],
      # WinPercentage: data["WinPercentage"]
    )
  end
  
  def self.create_dva(data, tag_id)
    OverHeroDva.create(
      over_tag_id: tag_id,
      MechsCalled: data["MechsCalled"],
      MechsCalled_MostinGame: data["MechsCalled-MostinGame"],
      # DamageBlocked_MostinGame: data["DamageBlocked-MostinGame"],
      # DamageBlocked: data["DamageBlocked"],
      MechDeaths: data["MechDeaths"],
      MechsCalled_Average: data["MechsCalled-Average"],
      # DamageBlocked_Average: data["DamageBlocked-Average"],
      # ShotsFired: data["ShotsFired"],
      # ShotsHit: data["ShotsHit"],
      # CriticalHits: data["CriticalHits"],
      # CriticalHitsperMinute: data["CriticalHitsperMinute"],
      # CriticalHitAccuracy: data["CriticalHitAccuracy"],
      # EliminationsperLife: data["EliminationsperLife"],
      # WeaponAccuracy: data["WeaponAccuracy"],
      # TurretsDestroyed: data["TurretsDestroyed"],
      # Eliminations_MostinLife: data["Eliminations-MostinLife"],
      # MostScorewithinoneLife: data["MostScorewithinoneLife"],
      # DamageDone_MostinLife: data["DamageDone-MostinLife"],
      # WeaponAccuracy_BestinGame: data["WeaponAccuracy-BestinGame"],
      # KillStreak_Best: data["KillStreak-Best"],
      # CriticalHits_MostinGame: data["CriticalHits-MostinGame"],
      # CriticalHits_MostinLife: data["CriticalHits-MostinLife"],
      # WinPercentage: data["WinPercentage"],
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

end








