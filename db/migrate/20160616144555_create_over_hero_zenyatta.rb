class CreateOverHeroZenyatta < ActiveRecord::Migration
  def change
    create_table :over_hero_zenyatta do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :TranscendenceHealing_Best
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
      t.string  :TranscendenceHealing
      # t.string  :OffensiveAssists
      # t.string  :DefensiveAssists
      # t.string  :DefensiveAssists_Average
      # t.string  :OffensiveAssists_Average
      t.timestamps null: false
    end
    add_index :over_hero_zenyatta, :over_tag_id
  end
end
