class CreateOverTags < ActiveRecord::Migration
  def change
    create_table :over_tags do |t|
      t.string :tag
      t.string :tag_name
      t.string :site_url
      t.datetime :data_updated_at
      t.timestamps null: false
    end
    add_index :over_tags, :tag
    add_index :over_tags, :tag_name
  end
end
