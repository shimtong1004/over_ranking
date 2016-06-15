class CreateOverAllHeros < ActiveRecord::Migration
  def change
    create_table :over_all_heros do |t|
      t.integer :over_tag_id
      t.string  :MeleeFinalBlows
      t.string  :SoloKills
      t.string  :ObjectiveKills
      t.string  :FinalBlows
      t.string  :DamageDone
      t.string  :Eliminations
      t.string  :EnvironmentalKills
      t.string  :Multikills
      t.string  :HealingDone
      t.string  :ReconAssists
      t.string  :TeleporterPadsDestroyed
      t.string  :Eliminations_MostinGame
      t.string  :FinalBlows_MostinGame
      t.string  :DamageDone_MostinGame
      t.string  :HealingDone_MostinGame
      t.string  :DefensiveAssists_MostinGame
      t.string  :OffensiveAssists_MostinGame
      t.string  :ObjectiveKills_MostinGame
      t.string  :ObjectiveTime_MostinGame
      t.string  :Multikill_Best
      t.string  :SoloKills_MostinGame
      t.string  :TimeSpentonFire_MostinGame
      t.string  :MeleeFinalBlows_Average
      t.string  :FinalBlows_Average
      t.string  :TimeSpentonFire_Average
      t.string  :SoloKills_Average
      t.string  :ObjectiveTime_Average
      t.string  :ObjectiveKills_Average
      t.string  :HealingDone_Average
      t.string  :Deaths_Average
      t.string  :DamageDone_Average
      t.string  :Eliminations_Average
      t.string  :Deaths
      t.string  :EnvironmentalDeaths
      t.string  :Cards
      t.string  :Medals
      t.string  :Medals_Gold
      t.string  :Medals_Silver
      t.string  :Medals_Bronze
      t.string  :GamesWon
      t.string  :GamesPlayed
      t.string  :TimeSpentonFire
      t.string  :ObjectiveTime
      t.string  :Score
      t.string  :TimePlayed
      t.string  :MeleeFinalBlows_MostinGame
      t.string  :DefensiveAssists
      t.string  :DefensiveAssists_Average
      t.string  :OffensiveAssists
      t.string  :OffensiveAssists_Average
      t.timestamps null: false
    end
  end
end
