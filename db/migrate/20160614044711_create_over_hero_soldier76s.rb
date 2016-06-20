class CreateOverHeroSoldier76s < ActiveRecord::Migration
  def change
    create_table :over_hero_soldier76s do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :HelixRocketsKills_MostinGame
      t.string  :HelixRocketsKills
      t.string  :TacticalVisorKills
      t.string  :TacticalVisorKills_MostinGame
      t.string  :BioticFieldsDeployed
      t.string  :BioticFieldHealingDone
      t.string  :TacticalVisorKills_Average
      t.string  :HelixRocketsKills_Average
      # t.string  :ShotsFired
      # t.string  :ShotsHit
      # t.string  :CriticalHits
      # t.string  :CriticalHitsperMinute
      # t.string  :CriticalHitAccuracy
      # t.string  :EliminationsperLife
      # t.string  :WeaponAccuracy
      # t.string  :TurretsDestroyed
      # t.string  :SelfHealing
      # t.string  :Eliminations_MostinLife
      # t.string  :MostScorewithinoneLife
      # t.string  :DamageDone_MostinLife
      # t.string  :HealingDone_MostinLife
      # t.string  :WeaponAccuracy_BestinGame
      # t.string  :KillStreak_Best
      # t.string  :CriticalHits_MostinGame
      # t.string  :CriticalHits_MostinLife
      # t.string  :SelfHealing_MostinGame
      # t.string  :SelfHealing_Average
      # t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_soldier76s, :over_tag_id
  end
end
