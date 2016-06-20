class CreateOverHeroPharahs < ActiveRecord::Migration
  def change
    create_table :over_hero_pharahs do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :RocketDirectHits
      t.string  :BarrageKills
      t.string  :RocketDirectHits_MostinGame
      t.string  :BarrageKills_MostinGame
      t.string  :RocketDirectHits_Average
      t.string  :BarrageKills_Average
      # t.string  :ShotsFired
      # t.string  :ShotsHit
      # t.string  :EliminationsperLife
      # t.string  :WeaponAccuracy
      # t.string  :TurretsDestroyed
      # t.string  :Eliminations_MostinLife
      # t.string  :MostScorewithinoneLife
      # t.string  :DamageDone_MostinLife
      # t.string  :WeaponAccuracy_BestinGame
      # t.string  :KillStreak_Best
      # t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_pharahs, :over_tag_id
  end
end
