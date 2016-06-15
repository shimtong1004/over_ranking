class CreateOverTags < ActiveRecord::Migration
  def change
    create_table :over_tags do |t|
      t.string :tag
      t.timestamps null: false
    end
    add_index :over_tags, :tag
  end
end
