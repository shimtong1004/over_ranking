class CreateOverHeroTracers < ActiveRecord::Migration
  def change
    create_table :over_hero_tracers do |t|
      t.integer :over_tag_id
      t.string  :PulseBombKills
      t.string  :PulseBombKills_MostinGame
      t.string  :PulseBombsAttached_MostinGame
      t.string  :PulseBombsAttached
      t.string  :PulseBombKills_Average
      t.string  :PulseBombsAttached_Average
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
      t.string  :WeaponAccuracy_BestinGame
      t.string  :KillStreak_Best
      t.string  :CriticalHits_MostinGame
      t.string  :CriticalHits_MostinLife
      t.string  :SelfHealing_MostinGame
      t.string  :SelfHealing_Average
      t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_tracers, :over_tag_id
  end
end
