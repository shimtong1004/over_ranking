class CreateOverUserTypes < ActiveRecord::Migration
  def change
    create_table :over_user_types do |t|
      t.integer :over_tag_id
      t.string  :user_type
      t.timestamps null: false
    end
    add_index :over_user_types, :over_tag_id
    add_index :over_user_types, [:over_tag_id, :user_type]
  end
end
