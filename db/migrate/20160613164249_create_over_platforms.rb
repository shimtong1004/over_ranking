class CreateOverPlatforms < ActiveRecord::Migration
  def change
    create_table :over_platforms do |t|
      t.integer :over_tag_id
      t.string  :platform
      t.string  :region
      t.boolean  :hasAccount
      t.timestamps null: false
    end
  end
end
