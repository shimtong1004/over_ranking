class CreateOverAchievements < ActiveRecord::Migration
  def change
    create_table :over_achievements do |t|
      t.integer :over_tag_id
      t.string  :finishedAchievements
      t.string  :name
      t.string  :finished
      t.text  :image
      t.timestamps null: false
    end
  end
end
