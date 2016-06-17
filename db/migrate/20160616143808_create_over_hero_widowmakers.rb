class CreateOverHeroWidowmakers < ActiveRecord::Migration
  def change
    create_table :over_hero_widowmakers do |t|
      t.integer :over_tag_id
      t.string  :VenomMineKills
      t.string  :ScopedHits
      t.string  :ScopedShots
      t.string  :ScopedCriticalHits
      t.string  :ScopedCriticalHits_MostinGame
      t.string  :VenomMineKills_MostinGame
      # t.string  :ReconAssists_MostinGame
      t.string  :ScopedAccuracy_BestinGame
      t.string  :VenomMineKills_Average
      t.string  :ScopedCriticalHits_Average
      t.string  :ScopedAccuracy
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
    add_index :over_hero_widowmakers, :over_tag_id
  end
end
