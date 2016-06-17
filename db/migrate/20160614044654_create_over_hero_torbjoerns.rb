class CreateOverHeroTorbjoerns < ActiveRecord::Migration
  def change
    create_table :over_hero_torbjoerns do |t|
      t.integer :over_tag_id
      t.string  :ArmorPacksCreated
      t.string  :TorbjoernKills
      t.string  :TurretKills
      t.string  :TorbjoernKills_MostinGame
      t.string  :MoltenCoreKills
      t.string  :MoltenCoreKills_MostinGame
      t.string  :TurretKills_Average
      t.string  :TorbjoernKills_Average
      t.string  :MoltenCoreKills_Average
      t.string  :ArmorPacksCreated_Average
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
      t.timestamps null: false
    end
    add_index :over_hero_torbjoerns, :over_tag_id
  end
end
