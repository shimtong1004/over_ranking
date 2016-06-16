class CreateOverHeroSymmetras < ActiveRecord::Migration
  def change
    create_table :over_hero_symmetras do |t|
      t.integer :over_tag_id
      t.string  :SentryTurretKills
      t.string  :SentryTurretKills_MostinGame
      t.string  :PlayersTeleported
      t.string  :PlayersTeleported_MostinGame
      t.string  :ShieldsProvided
      t.string  :ShieldsProvided_MostinGame
      t.string  :TeleporterUptime
      t.string  :TeleporterUptime_BestinGame
      t.string  :ShieldsProvided_Average
      t.string  :SentryTurretKills_Average
      t.string  :PlayersTeleported_Average
      t.string  :TeleporterUptime_Average
      t.string  :EliminationsperLife
      t.string  :Eliminations_MostinLife
      t.string  :MostScorewithinoneLife
      t.string  :DamageDone_MostinLife
      t.string  :KillStreak_Best
      t.string  :WinPercentage
      t.timestamps null: false
    end
    add_index :over_hero_symmetras, :over_tag_id
  end
end
