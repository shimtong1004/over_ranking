class CreateOverHeroWinstons < ActiveRecord::Migration
  def change
    create_table :over_hero_winstons do |t|
      t.integer :over_tag_id
      t.string  :PlayersKnockedBack
      t.string  :DamageBlocked
      t.string  :DamageBlocked_MostinGame
      t.string  :PlayersKnockedBack_MostinGame
      t.string  :MeleeKills
      t.string  :MeleeKills_MostinGame
      t.string  :JumpPackKills
      t.string  :JumpPackKills_MostinGame
      t.string  :PlayersKnockedBack_Average
      t.string  :MeleeKills_Average
      t.string  :JumpPackKills_Average
      t.string  :DamageBlocked_Average
      t.string  :EliminationsperLife
      t.string  :TurretsDestroyed
      t.string  :Eliminations_MostinLife
      t.string  :MostScorewithinoneLife
      t.string  :DamageDone_MostinLife
      t.string  :KillStreak_Best
      t.string  :WinPercentage
      t.string  :PrimalRageKills
      t.string  :PrimalRageKills_MostinGame
      t.string  :PrimalRageKills_Average
      t.timestamps null: false
    end
    add_index :over_hero_winstons, :over_tag_id
  end
end
