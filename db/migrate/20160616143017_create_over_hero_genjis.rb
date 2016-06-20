class CreateOverHeroGenjis < ActiveRecord::Migration
  def change
    create_table :over_hero_genjis do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :DragonbladeKills
      t.string  :DragonbladeKills_MostinGame
      t.string  :DamageReflected
      t.string  :DamageReflected_MostinGame
      t.string  :Dragonblades
      t.string  :DragonbladeKills_Average
      t.string  :DamageReflected_Average
      # t.string  :ShotsFired
      # t.string  :ShotsHit
      # t.string  :CriticalHits
      # t.string  :CriticalHitsperMinute
      # t.string  :CriticalHitAccuracy
      # t.string  :EliminationsperLife
      # t.string  :WeaponAccuracy
      # t.string  :TurretsDestroyed
      # t.string  :Eliminations_MostinLife
      # t.string  :MostScorewithinoneLife
      # t.string  :DamageDone_MostinLife
      # t.string  :WeaponAccuracy_BestinGame
      # t.string  :KillStreak_Best
      # t.string  :CriticalHits_MostinGame
      # t.string  :CriticalHits_MostinLife
      # t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_genjis, :over_tag_id
  end
end
