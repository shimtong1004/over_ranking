class CreateOverHeroReapers < ActiveRecord::Migration
  def change
    create_table :over_hero_reapers do |t|
      t.integer :over_tag_id
      t.string  :SoulsConsumed
      t.string  :DeathBlossomKills
      t.string  :SoulsConsumed_MostinGame
      t.string  :DeathBlossomKills_MostinGame
      t.string  :SoulsConsumed_Average
      t.string  :DeathBlossomKills_Average
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
      t.string  :SelfHealing_Average
      t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_reapers, :over_tag_id
  end
end
