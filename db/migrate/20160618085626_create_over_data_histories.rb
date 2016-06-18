class CreateOverDataHistories < ActiveRecord::Migration
  def change
    create_table :over_data_histories do |t|
      t.integer :over_tag_id
      t.string  :kill_death
      t.timestamps null: false
    end
    add_index :over_data_histories, :over_tag_id
  end
end
