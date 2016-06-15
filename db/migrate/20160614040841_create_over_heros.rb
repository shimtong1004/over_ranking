class CreateOverHeros < ActiveRecord::Migration
  def change
    create_table :over_heros do |t|
      t.integer :over_tag_id
      t.string  :name
      t.string  :playtime
      t.text  :image
      t.string  :percentage
      t.timestamps null: false
    end
  end
end
