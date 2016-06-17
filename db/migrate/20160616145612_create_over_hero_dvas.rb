class CreateOverHeroDvas < ActiveRecord::Migration
  def change
    create_table :over_hero_dvas do |t|
      t.integer :over_tag_id
      t.string  :MechsCalled
      t.string  :MechsCalled_MostinGame
      # t.string  :DamageBlocked_MostinGame
      # t.string  :DamageBlocked
      t.string  :MechDeaths
      t.string  :MechsCalled_Average
      # t.string  :DamageBlocked_Average
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
      t.string  :Self_DestructKills
      t.string  :Self_DestructKills_MostinGame
      t.string  :Self_DestructKills_Average
      t.timestamps null: false
    end
    add_index :over_hero_dvas, :over_tag_id
  end
end
