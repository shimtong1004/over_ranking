class CreateOverHeros < ActiveRecord::Migration
  def change
    create_table :over_heros do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :playtime
      t.integer :playtime_min
      t.text  :image
      t.string  :percentage
      t.timestamps null: false
    end
    add_index :over_heros, [:over_tag_id, :name]
  end
end
