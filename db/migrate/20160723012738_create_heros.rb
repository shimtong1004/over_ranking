class CreateHeros < ActiveRecord::Migration
  def change
    create_table :heros do |t|
      t.integer :over_user_type_id
      t.integer :play_type
      t.string  :name
      t.integer :level
      t.integer :competitive_rank
      t.string  :main_hero_name
      # t.boolean :is_update, default: false
      t.string  :user_type
      t.decimal :Melee_Final_Blows, precision: 15, scale: 2, default: 0
      t.decimal :Solo_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Objective_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Final_Blows, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Done, precision: 15, scale: 2, default: 0
      t.decimal :Eliminations, precision: 15, scale: 2, default: 0
      t.decimal :Environmental_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Multikills, precision: 15, scale: 2, default: 0
      t.decimal :Healing_Done, precision: 15, scale: 2, default: 0
      t.decimal :Recon_Assists, precision: 15, scale: 2, default: 0
      t.decimal :Teleporter_Pads_Destroyed, precision: 15, scale: 2, default: 0
      t.decimal :Eliminations_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Final_Blows_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Done_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Healing_Done_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Defensive_Assists_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Offensive_Assists_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Objective_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Objective_Time_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Multikill_Best, precision: 15, scale: 2, default: 0
      t.decimal :Solo_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Time_Spent_on_Fire_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Melee_Final_Blows_Average, precision: 15, scale: 2, default: 0
      t.decimal :Time_Spent_on_Fire_Average, precision: 15, scale: 2, default: 0
      t.decimal :Solo_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Objective_Time_Average, precision: 15, scale: 2, default: 0
      t.decimal :Objective_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Healing_Done_Average, precision: 15, scale: 2, default: 0
      t.decimal :Final_Blows_Average, precision: 15, scale: 2, default: 0
      t.decimal :Deaths_Average, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Done_Average, precision: 15, scale: 2, default: 0
      t.decimal :Eliminations_Average, precision: 15, scale: 2, default: 0
      t.decimal :Deaths, precision: 15, scale: 2, default: 0
      t.decimal :Environmental_Deaths, precision: 15, scale: 2, default: 0
      t.decimal :Cards, precision: 15, scale: 2, default: 0
      t.decimal :Medals, precision: 15, scale: 2, default: 0
      t.decimal :Medals_Gold, precision: 15, scale: 2, default: 0
      t.decimal :Medals_Silver, precision: 15, scale: 2, default: 0
      t.decimal :Medals_Bronze, precision: 15, scale: 2, default: 0
      t.decimal :Games_Won, precision: 15, scale: 2, default: 0
      t.decimal :Games_Played, precision: 15, scale: 2, default: 0
      t.decimal :Time_Spent_on_Fire, precision: 15, scale: 2, default: 0
      t.decimal :Objective_Time, precision: 15, scale: 2, default: 0
      t.decimal :Time_Played, precision: 15, scale: 2, default: 0
      t.decimal :Melee_Final_Blows_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Defensive_Assists, precision: 15, scale: 2, default: 0
      t.decimal :Defensive_Assists_Average, precision: 15, scale: 2, default: 0
      t.decimal :Offensive_Assists, precision: 15, scale: 2, default: 0
      t.decimal :Offensive_Assists_Average, precision: 15, scale: 2, default: 0
      t.decimal :Souls_Consumed, precision: 15, scale: 2, default: 0
      t.decimal :Death_Blossom_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Souls_Consumed_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Death_Blossom_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Souls_Consumed_Average, precision: 15, scale: 2, default: 0
      t.decimal :Death_Blossom_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Critical_Hits, precision: 15, scale: 2, default: 0
      t.decimal :Critical_Hit_Accuracy, precision: 15, scale: 2, default: 0
      t.decimal :Eliminations_per_Life, precision: 15, scale: 2, default: 0
      t.decimal :Weapon_Accuracy, precision: 15, scale: 2, default: 0
      t.decimal :Self_Healing, precision: 15, scale: 2, default: 0
      t.decimal :Eliminations_Most_in_Life, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Done_Most_in_Life, precision: 15, scale: 2, default: 0
      t.decimal :Healing_Done_Most_in_Life, precision: 15, scale: 2, default: 0
      t.decimal :Kill_Streak_Best, precision: 15, scale: 2, default: 0
      t.decimal :Critical_Hits_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Critical_Hits_Most_in_Life, precision: 15, scale: 2, default: 0
      t.decimal :Self_Healing_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Win_Percentage, precision: 15, scale: 2, default: 0
      t.decimal :Pulse_Bomb_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Pulse_Bomb_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Pulse_Bombs_Attached_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Pulse_Bombs_Attached, precision: 15, scale: 2, default: 0
      t.decimal :Pulse_Bomb_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Pulse_Bombs_Attached_Average, precision: 15, scale: 2, default: 0
      t.decimal :Players_Resurrected, precision: 15, scale: 2, default: 0
      t.decimal :Players_Resurrected_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Players_Resurrected_Average, precision: 15, scale: 2, default: 0
      t.decimal :Blaster_Kill, precision: 15, scale: 2, default: 0
      t.decimal :Blaster_Kill_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Blaster_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Dragonstrike_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Dragonstrike_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Scatter_Arrow_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Scatter_Arrow_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Recon_Assists_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Recon_Assists_Average, precision: 15, scale: 2, default: 0
      t.decimal :Scatter_Arrow_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Dragonstrike_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Armor_Packs_Created, precision: 15, scale: 2, default: 0
      t.decimal :Torbjörn_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Turret_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Torbjörn_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Molten_Core_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Molten_Core_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Turret_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Torbjörn_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Molten_Core_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Armor_Packs_Created_Average, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Blocked, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Blocked_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Charge_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Charge_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Fire_Strike_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Fire_Strike_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Earthshatter_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Earthshatter_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Fire_Strike_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Earthshatter_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Blocked_Average, precision: 15, scale: 2, default: 0
      t.decimal :Charge_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Rocket_Direct_Hits, precision: 15, scale: 2, default: 0
      t.decimal :Barrage_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Rocket_Direct_Hits_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Barrage_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Rocket_Direct_Hits_Average, precision: 15, scale: 2, default: 0
      t.decimal :Barrage_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Players_Knocked_Back, precision: 15, scale: 2, default: 0
      t.decimal :Players_Knocked_Back_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Melee_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Melee_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Jump_Pack_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Jump_Pack_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Players_Knocked_Back_Average, precision: 15, scale: 2, default: 0
      t.decimal :Melee_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Jump_Pack_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Primal_Rage_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Primal_Rage_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Primal_Rage_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Venom_Mine_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Scoped_Critical_Hits, precision: 15, scale: 2, default: 0
      t.decimal :Scoped_Critical_Hits_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Venom_Mine_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Scoped_Accuracy_Best_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Venom_Mine_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Scoped_Critical_Hits_Average, precision: 15, scale: 2, default: 0
      t.decimal :Scoped_Accuracy, precision: 15, scale: 2, default: 0
      t.decimal :Recon_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Sentry_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Tank_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Sentry_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Recon_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Tank_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Tank_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Sentry_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Recon_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Sentry_Turret_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Sentry_Turret_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Players_Teleported, precision: 15, scale: 2, default: 0
      t.decimal :Players_Teleported_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Shields_Provided, precision: 15, scale: 2, default: 0
      t.decimal :Shields_Provided_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Teleporter_Uptime, precision: 15, scale: 2, default: 0
      t.decimal :Teleporter_Uptime_Best_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Shields_Provided_Average, precision: 15, scale: 2, default: 0
      t.decimal :Sentry_Turret_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Players_Teleported_Average, precision: 15, scale: 2, default: 0
      t.decimal :Teleporter_Uptime_Average, precision: 15, scale: 2, default: 0
      t.decimal :Transcendence_Healing_Best, precision: 15, scale: 2, default: 0
      t.decimal :Transcendence_Healing, precision: 15, scale: 2, default: 0
      t.decimal :Dragonblade_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Dragonblade_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Reflected, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Reflected_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Dragonblade_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Damage_Reflected_Average, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Hooked_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Hooked, precision: 15, scale: 2, default: 0
      t.decimal :Hooks_Attempted, precision: 15, scale: 2, default: 0
      t.decimal :Whole_Hog_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Whole_Hog_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Hook_Accuracy_Best_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Whole_Hog_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Hooked_Average, precision: 15, scale: 2, default: 0
      t.decimal :Hook_Accuracy, precision: 15, scale: 2, default: 0
      t.decimal :Deadeye_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Deadeye_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Fan_the_Hammer_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Fan_the_Hammer_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Deadeye_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Fan_the_Hammer_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Trapped_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Trapped, precision: 15, scale: 2, default: 0
      t.decimal :RIP_Tire_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :RIP_Tire_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Trapped_a_Minute, precision: 15, scale: 2, default: 0
      t.decimal :RIP_Tire_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Lifetime_Graviton_Surge_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Graviton_Surge_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :High_Energy_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :High_Energy_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Projected_Barriers_Applied, precision: 15, scale: 2, default: 0
      t.decimal :Average_Energy_Best_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Projected_Barriers_Applied_Average, precision: 15, scale: 2, default: 0
      t.decimal :High_Energy_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Graviton_Surge_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Lifetime_Average_Energy, precision: 15, scale: 2, default: 0
      t.decimal :Projected_Barriers_Applied_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Helix_Rockets_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Helix_Rockets_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Tactical_Visor_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Tactical_Visor_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Biotic_Fields_Deployed, precision: 15, scale: 2, default: 0
      t.decimal :Biotic_Field_Healing_Done, precision: 15, scale: 2, default: 0
      t.decimal :Tactical_Visor_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Helix_Rockets_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Sound_Barriers_Provided, precision: 15, scale: 2, default: 0
      t.decimal :Sound_Barriers_Provided_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Sound_Barriers_Provided_Average, precision: 15, scale: 2, default: 0
      t.decimal :Mechs_Called, precision: 15, scale: 2, default: 0
      t.decimal :Mechs_Called_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Mech_Deaths, precision: 15, scale: 2, default: 0
      t.decimal :Mechs_Called_Average, precision: 15, scale: 2, default: 0
      t.decimal :Self_Destruct_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Self_Destruct_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Self_Destruct_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Frozen, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Frozen_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Blizzard_Kills_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Blizzard_Kills, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Frozen_Average, precision: 15, scale: 2, default: 0
      t.decimal :Blizzard_Kills_Average, precision: 15, scale: 2, default: 0
      t.decimal :Nano_Boosts_Applied, precision: 15, scale: 2, default: 0
      t.decimal :Nano_Boost_Assists, precision: 15, scale: 2, default: 0
      t.decimal :Nano_Boost_Assists_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Slept, precision: 15, scale: 2, default: 0
      t.decimal :Enemy_Slept_Most_in_Game, precision: 15, scale: 2, default: 0
      t.decimal :Unscoped_Accuracy, precision: 15, scale: 2, default: 0
      t.decimal :Nano_Boosts_Applied_Average, precision: 15, scale: 2, default: 0
      t.decimal :Nano_Boost_Assists_Average, precision: 15, scale: 2, default: 0
      t.decimal :Enemies_Slept_Average, precision: 15, scale: 2, default: 0
      t.decimal :KD, precision: 15, scale: 2, default: 0
      t.decimal :KDA, precision: 15, scale: 2, default: 0
      t.timestamps null: false
    end
    add_index :heros, [:over_user_type_id, :play_type], name: "user_type_play_type"
    add_index :heros, [:name, :Time_Played, :play_type, :user_type], name: "Time_Played"
    add_index :heros, [:play_type, :name, :user_type], name: "count_local"
    add_index :heros, [:play_type, :name], name: "count_total"
    
    add_index :heros, [:name, :Win_Percentage, :play_type, :user_type], name: "Win_Percentage" #승률
    add_index :heros, [:name, :KD, :play_type, :user_type], name: "kd"
    add_index :heros, [:name, :KDA, :play_type, :user_type], name: "kda"
    add_index :heros, [:name, :Eliminations_Average, :play_type, :user_type], name: "Eliminations_Average"
    add_index :heros, [:name, :Damage_Done_Average, :play_type, :user_type], name: "Damage_Done_Average"
    add_index :heros, [:name, :Weapon_Accuracy, :play_type, :user_type], name: "Weapon_Accuracy"
    
    add_index :heros, [:name, :Final_Blows_Average, :play_type, :user_type], name: "Final_Blows_Average"
    add_index :heros, [:name, :Healing_Done_Average, :play_type, :user_type], name: "Healing_Done_Average"
    add_index :heros, [:name, :Deaths_Average, :play_type, :user_type], name: "Deaths_Average"
    add_index :heros, [:name, :Solo_Kills_Average, :play_type, :user_type], name: "Solo_Kills_Average"
    add_index :heros, [:name, :Melee_Final_Blows_Average, :play_type, :user_type], name: "Melee_Final_Blows_Average"
    add_index :heros, [:name, :Objective_Kills_Average, :play_type, :user_type], name: "Objective_Kills_Average"
    add_index :heros, [:name, :Time_Spent_on_Fire_Average, :play_type, :user_type], name: "Time_Spent_on_Fire_Average" 
    add_index :heros, [:name, :Objective_Time_Average, :play_type, :user_type], name: "Objective_Time_Average"
    #1분당 평균점수 획득
    
    add_index :heros, [:name, :Eliminations, :play_type, :user_type], name: "Eliminations"
    add_index :heros, [:name, :Final_Blows, :play_type, :user_type], name: "Final_Blows"
    add_index :heros, [:name, :Solo_Kills, :play_type, :user_type], name: "Solo_Kills"
    add_index :heros, [:name, :Objective_Kills, :play_type, :user_type], name: "Objective_Kills"
    add_index :heros, [:name, :Damage_Done, :play_type, :user_type], name: "Damage_Done"
    add_index :heros, [:name, :Multikills, :play_type, :user_type], name: "Multikills"
    add_index :heros, [:name, :Melee_Final_Blows, :play_type, :user_type], name: "Melee_Final_Blows"
    add_index :heros, [:name, :Objective_Time, :play_type, :user_type], name: "Objective_Time"
    add_index :heros, [:name, :Time_Spent_on_Fire, :play_type, :user_type], name: "Time_Spent_on_Fire"
    add_index :heros, [:name, :Environmental_Kills, :play_type, :user_type], name: "Environmental_Kills"
    add_index :heros, [:name, :Healing_Done, :play_type, :user_type], name: "Healing_Done"
    add_index :heros, [:name, :Self_Healing, :play_type, :user_type], name: "Self_Healing"
    add_index :heros, [:name, :Recon_Assists, :play_type, :user_type], name: "Recon_Assists"
    add_index :heros, [:name, :Teleporter_Pads_Destroyed, :play_type, :user_type], name: "Teleporter_Pads_Destroyed"
    add_index :heros, [:name, :Deaths, :play_type, :user_type], name: "Deaths"
    add_index :heros, [:name, :Environmental_Deaths, :play_type, :user_type], name: "Environmental_Deaths"
  end
end


      




