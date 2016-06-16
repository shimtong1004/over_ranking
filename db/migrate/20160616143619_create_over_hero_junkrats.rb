class CreateOverHeroJunkrats < ActiveRecord::Migration
  def change
    create_table :over_hero_junkrats do |t|
      t.integer :over_tag_id
      t.string  :EnemiesTrapped_MostinGame
      t.string  :EnemiesTrapped
      t.string  :RIP_TireKills_MostinGame
      t.string  :RIP_TireKills
      t.string  :EnemiesTrappedaMinute
      t.string  :ShotsFired
      t.string  :ShotsHit
      t.string  :EliminationsperLife
      t.string  :WeaponAccuracy
      t.string  :TurretsDestroyed
      t.string  :Eliminations_MostinLife
      t.string  :MostScorewithinoneLife
      t.string  :DamageDone_MostinLife
      t.string  :WeaponAccuracy_BestinGame
      t.string  :KillStreak_Best
      t.string  :WinPercentage
      t.string  :RIP_TireKills_Average
      t.timestamps null: false
    end
    add_index :over_hero_junkrats, :over_tag_id
  end
end
