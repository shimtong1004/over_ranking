class CreateOverHeroHanzos < ActiveRecord::Migration
  def change
    create_table :over_hero_hanzos do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :DragonstrikeKills
      t.string  :DragonstrikeKills_MostinGame
      t.string  :ScatterArrowKills
      t.string  :ScatterArrowKills_MostinGame
      # t.string  :ReconAssists_MostinGame
      t.string  :ScatterArrowKills_Average
      t.string  :DragonstrikeKills_Average
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
      # t.string  :ReconAssists_Average
      t.timestamps null: false
    end
    add_index :over_hero_hanzos, :over_tag_id
  end
end
