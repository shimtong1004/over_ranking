class CreateOverHeroCommons < ActiveRecord::Migration
  def change
    create_table :over_hero_commons do |t|
      t.integer :over_hero_common_table_id
      t.string  :over_hero_common_table_type
      t.string  :Cards
      t.string  :DamageDone
      t.string  :DamageDone_Average
      t.string  :DamageDone_MostinGame
      t.string  :Deaths
      t.string  :Deaths_Average
      t.string  :DefensiveAssists_MostinGame
      t.string  :Eliminations
      t.string  :Eliminations_Average
      t.string  :Eliminations_MostinGame
      t.string  :EnvironmentalDeaths
      t.string  :EnvironmentalKills
      t.string  :FinalBlows
      t.string  :FinalBlows_Average
      t.string  :FinalBlows_MostinGame
      t.string  :GamesPlayed
      t.string  :GamesWon
      t.string  :HealingDone
      t.string  :HealingDone_Average
      t.string  :HealingDone_MostinGame
      t.string  :Medals
      t.string  :Medals_Bronze
      t.string  :Medals_Gold
      t.string  :Medals_Silver
      t.string  :MeleeFinalBlows
      t.string  :MeleeFinalBlows_MostinGame
      t.string  :Multikill_Best
      t.string  :Multikills
      t.string  :ObjectiveKills
      t.string  :ObjectiveKills_Average
      t.string  :ObjectiveKills_MostinGame
      t.string  :ObjectiveTime
      t.string  :ObjectiveTime_Average
      t.string  :ObjectiveTime_MostinGame
      t.string  :OffensiveAssists_MostinGame
      t.string  :Score
      t.string  :SoloKills
      t.string  :SoloKills_Average
      t.string  :SoloKills_MostinGame
      t.string  :TimePlayed
      t.string  :TimeSpentonFire
      t.string  :TeleporterPadsDestroyed
      t.timestamps null: false
    end
    add_index :over_hero_commons, [:over_hero_common_table_id, :over_hero_common_table_type], :name => 'hero_common_index'
  end
end
