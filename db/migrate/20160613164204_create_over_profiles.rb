class CreateOverProfiles < ActiveRecord::Migration
  def change
    create_table :over_profiles do |t|
      t.integer :over_tag_id
      t.string  :username
      t.string  :level
      t.string  :playtime
      t.text  :avatar
      t.string  :win_percentage
      t.string  :wins
      t.string  :lost
      t.string  :played
      t.timestamps null: false
    end
  end
end
