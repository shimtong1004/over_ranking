class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.string :keyword2
      t.timestamps null: false
    end
    add_index :keywords, :keyword
  end
end
