class CreateHeroGroups < ActiveRecord::Migration
  def change
    create_table :hero_groups do |t|
      t.integer :over_user_type_id
      t.integer :play_type
      t.string  :name
      t.string  :user_type
      t.decimal :Eliminations_Average, precision: 15, scale: 2
      t.decimal :Final_Blows_Average, precision: 15, scale: 2
      t.decimal :Healing_Done_Average, precision: 15, scale: 2
      t.decimal :Damage_Done_Average, precision: 15, scale: 2
      t.decimal :Deaths_Average, precision: 15, scale: 2
      t.decimal :Solo_Kills_Average, precision: 15, scale: 2
      t.decimal :Melee_Final_Blows_Average, precision: 15, scale: 2
      t.decimal :Objective_Kills_Average, precision: 15, scale: 2
      t.decimal :Time_Spent_on_Fire_Average, precision: 15, scale: 2
      t.decimal :Objective_Time_Average, precision: 15, scale: 2
      t.decimal :Eliminations, precision: 15, scale: 2
      t.decimal :Final_Blows, precision: 15, scale: 2
      t.decimal :Solo_Kills, precision: 15, scale: 2
      t.decimal :Objective_Kills, precision: 15, scale: 2
      t.decimal :Damage_Done, precision: 15, scale: 2
      t.decimal :Multikills, precision: 15, scale: 2
      t.decimal :Melee_Final_Blows, precision: 15, scale: 2
      t.decimal :Objective_Time, precision: 15, scale: 2
      t.decimal :Time_Spent_on_Fire, precision: 15, scale: 2
      t.decimal :Environmental_Kills, precision: 15, scale: 2
      t.decimal :Healing_Done, precision: 15, scale: 2
      t.decimal :Self_Healing, precision: 15, scale: 2
      t.decimal :Recon_Assists, precision: 15, scale: 2
      t.decimal :Teleporter_Pads_Destroyed, precision: 15, scale: 2
      t.decimal :Deaths, precision: 15, scale: 2
      t.decimal :Environmental_Deaths, precision: 15, scale: 2
      t.decimal :Time_Played, precision: 15, scale: 2
      t.decimal :Weapon_Accuracy, precision: 15, scale: 2
      t.decimal :Win_Percentage, precision: 15, scale: 2
      t.decimal :Games_Won, precision: 15, scale: 2
      t.decimal :Games_Played, precision: 15, scale: 2
      t.decimal :Medals_Gold, precision: 15, scale: 2
      t.decimal :KDA, precision: 15, scale: 2
      t.decimal :KD, precision: 15, scale: 2
      t.timestamps null: false
    end
    add_index :hero_groups, [:over_user_type_id, :play_type], name: "user_type_play_type"
    add_index :hero_groups, [:name, :Time_Played, :play_type, :user_type], name: "Time_Played"
    add_index :hero_groups, [:play_type, :name, :user_type], name: "count_local"
    add_index :hero_groups, [:play_type, :name], name: "count_total"
    add_index :hero_groups, [:name, :Win_Percentage, :play_type, :user_type], name: "Win_Percentage" #승률
    add_index :hero_groups, [:name, :KD, :play_type, :user_type], name: "kd"
    add_index :hero_groups, [:name, :KDA, :play_type, :user_type], name: "kda"
    add_index :hero_groups, [:name, :Eliminations_Average, :play_type, :user_type], name: "Eliminations_Average"
    add_index :hero_groups, [:name, :Damage_Done_Average, :play_type, :user_type], name: "Damage_Done_Average"
    add_index :hero_groups, [:name, :Weapon_Accuracy, :play_type, :user_type], name: "Weapon_Accuracy"
    
    add_index :hero_groups, [:name, :Final_Blows_Average, :play_type, :user_type], name: "Final_Blows_Average"
    add_index :hero_groups, [:name, :Healing_Done_Average, :play_type, :user_type], name: "Healing_Done_Average"
    add_index :hero_groups, [:name, :Deaths_Average, :play_type, :user_type], name: "Deaths_Average"
    add_index :hero_groups, [:name, :Solo_Kills_Average, :play_type, :user_type], name: "Solo_Kills_Average"
    add_index :hero_groups, [:name, :Melee_Final_Blows_Average, :play_type, :user_type], name: "Melee_Final_Blows_Average"
    add_index :hero_groups, [:name, :Objective_Kills_Average, :play_type, :user_type], name: "Objective_Kills_Average"
    add_index :hero_groups, [:name, :Time_Spent_on_Fire_Average, :play_type, :user_type], name: "Time_Spent_on_Fire_Average" 
    add_index :hero_groups, [:name, :Objective_Time_Average, :play_type, :user_type], name: "Objective_Time_Average"
    #1분당 평균점수 획득
    
    add_index :hero_groups, [:name, :Eliminations, :play_type, :user_type], name: "Eliminations"
    add_index :hero_groups, [:name, :Final_Blows, :play_type, :user_type], name: "Final_Blows"
    add_index :hero_groups, [:name, :Solo_Kills, :play_type, :user_type], name: "Solo_Kills"
    add_index :hero_groups, [:name, :Objective_Kills, :play_type, :user_type], name: "Objective_Kills"
    add_index :hero_groups, [:name, :Damage_Done, :play_type, :user_type], name: "Damage_Done"
    add_index :hero_groups, [:name, :Multikills, :play_type, :user_type], name: "Multikills"
    add_index :hero_groups, [:name, :Melee_Final_Blows, :play_type, :user_type], name: "Melee_Final_Blows"
    add_index :hero_groups, [:name, :Objective_Time, :play_type, :user_type], name: "Objective_Time"
    add_index :hero_groups, [:name, :Time_Spent_on_Fire, :play_type, :user_type], name: "Time_Spent_on_Fire"
    add_index :hero_groups, [:name, :Environmental_Kills, :play_type, :user_type], name: "Environmental_Kills"
    add_index :hero_groups, [:name, :Healing_Done, :play_type, :user_type], name: "Healing_Done"
    add_index :hero_groups, [:name, :Self_Healing, :play_type, :user_type], name: "Self_Healing"
    add_index :hero_groups, [:name, :Recon_Assists, :play_type, :user_type], name: "Recon_Assists"
    add_index :hero_groups, [:name, :Teleporter_Pads_Destroyed, :play_type, :user_type], name: "Teleporter_Pads_Destroyed"
    add_index :hero_groups, [:name, :Deaths, :play_type, :user_type], name: "Deaths"
    add_index :hero_groups, [:name, :Environmental_Deaths, :play_type, :user_type], name: "Environmental_Deaths"
  end
end