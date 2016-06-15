class CreateOverHeroSoldier76s < ActiveRecord::Migration
  def change
    create_table :over_hero_soldier76s, options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.integer :over_tag_id
      t.string  :HelixRocketsKills_MostinGame 
      t.string  :HelixRocketsKills 
      t.string  :TacticalVisorKills 
      t.string  :TacticalVisorKills_MostinGame 
      t.string  :BioticFieldsDeployed 
      t.string  :BioticFieldHealingDone 
      t.string  :MeleeFinalBlows_MostinGame 
      t.string  :TacticalVisorKills_Average, :limit => 50
      t.string  :HelixRocketsKills_Average, :limit => 50
      t.string  :Eliminations 
      t.string  :FinalBlows 
      t.string  :SoloKills 
      t.string  :ShotsFired 
      t.string  :ShotsHit 
      t.string  :CriticalHits 
      t.string  :DamageDone 
      t.string  :ObjectiveKills 
      t.string  :Multikills 
      t.string  :MeleeFinalBlows 
      t.string  :CriticalHitsperMinute 
      t.string  :CriticalHitAccuracy 
      t.string  :EliminationsperLife 
      t.string  :WeaponAccuracy 
      t.string  :HealingDone 
      t.string  :TeleporterPadsDestroyed 
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
      t.string  :WinPercentage, :limit => 10
      t.string  :Multikill_Best
      t.timestamps null: false
    end
    add_index :over_hero_soldier76s, :Score
  end
end
