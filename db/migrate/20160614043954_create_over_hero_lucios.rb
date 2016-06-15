class CreateOverHeroLucios < ActiveRecord::Migration
  def change
    create_table :over_hero_lucios, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.integer :over_tag_id
      t.string  :SoundBarriersProvided
      t.string  :SoundBarriersProvided_MostinGame 
      t.string  :MeleeFinalBlows_MostinGame 
      t.string  :SoundBarriersProvided_Average, :limit => 50 
      t.string  :Eliminations 
      t.string  :FinalBlows 
      t.string  :SoloKills 
      t.string  :ShotsFired 
      t.string  :ShotsHit 
      t.string  :CriticalHits 
      t.string  :DamageDone 
      t.string  :ObjectiveKills 
      t.string  :Multikills 
      t.string  :EnvironmentalKills 
      t.string  :MeleeFinalBlows 
      t.string  :CriticalHitsperMinute 
      t.string  :CriticalHitAccuracy 
      t.string  :EliminationsperLife 
      t.string  :WeaponAccuracy 
      t.string  :HealingDone 
      t.string  :TurretsDestroyed 
      t.string  :SelfHealing 
      t.string  :Eliminations_MostinLife 
      t.string  :MostScorewithinoneLife 
      t.string  :DamageDone_MostinLife 
      t.string  :HealingDone_MostinLife 
      t.string  :WeaponAccuracy_BestinGame 
      t.string  :KillStreak_Best 
      t.string  :DamageDone_MostinGame 
      t.string  :HealingDone_MostinGame 
      t.string  :Eliminations_MostinGame 
      t.string  :FinalBlows_MostinGame 
      t.string  :ObjectiveKills_MostinGame 
      t.string  :ObjectiveTime_MostinGame 
      t.string  :SoloKills_MostinGame 
      t.string  :CriticalHits_MostinGame 
      t.string  :CriticalHits_MostinLife 
      t.string  :SelfHealing_MostinGame 
      t.string  :SelfHealing_Average, :limit => 50
      t.string  :Deaths_Average, :limit => 50
      t.string  :SoloKills_Average, :limit => 50
      t.string  :ObjectiveTime_Average, :limit => 50
      t.string  :ObjectiveKills_Average, :limit => 50
      t.string  :HealingDone_Average, :limit => 50
      t.string  :FinalBlows_Average, :limit => 50
      t.string  :Eliminations_Average, :limit => 50
      t.string  :DamageDone_Average, :limit => 50
      t.string  :Deaths 
      t.string  :EnvironmentalDeaths 
      t.string  :Medals_Bronze 
      t.string  :Medals_Silver 
      t.string  :Medals_Gold 
      t.string  :Medals 
      t.string  :Cards 
      t.string  :TimePlayed, :limit => 20
      t.string  :GamesPlayed 
      t.string  :GamesWon 
      t.string  :Score 
      t.string  :ObjectiveTime 
      t.string  :TimeSpentonFire 
      t.string  :WinPercentage 
      t.string  :Multikill_Best 
      t.string  :OffensiveAssists 
      t.string  :OffensiveAssists_MostinGame 
      t.string  :DefensiveAssists 
      t.string  :DefensiveAssists_MostinGame 
      t.string  :DefensiveAssists_Average, :limit => 50
      t.string  :OffensiveAssists_Average, :limit => 50
      t.timestamps null: false
    end
    add_index :over_hero_lucios, :Score
  end
end
