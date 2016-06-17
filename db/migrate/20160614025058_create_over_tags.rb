class CreateOverTags < ActiveRecord::Migration
  def change
    create_table :over_tags do |t|
      t.string :tag
      t.string :site_url
      t.boolean :is_create_data, default: false
      t.timestamps null: false
    end
    add_index :over_tags, :tag
    add_index :over_tags, :is_create_data
  end
end
