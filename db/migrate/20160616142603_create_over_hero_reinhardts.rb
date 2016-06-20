class CreateOverHeroReinhardts < ActiveRecord::Migration
  def change
    create_table :over_hero_reinhardts do |t|
      t.integer :over_tag_id
      t.string  :name
      # t.string  :DamageBlocked
      # t.string  :DamageBlocked_MostinGame
      t.string  :ChargeKills
      t.string  :ChargeKills_MostinGame
      t.string  :FireStrikeKills
      t.string  :FireStrikeKills_MostinGame
      t.string  :EarthshatterKills
      t.string  :EarthshatterKills_MostinGame
      t.string  :FireStrikeKills_Average
      t.string  :EarthshatterKills_Average
      # t.string  :DamageBlocked_Average
      t.string  :ChargeKills_Average
      # t.string  :EliminationsperLife
      # t.string  :TurretsDestroyed
      # t.string  :Eliminations_MostinLife
      # t.string  :MostScorewithinoneLife
      # t.string  :DamageDone_MostinLife
      # t.string  :KillStreak_Best
      # t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_reinhardts, :over_tag_id
  end
end
