class CreateOverHeroMeis < ActiveRecord::Migration
  def change
    create_table :over_hero_meis do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :EnemiesFrozen
      t.string  :EnemiesFrozen_MostinGame
      t.string  :BlizzardKills_MostinGame
      t.string  :BlizzardKills
      # t.string  :DamageBlocked_MostinGame
      # t.string  :DamageBlocked
      t.string  :EnemiesFrozen_Average
      # t.string  :DamageBlocked_Average
      t.string  :BlizzardKills_Average
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
    add_index :over_hero_meis, :over_tag_id
  end
end
