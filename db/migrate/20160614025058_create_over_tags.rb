class CreateOverTags < ActiveRecord::Migration
  def change
    create_table :over_tags do |t|
      t.string :tag
      t.string :tag_name
      t.string :site_url
      t.boolean :is_create_data, default: false
      t.timestamps null: false
    end
    add_index :over_tags, :tag
    add_index :over_tags, :tag_name
    add_index :over_tags, :is_create_data
  end
end
