class CreateUpdateLogs < ActiveRecord::Migration
  def change
    create_table :update_logs do |t|
      t.integer :over_tag_id
      t.string  :table_name
      t.string  :sub_name
      t.string  :log_type
      t.timestamps null: false
    end
    add_index :update_logs, :over_tag_id
    add_index :update_logs, [:over_tag_id, :log_type]
    add_index :update_logs, [:over_tag_id, :table_name]
    add_index :update_logs, [:over_tag_id, :table_name, :log_type]
    add_index :update_logs, [:over_tag_id, :table_name, :log_type, :sub_name], name: "update_logs_sub_name"
  end
end
