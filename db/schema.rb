# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160723042253) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hero2s", force: :cascade do |t|
    t.integer  "over_user_type_id",                       limit: 4
    t.integer  "play_type",                               limit: 4
    t.string   "name",                                    limit: 255
    t.integer  "level",                                   limit: 4
    t.integer  "competitive_rank",                        limit: 4
    t.string   "main_hero_name",                          limit: 255
    t.decimal  "Melee_Final_Blows",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Solo_Kills",                                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Kills",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Final_Blows",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Environmental_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Multikills",                                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Assists",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Pads_Destroyed",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Final_Blows_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Defensive_Assists_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Offensive_Assists_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Kills_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Time_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Multikill_Best",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Solo_Kills_Most_in_Game",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Spent_on_Fire_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Final_Blows_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Spent_on_Fire_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Solo_Kills_Average",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Time_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Kills_Average",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Final_Blows_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Deaths_Average",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Deaths",                                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Environmental_Deaths",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Cards",                                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals",                                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals_Gold",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals_Silver",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals_Bronze",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Games_Won",                                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Games_Played",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Spent_on_Fire",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Time",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Played",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Final_Blows_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Defensive_Assists",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Defensive_Assists_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Offensive_Assists",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Offensive_Assists_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Souls_Consumed",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Death_Blossom_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Souls_Consumed_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Death_Blossom_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Souls_Consumed_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Death_Blossom_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hits",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hit_Accuracy",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_per_Life",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Weapon_Accuracy",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Healing",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_Most_in_Life",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done_Most_in_Life",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done_Most_in_Life",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Kill_Streak_Best",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hits_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hits_Most_in_Life",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Healing_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Win_Percentage",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bomb_Kills",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bomb_Kills_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bombs_Attached_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bombs_Attached",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bomb_Kills_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bombs_Attached_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Resurrected",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Resurrected_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Resurrected_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Blaster_Kill",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Blaster_Kill_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Blaster_Kills_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonstrike_Kills",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonstrike_Kills_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Scatter_Arrow_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Scatter_Arrow_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Assists_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Scatter_Arrow_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonstrike_Kills_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Armor_Packs_Created",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Torbjörn_Kills",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Turret_Kills",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Torbjörn_Kills_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Molten_Core_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Molten_Core_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Turret_Kills_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Torbjörn_Kills_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Molten_Core_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Armor_Packs_Created_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Blocked",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Blocked_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Charge_Kills",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Charge_Kills_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Fire_Strike_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Fire_Strike_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Earthshatter_Kills",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Earthshatter_Kills_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Fire_Strike_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Earthshatter_Kills_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Blocked_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Charge_Kills_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Rocket_Direct_Hits",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Barrage_Kills",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Rocket_Direct_Hits_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Barrage_Kills_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Rocket_Direct_Hits_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Barrage_Kills_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Knocked_Back",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Knocked_Back_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Kills",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Kills_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Jump_Pack_Kills",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Jump_Pack_Kills_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Knocked_Back_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Kills_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Jump_Pack_Kills_Average",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Primal_Rage_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Primal_Rage_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Primal_Rage_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Venom_Mine_Kills",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Critical_Hits",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Critical_Hits_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Venom_Mine_Kills_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Accuracy_Best_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Venom_Mine_Kills_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Critical_Hits_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Accuracy",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Kills",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Kills",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Tank_Kills",                                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Kills_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Kills_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Tank_Kills_Most_in_Game",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Tank_Kills_Average",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Kills_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Kills_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Turret_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Turret_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Teleported",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Teleported_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Shields_Provided",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Shields_Provided_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Uptime",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Uptime_Best_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Shields_Provided_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Turret_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Teleported_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Uptime_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Transcendence_Healing_Best",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Transcendence_Healing",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonblade_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonblade_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Reflected",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Reflected_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonblade_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Reflected_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Hooked_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Hooked",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Hooks_Attempted",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Whole_Hog_Kills_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Whole_Hog_Kills",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Hook_Accuracy_Best_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Whole_Hog_Kills_Average",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Hooked_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Hook_Accuracy",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Deadeye_Kills",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Deadeye_Kills_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Fan_the_Hammer_Kills",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Fan_the_Hammer_Kills_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Deadeye_Kills_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Fan_the_Hammer_Kills_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Trapped_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Trapped",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "RIP_Tire_Kills_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "RIP_Tire_Kills",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Trapped_a_Minute",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "RIP_Tire_Kills_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Lifetime_Graviton_Surge_Kills",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Graviton_Surge_Kills_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "High_Energy_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "High_Energy_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Projected_Barriers_Applied",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Average_Energy_Best_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Projected_Barriers_Applied_Average",                  precision: 15, scale: 2, default: 0.0
    t.decimal  "High_Energy_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Graviton_Surge_Kills_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Lifetime_Average_Energy",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Projected_Barriers_Applied_Most_in_Game",             precision: 15, scale: 2, default: 0.0
    t.decimal  "Helix_Rockets_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Helix_Rockets_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Tactical_Visor_Kills",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Tactical_Visor_Kills_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Biotic_Fields_Deployed",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Biotic_Field_Healing_Done",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Tactical_Visor_Kills_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Helix_Rockets_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Sound_Barriers_Provided",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Sound_Barriers_Provided_Most_in_Game",                precision: 15, scale: 2, default: 0.0
    t.decimal  "Sound_Barriers_Provided_Average",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Mechs_Called",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Mechs_Called_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Mech_Deaths",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Mechs_Called_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Destruct_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Destruct_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Destruct_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Frozen",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Frozen_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Blizzard_Kills_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Blizzard_Kills",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Frozen_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Blizzard_Kills_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boosts_Applied",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boost_Assists",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boost_Assists_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Slept",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemy_Slept_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Unscoped_Accuracy",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boosts_Applied_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boost_Assists_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Slept_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "KD",                                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "KDA",                                                 precision: 15, scale: 2, default: 0.0
    t.datetime "created_at",                                                                                 null: false
    t.datetime "updated_at",                                                                                 null: false
  end

  add_index "hero2s", ["Cards"], name: "index_hero2s_on_Cards", using: :btree
  add_index "hero2s", ["Critical_Hit_Accuracy"], name: "index_hero2s_on_Critical_Hit_Accuracy", using: :btree
  add_index "hero2s", ["Critical_Hits"], name: "index_hero2s_on_Critical_Hits", using: :btree
  add_index "hero2s", ["Damage_Done"], name: "index_hero2s_on_Damage_Done", using: :btree
  add_index "hero2s", ["Damage_Done_Average"], name: "index_hero2s_on_Damage_Done_Average", using: :btree
  add_index "hero2s", ["Damage_Done_Most_in_Game"], name: "index_hero2s_on_Damage_Done_Most_in_Game", using: :btree
  add_index "hero2s", ["Death_Blossom_Kills"], name: "index_hero2s_on_Death_Blossom_Kills", using: :btree
  add_index "hero2s", ["Death_Blossom_Kills_Average"], name: "index_hero2s_on_Death_Blossom_Kills_Average", using: :btree
  add_index "hero2s", ["Death_Blossom_Kills_Most_in_Game"], name: "index_hero2s_on_Death_Blossom_Kills_Most_in_Game", using: :btree
  add_index "hero2s", ["Deaths"], name: "index_hero2s_on_Deaths", using: :btree
  add_index "hero2s", ["Deaths_Average"], name: "index_hero2s_on_Deaths_Average", using: :btree
  add_index "hero2s", ["Defensive_Assists"], name: "index_hero2s_on_Defensive_Assists", using: :btree
  add_index "hero2s", ["Defensive_Assists_Average"], name: "index_hero2s_on_Defensive_Assists_Average", using: :btree
  add_index "hero2s", ["Defensive_Assists_Most_in_Game"], name: "index_hero2s_on_Defensive_Assists_Most_in_Game", using: :btree
  add_index "hero2s", ["Eliminations"], name: "index_hero2s_on_Eliminations", using: :btree
  add_index "hero2s", ["Eliminations_Average"], name: "index_hero2s_on_Eliminations_Average", using: :btree
  add_index "hero2s", ["Eliminations_Most_in_Game"], name: "index_hero2s_on_Eliminations_Most_in_Game", using: :btree
  add_index "hero2s", ["Environmental_Deaths"], name: "index_hero2s_on_Environmental_Deaths", using: :btree
  add_index "hero2s", ["Environmental_Kills"], name: "index_hero2s_on_Environmental_Kills", using: :btree
  add_index "hero2s", ["Final_Blows"], name: "index_hero2s_on_Final_Blows", using: :btree
  add_index "hero2s", ["Final_Blows_Average"], name: "index_hero2s_on_Final_Blows_Average", using: :btree
  add_index "hero2s", ["Final_Blows_Most_in_Game"], name: "index_hero2s_on_Final_Blows_Most_in_Game", using: :btree
  add_index "hero2s", ["Games_Played"], name: "index_hero2s_on_Games_Played", using: :btree
  add_index "hero2s", ["Games_Won"], name: "index_hero2s_on_Games_Won", using: :btree
  add_index "hero2s", ["Healing_Done"], name: "index_hero2s_on_Healing_Done", using: :btree
  add_index "hero2s", ["Healing_Done_Average"], name: "index_hero2s_on_Healing_Done_Average", using: :btree
  add_index "hero2s", ["Healing_Done_Most_in_Game"], name: "index_hero2s_on_Healing_Done_Most_in_Game", using: :btree
  add_index "hero2s", ["Medals"], name: "index_hero2s_on_Medals", using: :btree
  add_index "hero2s", ["Medals_Bronze"], name: "index_hero2s_on_Medals_Bronze", using: :btree
  add_index "hero2s", ["Medals_Gold"], name: "index_hero2s_on_Medals_Gold", using: :btree
  add_index "hero2s", ["Medals_Silver"], name: "index_hero2s_on_Medals_Silver", using: :btree
  add_index "hero2s", ["Melee_Final_Blows"], name: "index_hero2s_on_Melee_Final_Blows", using: :btree
  add_index "hero2s", ["Melee_Final_Blows_Average"], name: "index_hero2s_on_Melee_Final_Blows_Average", using: :btree
  add_index "hero2s", ["Melee_Final_Blows_Most_in_Game"], name: "index_hero2s_on_Melee_Final_Blows_Most_in_Game", using: :btree
  add_index "hero2s", ["Multikill_Best"], name: "index_hero2s_on_Multikill_Best", using: :btree
  add_index "hero2s", ["Multikills"], name: "index_hero2s_on_Multikills", using: :btree
  add_index "hero2s", ["Objective_Kills"], name: "index_hero2s_on_Objective_Kills", using: :btree
  add_index "hero2s", ["Objective_Kills_Average"], name: "index_hero2s_on_Objective_Kills_Average", using: :btree
  add_index "hero2s", ["Objective_Kills_Most_in_Game"], name: "index_hero2s_on_Objective_Kills_Most_in_Game", using: :btree
  add_index "hero2s", ["Objective_Time"], name: "index_hero2s_on_Objective_Time", using: :btree
  add_index "hero2s", ["Objective_Time_Average"], name: "index_hero2s_on_Objective_Time_Average", using: :btree
  add_index "hero2s", ["Objective_Time_Most_in_Game"], name: "index_hero2s_on_Objective_Time_Most_in_Game", using: :btree
  add_index "hero2s", ["Offensive_Assists"], name: "index_hero2s_on_Offensive_Assists", using: :btree
  add_index "hero2s", ["Offensive_Assists_Average"], name: "index_hero2s_on_Offensive_Assists_Average", using: :btree
  add_index "hero2s", ["Offensive_Assists_Most_in_Game"], name: "index_hero2s_on_Offensive_Assists_Most_in_Game", using: :btree
  add_index "hero2s", ["Recon_Assists"], name: "index_hero2s_on_Recon_Assists", using: :btree
  add_index "hero2s", ["Solo_Kills"], name: "index_hero2s_on_Solo_Kills", using: :btree
  add_index "hero2s", ["Solo_Kills_Average"], name: "index_hero2s_on_Solo_Kills_Average", using: :btree
  add_index "hero2s", ["Solo_Kills_Most_in_Game"], name: "index_hero2s_on_Solo_Kills_Most_in_Game", using: :btree
  add_index "hero2s", ["Souls_Consumed"], name: "index_hero2s_on_Souls_Consumed", using: :btree
  add_index "hero2s", ["Souls_Consumed_Average"], name: "index_hero2s_on_Souls_Consumed_Average", using: :btree
  add_index "hero2s", ["Souls_Consumed_Most_in_Game"], name: "index_hero2s_on_Souls_Consumed_Most_in_Game", using: :btree
  add_index "hero2s", ["Teleporter_Pads_Destroyed"], name: "index_hero2s_on_Teleporter_Pads_Destroyed", using: :btree
  add_index "hero2s", ["Time_Played"], name: "index_hero2s_on_Time_Played", using: :btree
  add_index "hero2s", ["Time_Spent_on_Fire"], name: "index_hero2s_on_Time_Spent_on_Fire", using: :btree
  add_index "hero2s", ["Time_Spent_on_Fire_Average"], name: "index_hero2s_on_Time_Spent_on_Fire_Average", using: :btree
  add_index "hero2s", ["Time_Spent_on_Fire_Most_in_Game"], name: "index_hero2s_on_Time_Spent_on_Fire_Most_in_Game", using: :btree
  add_index "hero2s", ["competitive_rank"], name: "index_hero2s_on_competitive_rank", using: :btree
  add_index "hero2s", ["level"], name: "index_hero2s_on_level", using: :btree
  add_index "hero2s", ["main_hero_name"], name: "index_hero2s_on_main_hero_name", using: :btree
  add_index "hero2s", ["over_user_type_id", "play_type", "Time_Played"], name: "user_type_play_type_time", using: :btree
  add_index "hero2s", ["over_user_type_id", "play_type", "name"], name: "user_type_play_type_name", using: :btree
  add_index "hero2s", ["over_user_type_id", "play_type"], name: "user_type_play_type", using: :btree

  create_table "hero_groups", force: :cascade do |t|
    t.integer  "over_user_type_id",          limit: 4
    t.integer  "play_type",                  limit: 4
    t.string   "name",                       limit: 255
    t.string   "user_type",                  limit: 255
    t.decimal  "Eliminations_Average",                   precision: 15, scale: 2
    t.decimal  "Final_Blows_Average",                    precision: 15, scale: 2
    t.decimal  "Healing_Done_Average",                   precision: 15, scale: 2
    t.decimal  "Damage_Done_Average",                    precision: 15, scale: 2
    t.decimal  "Deaths_Average",                         precision: 15, scale: 2
    t.decimal  "Solo_Kills_Average",                     precision: 15, scale: 2
    t.decimal  "Melee_Final_Blows_Average",              precision: 15, scale: 2
    t.decimal  "Objective_Kills_Average",                precision: 15, scale: 2
    t.decimal  "Time_Spent_on_Fire_Average",             precision: 15, scale: 2
    t.decimal  "Objective_Time_Average",                 precision: 15, scale: 2
    t.decimal  "Eliminations",                           precision: 15, scale: 2
    t.decimal  "Final_Blows",                            precision: 15, scale: 2
    t.decimal  "Solo_Kills",                             precision: 15, scale: 2
    t.decimal  "Objective_Kills",                        precision: 15, scale: 2
    t.decimal  "Damage_Done",                            precision: 15, scale: 2
    t.decimal  "Multikills",                             precision: 15, scale: 2
    t.decimal  "Melee_Final_Blows",                      precision: 15, scale: 2
    t.decimal  "Objective_Time",                         precision: 15, scale: 2
    t.decimal  "Time_Spent_on_Fire",                     precision: 15, scale: 2
    t.decimal  "Environmental_Kills",                    precision: 15, scale: 2
    t.decimal  "Healing_Done",                           precision: 15, scale: 2
    t.decimal  "Self_Healing",                           precision: 15, scale: 2
    t.decimal  "Recon_Assists",                          precision: 15, scale: 2
    t.decimal  "Teleporter_Pads_Destroyed",              precision: 15, scale: 2
    t.decimal  "Deaths",                                 precision: 15, scale: 2
    t.decimal  "Environmental_Deaths",                   precision: 15, scale: 2
    t.decimal  "Time_Played",                            precision: 15, scale: 2
    t.decimal  "Weapon_Accuracy",                        precision: 15, scale: 2
    t.decimal  "Win_Percentage",                         precision: 15, scale: 2
    t.decimal  "Games_Won",                              precision: 15, scale: 2
    t.decimal  "Games_Played",                           precision: 15, scale: 2
    t.decimal  "Medals_Gold",                            precision: 15, scale: 2
    t.decimal  "KDA",                                    precision: 15, scale: 2
    t.decimal  "KD",                                     precision: 15, scale: 2
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "hero_groups", ["name", "Damage_Done", "play_type", "user_type"], name: "Damage_Done", using: :btree
  add_index "hero_groups", ["name", "Damage_Done_Average", "play_type", "user_type"], name: "Damage_Done_Average", using: :btree
  add_index "hero_groups", ["name", "Deaths", "play_type", "user_type"], name: "Deaths", using: :btree
  add_index "hero_groups", ["name", "Deaths_Average", "play_type", "user_type"], name: "Deaths_Average", using: :btree
  add_index "hero_groups", ["name", "Eliminations", "play_type", "user_type"], name: "Eliminations", using: :btree
  add_index "hero_groups", ["name", "Eliminations_Average", "play_type", "user_type"], name: "Eliminations_Average", using: :btree
  add_index "hero_groups", ["name", "Environmental_Deaths", "play_type", "user_type"], name: "Environmental_Deaths", using: :btree
  add_index "hero_groups", ["name", "Environmental_Kills", "play_type", "user_type"], name: "Environmental_Kills", using: :btree
  add_index "hero_groups", ["name", "Final_Blows", "play_type", "user_type"], name: "Final_Blows", using: :btree
  add_index "hero_groups", ["name", "Final_Blows_Average", "play_type", "user_type"], name: "Final_Blows_Average", using: :btree
  add_index "hero_groups", ["name", "Healing_Done", "play_type", "user_type"], name: "Healing_Done", using: :btree
  add_index "hero_groups", ["name", "Healing_Done_Average", "play_type", "user_type"], name: "Healing_Done_Average", using: :btree
  add_index "hero_groups", ["name", "KD", "play_type", "user_type"], name: "kd", using: :btree
  add_index "hero_groups", ["name", "KDA", "play_type", "user_type"], name: "kda", using: :btree
  add_index "hero_groups", ["name", "Melee_Final_Blows", "play_type", "user_type"], name: "Melee_Final_Blows", using: :btree
  add_index "hero_groups", ["name", "Melee_Final_Blows_Average", "play_type", "user_type"], name: "Melee_Final_Blows_Average", using: :btree
  add_index "hero_groups", ["name", "Multikills", "play_type", "user_type"], name: "Multikills", using: :btree
  add_index "hero_groups", ["name", "Objective_Kills", "play_type", "user_type"], name: "Objective_Kills", using: :btree
  add_index "hero_groups", ["name", "Objective_Kills_Average", "play_type", "user_type"], name: "Objective_Kills_Average", using: :btree
  add_index "hero_groups", ["name", "Objective_Time", "play_type", "user_type"], name: "Objective_Time", using: :btree
  add_index "hero_groups", ["name", "Objective_Time_Average", "play_type", "user_type"], name: "Objective_Time_Average", using: :btree
  add_index "hero_groups", ["name", "Recon_Assists", "play_type", "user_type"], name: "Recon_Assists", using: :btree
  add_index "hero_groups", ["name", "Self_Healing", "play_type", "user_type"], name: "Self_Healing", using: :btree
  add_index "hero_groups", ["name", "Solo_Kills", "play_type", "user_type"], name: "Solo_Kills", using: :btree
  add_index "hero_groups", ["name", "Solo_Kills_Average", "play_type", "user_type"], name: "Solo_Kills_Average", using: :btree
  add_index "hero_groups", ["name", "Teleporter_Pads_Destroyed", "play_type", "user_type"], name: "Teleporter_Pads_Destroyed", using: :btree
  add_index "hero_groups", ["name", "Time_Played", "play_type", "user_type"], name: "Time_Played", using: :btree
  add_index "hero_groups", ["name", "Time_Spent_on_Fire", "play_type", "user_type"], name: "Time_Spent_on_Fire", using: :btree
  add_index "hero_groups", ["name", "Time_Spent_on_Fire_Average", "play_type", "user_type"], name: "Time_Spent_on_Fire_Average", using: :btree
  add_index "hero_groups", ["name", "Weapon_Accuracy", "play_type", "user_type"], name: "Weapon_Accuracy", using: :btree
  add_index "hero_groups", ["name", "Win_Percentage", "play_type", "user_type"], name: "Win_Percentage", using: :btree
  add_index "hero_groups", ["over_user_type_id", "play_type"], name: "user_type_play_type", using: :btree
  add_index "hero_groups", ["play_type", "name", "user_type"], name: "count_local", using: :btree
  add_index "hero_groups", ["play_type", "name"], name: "count_total", using: :btree

  create_table "heros", force: :cascade do |t|
    t.integer  "over_user_type_id",                       limit: 4
    t.integer  "play_type",                               limit: 4
    t.string   "name",                                    limit: 255
    t.integer  "level",                                   limit: 4
    t.integer  "competitive_rank",                        limit: 4
    t.string   "main_hero_name",                          limit: 255
    t.string   "user_type",                               limit: 255
    t.decimal  "Melee_Final_Blows",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Solo_Kills",                                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Kills",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Final_Blows",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Environmental_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Multikills",                                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Assists",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Pads_Destroyed",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Final_Blows_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Defensive_Assists_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Offensive_Assists_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Kills_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Time_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Multikill_Best",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Solo_Kills_Most_in_Game",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Spent_on_Fire_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Final_Blows_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Spent_on_Fire_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Solo_Kills_Average",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Time_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Kills_Average",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Final_Blows_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Deaths_Average",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Deaths",                                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Environmental_Deaths",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Cards",                                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals",                                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals_Gold",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals_Silver",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Medals_Bronze",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Games_Won",                                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Games_Played",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Spent_on_Fire",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Objective_Time",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Time_Played",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Final_Blows_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Defensive_Assists",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Defensive_Assists_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Offensive_Assists",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Offensive_Assists_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Souls_Consumed",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Death_Blossom_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Souls_Consumed_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Death_Blossom_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Souls_Consumed_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Death_Blossom_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hits",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hit_Accuracy",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_per_Life",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Weapon_Accuracy",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Healing",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Eliminations_Most_in_Life",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Done_Most_in_Life",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Healing_Done_Most_in_Life",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Kill_Streak_Best",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hits_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Critical_Hits_Most_in_Life",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Healing_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Win_Percentage",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bomb_Kills",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bomb_Kills_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bombs_Attached_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bombs_Attached",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bomb_Kills_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Pulse_Bombs_Attached_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Resurrected",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Resurrected_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Resurrected_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Blaster_Kill",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Blaster_Kill_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Blaster_Kills_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonstrike_Kills",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonstrike_Kills_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Scatter_Arrow_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Scatter_Arrow_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Assists_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Assists_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Scatter_Arrow_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonstrike_Kills_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Armor_Packs_Created",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Torbjörn_Kills",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Turret_Kills",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Torbjörn_Kills_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Molten_Core_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Molten_Core_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Turret_Kills_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Torbjörn_Kills_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Molten_Core_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Armor_Packs_Created_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Blocked",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Blocked_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Charge_Kills",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Charge_Kills_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Fire_Strike_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Fire_Strike_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Earthshatter_Kills",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Earthshatter_Kills_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Fire_Strike_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Earthshatter_Kills_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Blocked_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Charge_Kills_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Rocket_Direct_Hits",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Barrage_Kills",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Rocket_Direct_Hits_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Barrage_Kills_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Rocket_Direct_Hits_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Barrage_Kills_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Knocked_Back",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Knocked_Back_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Kills",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Kills_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Jump_Pack_Kills",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Jump_Pack_Kills_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Knocked_Back_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Melee_Kills_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Jump_Pack_Kills_Average",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Primal_Rage_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Primal_Rage_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Primal_Rage_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Venom_Mine_Kills",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Critical_Hits",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Critical_Hits_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Venom_Mine_Kills_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Accuracy_Best_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Venom_Mine_Kills_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Critical_Hits_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Scoped_Accuracy",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Kills",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Kills",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Tank_Kills",                                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Kills_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Kills_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Tank_Kills_Most_in_Game",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Tank_Kills_Average",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Kills_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Recon_Kills_Average",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Turret_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Turret_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Teleported",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Teleported_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Shields_Provided",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Shields_Provided_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Uptime",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Uptime_Best_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Shields_Provided_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Sentry_Turret_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Players_Teleported_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Teleporter_Uptime_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Transcendence_Healing_Best",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Transcendence_Healing",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonblade_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonblade_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Reflected",                                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Reflected_Most_in_Game",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Dragonblade_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Damage_Reflected_Average",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Hooked_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Hooked",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Hooks_Attempted",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Whole_Hog_Kills_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Whole_Hog_Kills",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Hook_Accuracy_Best_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Whole_Hog_Kills_Average",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Hooked_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Hook_Accuracy",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Deadeye_Kills",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Deadeye_Kills_Most_in_Game",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Fan_the_Hammer_Kills",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Fan_the_Hammer_Kills_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Deadeye_Kills_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "Fan_the_Hammer_Kills_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Trapped_Most_in_Game",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Trapped",                                     precision: 15, scale: 2, default: 0.0
    t.decimal  "RIP_Tire_Kills_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "RIP_Tire_Kills",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Trapped_a_Minute",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "RIP_Tire_Kills_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Lifetime_Graviton_Surge_Kills",                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Graviton_Surge_Kills_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "High_Energy_Kills_Most_in_Game",                      precision: 15, scale: 2, default: 0.0
    t.decimal  "High_Energy_Kills",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Projected_Barriers_Applied",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Average_Energy_Best_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Projected_Barriers_Applied_Average",                  precision: 15, scale: 2, default: 0.0
    t.decimal  "High_Energy_Kills_Average",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Graviton_Surge_Kills_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Lifetime_Average_Energy",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Projected_Barriers_Applied_Most_in_Game",             precision: 15, scale: 2, default: 0.0
    t.decimal  "Helix_Rockets_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Helix_Rockets_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Tactical_Visor_Kills",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Tactical_Visor_Kills_Most_in_Game",                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Biotic_Fields_Deployed",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Biotic_Field_Healing_Done",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Tactical_Visor_Kills_Average",                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Helix_Rockets_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Sound_Barriers_Provided",                             precision: 15, scale: 2, default: 0.0
    t.decimal  "Sound_Barriers_Provided_Most_in_Game",                precision: 15, scale: 2, default: 0.0
    t.decimal  "Sound_Barriers_Provided_Average",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Mechs_Called",                                        precision: 15, scale: 2, default: 0.0
    t.decimal  "Mechs_Called_Most_in_Game",                           precision: 15, scale: 2, default: 0.0
    t.decimal  "Mech_Deaths",                                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Mechs_Called_Average",                                precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Destruct_Kills",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Destruct_Kills_Most_in_Game",                    precision: 15, scale: 2, default: 0.0
    t.decimal  "Self_Destruct_Kills_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Frozen",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Frozen_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Blizzard_Kills_Most_in_Game",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Blizzard_Kills",                                      precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Frozen_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Blizzard_Kills_Average",                              precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boosts_Applied",                                 precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boost_Assists",                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boost_Assists_Most_in_Game",                     precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Slept",                                       precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemy_Slept_Most_in_Game",                            precision: 15, scale: 2, default: 0.0
    t.decimal  "Unscoped_Accuracy",                                   precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boosts_Applied_Average",                         precision: 15, scale: 2, default: 0.0
    t.decimal  "Nano_Boost_Assists_Average",                          precision: 15, scale: 2, default: 0.0
    t.decimal  "Enemies_Slept_Average",                               precision: 15, scale: 2, default: 0.0
    t.decimal  "KD",                                                  precision: 15, scale: 2, default: 0.0
    t.decimal  "KDA",                                                 precision: 15, scale: 2, default: 0.0
    t.datetime "created_at",                                                                                 null: false
    t.datetime "updated_at",                                                                                 null: false
  end

  add_index "heros", ["name", "Damage_Done", "play_type", "user_type"], name: "Damage_Done", using: :btree
  add_index "heros", ["name", "Damage_Done_Average", "play_type", "user_type"], name: "Damage_Done_Average", using: :btree
  add_index "heros", ["name", "Deaths", "play_type", "user_type"], name: "Deaths", using: :btree
  add_index "heros", ["name", "Deaths_Average", "play_type", "user_type"], name: "Deaths_Average", using: :btree
  add_index "heros", ["name", "Eliminations", "play_type", "user_type"], name: "Eliminations", using: :btree
  add_index "heros", ["name", "Eliminations_Average", "play_type", "user_type"], name: "Eliminations_Average", using: :btree
  add_index "heros", ["name", "Environmental_Deaths", "play_type", "user_type"], name: "Environmental_Deaths", using: :btree
  add_index "heros", ["name", "Environmental_Kills", "play_type", "user_type"], name: "Environmental_Kills", using: :btree
  add_index "heros", ["name", "Final_Blows", "play_type", "user_type"], name: "Final_Blows", using: :btree
  add_index "heros", ["name", "Final_Blows_Average", "play_type", "user_type"], name: "Final_Blows_Average", using: :btree
  add_index "heros", ["name", "Healing_Done", "play_type", "user_type"], name: "Healing_Done", using: :btree
  add_index "heros", ["name", "Healing_Done_Average", "play_type", "user_type"], name: "Healing_Done_Average", using: :btree
  add_index "heros", ["name", "KD", "play_type", "user_type"], name: "kd", using: :btree
  add_index "heros", ["name", "KDA", "play_type", "user_type"], name: "kda", using: :btree
  add_index "heros", ["name", "Melee_Final_Blows", "play_type", "user_type"], name: "Melee_Final_Blows", using: :btree
  add_index "heros", ["name", "Melee_Final_Blows_Average", "play_type", "user_type"], name: "Melee_Final_Blows_Average", using: :btree
  add_index "heros", ["name", "Multikills", "play_type", "user_type"], name: "Multikills", using: :btree
  add_index "heros", ["name", "Objective_Kills", "play_type", "user_type"], name: "Objective_Kills", using: :btree
  add_index "heros", ["name", "Objective_Kills_Average", "play_type", "user_type"], name: "Objective_Kills_Average", using: :btree
  add_index "heros", ["name", "Objective_Time", "play_type", "user_type"], name: "Objective_Time", using: :btree
  add_index "heros", ["name", "Objective_Time_Average", "play_type", "user_type"], name: "Objective_Time_Average", using: :btree
  add_index "heros", ["name", "Recon_Assists", "play_type", "user_type"], name: "Recon_Assists", using: :btree
  add_index "heros", ["name", "Self_Healing", "play_type", "user_type"], name: "Self_Healing", using: :btree
  add_index "heros", ["name", "Solo_Kills", "play_type", "user_type"], name: "Solo_Kills", using: :btree
  add_index "heros", ["name", "Solo_Kills_Average", "play_type", "user_type"], name: "Solo_Kills_Average", using: :btree
  add_index "heros", ["name", "Teleporter_Pads_Destroyed", "play_type", "user_type"], name: "Teleporter_Pads_Destroyed", using: :btree
  add_index "heros", ["name", "Time_Played", "play_type", "user_type"], name: "Time_Played", using: :btree
  add_index "heros", ["name", "Time_Spent_on_Fire", "play_type", "user_type"], name: "Time_Spent_on_Fire", using: :btree
  add_index "heros", ["name", "Time_Spent_on_Fire_Average", "play_type", "user_type"], name: "Time_Spent_on_Fire_Average", using: :btree
  add_index "heros", ["name", "Weapon_Accuracy", "play_type", "user_type"], name: "Weapon_Accuracy", using: :btree
  add_index "heros", ["name", "Win_Percentage", "play_type", "user_type"], name: "Win_Percentage", using: :btree
  add_index "heros", ["over_user_type_id", "play_type"], name: "user_type_play_type", using: :btree
  add_index "heros", ["play_type", "name", "user_type"], name: "count_local", using: :btree
  add_index "heros", ["play_type", "name"], name: "count_total", using: :btree

  create_table "keywords", force: :cascade do |t|
    t.string   "keyword",    limit: 255
    t.string   "keyword2",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "keywords", ["keyword"], name: "index_keywords_on_keyword", using: :btree

  create_table "over_daily_data", force: :cascade do |t|
    t.integer  "over_user_type_id", limit: 4
    t.string   "hero_name",         limit: 255
    t.integer  "play_type",         limit: 4
    t.integer  "games_won",         limit: 4
    t.integer  "games_lost",        limit: 4
    t.integer  "games_played",      limit: 4
    t.float    "games_won_per",     limit: 24
    t.integer  "time_played",       limit: 4
    t.integer  "eliminations",      limit: 4
    t.integer  "deaths",            limit: 4
    t.integer  "final_blows",       limit: 4
    t.float    "kd",                limit: 24
    t.float    "kda",               limit: 24
    t.float    "healing_done_avr",  limit: 24
    t.float    "damage_done_avr",   limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "over_daily_data", ["over_user_type_id", "hero_name", "play_type", "created_at"], name: "type_id_name_type_date", using: :btree

  create_table "over_data_histories", force: :cascade do |t|
    t.integer  "over_tag_id", limit: 4
    t.string   "kill_death",  limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "over_data_histories", ["over_tag_id"], name: "index_over_data_histories_on_over_tag_id", using: :btree

  create_table "over_role_calculations", force: :cascade do |t|
    t.string   "hero_name",        limit: 255
    t.integer  "play_type",        limit: 4
    t.integer  "games_won",        limit: 4
    t.integer  "games_lost",       limit: 4
    t.integer  "games_played",     limit: 4
    t.float    "games_won_per",    limit: 24
    t.integer  "time_played",      limit: 4
    t.integer  "eliminations",     limit: 4
    t.integer  "deaths",           limit: 4
    t.integer  "final_blows",      limit: 4
    t.float    "kd",               limit: 24
    t.float    "kda",              limit: 24
    t.float    "healing_done_avr", limit: 24
    t.float    "damage_done_avr",  limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "over_role_calculations", ["hero_name", "play_type", "created_at"], name: "name_type_date", using: :btree

  create_table "over_tag_tmps", force: :cascade do |t|
    t.string   "tag",        limit: 255
    t.string   "tag_head",   limit: 255
    t.string   "tag_tail",   limit: 255
    t.string   "region",     limit: 255
    t.string   "platform",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "over_tags", force: :cascade do |t|
    t.string   "tag",             limit: 255
    t.string   "tag_name",        limit: 255
    t.string   "site_url",        limit: 255
    t.datetime "data_updated_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "over_tags", ["tag"], name: "index_over_tags_on_tag", using: :btree
  add_index "over_tags", ["tag_name"], name: "index_over_tags_on_tag_name", using: :btree

  create_table "over_user_types", force: :cascade do |t|
    t.integer  "over_tag_id", limit: 4
    t.string   "user_type",   limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "over_user_types", ["over_tag_id", "user_type"], name: "index_over_user_types_on_over_tag_id_and_user_type", using: :btree
  add_index "over_user_types", ["over_tag_id"], name: "index_over_user_types_on_over_tag_id", using: :btree

  create_table "update_logs", force: :cascade do |t|
    t.integer  "over_tag_id", limit: 4
    t.string   "table_name",  limit: 255
    t.string   "sub_name",    limit: 255
    t.string   "log_type",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "update_logs", ["over_tag_id", "log_type"], name: "index_update_logs_on_over_tag_id_and_log_type", using: :btree
  add_index "update_logs", ["over_tag_id", "table_name", "log_type", "sub_name"], name: "update_logs_sub_name", using: :btree
  add_index "update_logs", ["over_tag_id", "table_name", "log_type"], name: "index_update_logs_on_over_tag_id_and_table_name_and_log_type", using: :btree
  add_index "update_logs", ["over_tag_id", "table_name"], name: "index_update_logs_on_over_tag_id_and_table_name", using: :btree
  add_index "update_logs", ["over_tag_id"], name: "index_update_logs_on_over_tag_id", using: :btree

end
