class CreateOverHeroZaryas < ActiveRecord::Migration
  def change
    create_table :over_hero_zaryas do |t|
      t.integer :over_tag_id
      t.string  :name
      # t.string  :DamageBlocked
      # t.string  :DamageBlocked_MostinGame
      t.string  :LifetimeGravitonSurgeKills
      t.string  :GravitonSurgeKills_MostinGame
      t.string  :HighEnergyKills_MostinGame
      t.string  :HighEnergyKills
      t.string  :LifetimeEnergyAccumulation
      t.string  :EnergyMaximum
      t.string  :ProjectedBarriersApplied
      t.string  :AverageEnergy_BestinGame
      t.string  :ProjectedBarriersApplied_Average
      t.string  :HighEnergyKills_Average
      t.string  :GravitonSurgeKills_Average
      # t.string  :DamageBlocked_Average
      t.string  :LifetimeAverageEnergy
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
      t.string  :ProjectedBarriersApplied_MostinGame
      t.timestamps null: false
    end
    add_index :over_hero_zaryas, :over_tag_id
  end
end
