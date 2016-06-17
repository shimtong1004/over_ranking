class CreateOverHeroCommons < ActiveRecord::Migration
  def change
    create_table :over_hero_commons do |t|
      t.integer :over_hero_common_table_id
      t.string  :over_hero_common_table_type
      t.string  :Cards
      t.string  :DamageDone
      t.string  :DamageDone_Average, :limit => 10
      t.string  :DamageDone_MostinGame
      t.string  :Deaths
      t.string  :Deaths_Average, :limit => 10
      t.string  :DefensiveAssists_MostinGame
      t.string  :Eliminations
      t.string  :Eliminations_Average, :limit => 10
      t.string  :Eliminations_MostinGame
      t.string  :EnvironmentalDeaths
      t.string  :EnvironmentalKills
      t.string  :FinalBlows
      t.string  :FinalBlows_Average, :limit => 10
      t.string  :FinalBlows_MostinGame
      t.string  :GamesPlayed
      t.string  :GamesWon
      t.string  :HealingDone
      t.string  :HealingDone_Average, :limit => 10
      t.string  :HealingDone_MostinGame
      t.string  :Medals
      t.string  :Medals_Bronze
      t.string  :Medals_Gold
      t.string  :Medals_Silver
      t.string  :MeleeFinalBlows
      t.string  :MeleeFinalBlows_MostinGame
      t.string  :Multikill_Best
      t.string  :Multikills
      t.string  :ObjectiveKills
      t.string  :ObjectiveKills_Average, :limit => 10
      t.string  :ObjectiveKills_MostinGame
      t.string  :ObjectiveTime
      t.string  :ObjectiveTime_Average, :limit => 10
      t.string  :ObjectiveTime_MostinGame
      t.string  :OffensiveAssists_MostinGame
      t.string  :Score
      t.string  :SoloKills
      t.string  :SoloKills_Average, :limit => 10
      t.string  :SoloKills_MostinGame
      t.string  :TimePlayed
      t.string  :TimeSpentonFire
      t.string  :TeleporterPadsDestroyed
      #추가 ____________
      t.string  :ShotsFired
      t.string  :ShotsHit
      t.string  :CriticalHits
      t.string  :CriticalHitsperMinute
      t.string  :CriticalHitAccuracy
      t.string  :EliminationsperLife
      t.string  :WeaponAccuracy
      t.string  :TurretsDestroyed
      t.string  :SelfHealing
      t.string  :Eliminations_MostinLife
      t.string  :MostScorewithinoneLife
      t.string  :DamageDone_MostinLife
      t.string  :HealingDone_MostinLife
      t.string  :WeaponAccuracy_BestinGame
      t.string  :KillStreak_Best
      t.string  :CriticalHits_MostinGame
      t.string  :CriticalHits_MostinLife
      t.string  :SelfHealing_MostinGame
      t.string  :SelfHealing_Average, :limit => 10
      t.string  :WinPercentage
      t.string  :DamageBlocked
      t.string  :DamageBlocked_MostinGame
      t.string  :DamageBlocked_Average, :limit => 10
      t.string  :OffensiveAssists
      t.string  :DefensiveAssists
      t.string  :DefensiveAssists_Average, :limit => 10
      t.string  :OffensiveAssists_Average, :limit => 10
      t.string  :ReconAssists_MostinGame
      t.string  :ReconAssists_Average, :limit => 10
      t.timestamps null: false
    end
    add_index :over_hero_commons, [:over_hero_common_table_id, :over_hero_common_table_type], :name => 'hero_common_index'
  end
end
