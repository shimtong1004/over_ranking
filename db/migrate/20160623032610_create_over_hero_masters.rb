class CreateOverHeroMasters < ActiveRecord::Migration
  def change
    create_table :over_hero_masters do |t|
      t.integer :over_user_type_id
      t.integer :play_type
      t.string  :hero_name
      t.string  :keyword
      t.string  :value
      t.string  :view_group
      t.string  :view_group_detail
      t.timestamps null: false
    end
    add_index :over_hero_masters, :over_user_type_id
    add_index :over_hero_masters, [:over_user_type_id, :play_type]
    add_index :over_hero_masters, [:play_type, :over_user_type_id, :hero_name], name: "over_hero_id_name"
    add_index :over_hero_masters, [:play_type, :over_user_type_id, :keyword], name: "over_hero_id_keyword"
    add_index :over_hero_masters, [:play_type, :over_user_type_id, :hero_name, :keyword], name: "over_hero_id_name_keyword"
    add_index :over_hero_masters, [:play_type, :over_user_type_id, :hero_name, :view_group], name: "over_hero_id_name_grop"
    add_index :over_hero_masters, [:play_type, :over_user_type_id, :hero_name, :view_group, :view_group_detail], name: "over_hero_id_name_grop_detail"
    
  end
end
