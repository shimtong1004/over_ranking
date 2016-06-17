class CreateOverHeroRoadhogs < ActiveRecord::Migration
  def change
    create_table :over_hero_roadhogs do |t|
      t.integer :over_tag_id
      t.string  :EnemiesHooked_MostinGame
      t.string  :EnemiesHooked
      t.string  :HooksAttempted
      t.string  :WholeHogKills_MostinGame
      t.string  :WholeHogKills
      t.string  :HookAccuracy_BestinGame
      t.string  :WholeHogKills_Average
      t.string  :EnemiesHooked_Average
      t.string  :HookAccuracy
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
    add_index :over_hero_roadhogs, :over_tag_id
  end
end
