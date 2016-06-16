class CreateOverHeroMcCrees < ActiveRecord::Migration
  def change
    create_table :over_hero_mc_crees do |t|
      t.integer :over_tag_id
      t.string  :DeadeyeKills
      t.string  :DeadeyeKills_MostinGame
      t.string  :FantheHammerKills
      t.string  :FantheHammerKills_Average
      t.string  :DeadeyeKills_Average
      t.string  :ShotsFired
      t.string  :ShotsHit
      t.string  :CriticalHits
      t.string  :CriticalHitsperMinute
      t.string  :CriticalHitAccuracy
      t.string  :EliminationsperLife
      t.string  :WeaponAccuracy
      t.string  :TurretsDestroyed
      t.string  :Eliminations_MostinLife
      t.string  :MostScorewithinoneLife
      t.string  :DamageDone_MostinLife
      t.string  :WeaponAccuracy_BestinGame
      t.string  :KillStreak_Best
      t.string  :CriticalHits_MostinGame
      t.string  :CriticalHits_MostinLife
      t.string  :WinPercentage
      t.string  :FantheHammerKills_MostinGame
      t.timestamps null: false
    end
    add_index :over_hero_mc_crees, :over_tag_id
  end
end
