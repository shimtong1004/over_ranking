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

ActiveRecord::Schema.define(version: 20160713025023) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "over_achievements", force: :cascade do |t|
    t.integer  "over_tag_id",          limit: 4
    t.string   "finishedAchievements", limit: 255
    t.string   "name",                 limit: 255
    t.string   "finished",             limit: 255
    t.text     "image",                limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "over_all_heros", force: :cascade do |t|
    t.integer  "over_tag_id",                 limit: 4
    t.string   "MeleeFinalBlows",             limit: 255
    t.string   "SoloKills",                   limit: 255
    t.string   "ObjectiveKills",              limit: 255
    t.string   "FinalBlows",                  limit: 255
    t.string   "DamageDone",                  limit: 255
    t.string   "Eliminations",                limit: 255
    t.string   "EnvironmentalKills",          limit: 255
    t.string   "Multikills",                  limit: 255
    t.string   "HealingDone",                 limit: 255
    t.string   "ReconAssists",                limit: 255
    t.string   "TeleporterPadsDestroyed",     limit: 255
    t.string   "Eliminations_MostinGame",     limit: 255
    t.string   "FinalBlows_MostinGame",       limit: 255
    t.string   "DamageDone_MostinGame",       limit: 255
    t.string   "HealingDone_MostinGame",      limit: 255
    t.string   "DefensiveAssists_MostinGame", limit: 255
    t.string   "OffensiveAssists_MostinGame", limit: 255
    t.string   "ObjectiveKills_MostinGame",   limit: 255
    t.string   "ObjectiveTime_MostinGame",    limit: 255
    t.string   "Multikill_Best",              limit: 255
    t.string   "SoloKills_MostinGame",        limit: 255
    t.string   "TimeSpentonFire_MostinGame",  limit: 255
    t.string   "MeleeFinalBlows_Average",     limit: 255
    t.string   "FinalBlows_Average",          limit: 255
    t.string   "TimeSpentonFire_Average",     limit: 255
    t.string   "SoloKills_Average",           limit: 255
    t.string   "ObjectiveTime_Average",       limit: 255
    t.string   "ObjectiveKills_Average",      limit: 255
    t.string   "HealingDone_Average",         limit: 255
    t.string   "Deaths_Average",              limit: 255
    t.string   "DamageDone_Average",          limit: 255
    t.string   "Eliminations_Average",        limit: 255
    t.string   "Deaths",                      limit: 255
    t.string   "EnvironmentalDeaths",         limit: 255
    t.string   "Cards",                       limit: 255
    t.string   "Medals",                      limit: 255
    t.string   "Medals_Gold",                 limit: 255
    t.string   "Medals_Silver",               limit: 255
    t.string   "Medals_Bronze",               limit: 255
    t.string   "GamesWon",                    limit: 255
    t.string   "GamesPlayed",                 limit: 255
    t.string   "TimeSpentonFire",             limit: 255
    t.string   "ObjectiveTime",               limit: 255
    t.string   "Score",                       limit: 255
    t.string   "TimePlayed",                  limit: 255
    t.string   "MeleeFinalBlows_MostinGame",  limit: 255
    t.string   "DefensiveAssists",            limit: 255
    t.string   "DefensiveAssists_Average",    limit: 255
    t.string   "OffensiveAssists",            limit: 255
    t.string   "OffensiveAssists_Average",    limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "over_daily_data", force: :cascade do |t|
    t.integer  "over_tag_id",      limit: 4
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

  add_index "over_daily_data", ["over_tag_id", "hero_name", "play_type", "created_at"], name: "tag_id_name_type_date", using: :btree

  create_table "over_data_histories", force: :cascade do |t|
    t.integer  "over_tag_id", limit: 4
    t.string   "kill_death",  limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "over_data_histories", ["over_tag_id"], name: "index_over_data_histories_on_over_tag_id", using: :btree

  create_table "over_hero_avatars", force: :cascade do |t|
    t.string   "hero_name",  limit: 255
    t.string   "hero_type",  limit: 255
    t.string   "avatar",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "over_hero_avatars", ["hero_name"], name: "index_over_hero_avatars_on_hero_name", using: :btree
  add_index "over_hero_avatars", ["hero_type"], name: "index_over_hero_avatars_on_hero_type", using: :btree

  create_table "over_hero_bastions", force: :cascade do |t|
    t.integer  "over_tag_id",            limit: 4
    t.string   "name",                   limit: 255
    t.string   "ReconKills",             limit: 255
    t.string   "SentryKills",            limit: 255
    t.string   "TankKills",              limit: 255
    t.string   "SentryKills_MostinGame", limit: 255
    t.string   "ReconKills_MostinGame",  limit: 255
    t.string   "TankKills_MostinGame",   limit: 255
    t.string   "TankKills_Average",      limit: 255
    t.string   "SentryKills_Average",    limit: 255
    t.string   "ReconKills_Average",     limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "over_hero_bastions", ["over_tag_id"], name: "index_over_hero_bastions_on_over_tag_id", using: :btree

  create_table "over_hero_commons", force: :cascade do |t|
    t.integer  "over_hero_id",                limit: 4
    t.integer  "over_hero_common_table_id",   limit: 4
    t.string   "over_hero_common_table_type", limit: 255
    t.string   "Cards",                       limit: 255
    t.string   "DamageDone",                  limit: 255
    t.string   "DamageDone_Average",          limit: 10
    t.string   "DamageDone_MostinGame",       limit: 255
    t.string   "Deaths",                      limit: 255
    t.string   "Deaths_Average",              limit: 10
    t.string   "DefensiveAssists_MostinGame", limit: 255
    t.string   "Eliminations",                limit: 255
    t.string   "Eliminations_Average",        limit: 10
    t.string   "Eliminations_MostinGame",     limit: 255
    t.string   "EnvironmentalDeaths",         limit: 255
    t.string   "EnvironmentalKills",          limit: 255
    t.string   "FinalBlows",                  limit: 255
    t.string   "FinalBlows_Average",          limit: 10
    t.string   "FinalBlows_MostinGame",       limit: 255
    t.string   "GamesPlayed",                 limit: 255
    t.string   "GamesWon",                    limit: 255
    t.string   "HealingDone",                 limit: 255
    t.string   "HealingDone_Average",         limit: 10
    t.string   "HealingDone_MostinGame",      limit: 255
    t.string   "Medals",                      limit: 255
    t.string   "Medals_Bronze",               limit: 255
    t.string   "Medals_Gold",                 limit: 255
    t.string   "Medals_Silver",               limit: 255
    t.string   "MeleeFinalBlows",             limit: 255
    t.string   "MeleeFinalBlows_MostinGame",  limit: 255
    t.string   "Multikill_Best",              limit: 255
    t.string   "Multikills",                  limit: 255
    t.string   "ObjectiveKills",              limit: 255
    t.string   "ObjectiveKills_Average",      limit: 10
    t.string   "ObjectiveKills_MostinGame",   limit: 255
    t.string   "ObjectiveTime",               limit: 255
    t.string   "ObjectiveTime_Average",       limit: 10
    t.string   "ObjectiveTime_MostinGame",    limit: 255
    t.string   "OffensiveAssists_MostinGame", limit: 255
    t.string   "Score",                       limit: 255
    t.string   "SoloKills",                   limit: 255
    t.string   "SoloKills_Average",           limit: 10
    t.string   "SoloKills_MostinGame",        limit: 255
    t.string   "TimePlayed",                  limit: 255
    t.string   "TimeSpentonFire",             limit: 255
    t.string   "TeleporterPadsDestroyed",     limit: 255
    t.string   "ShotsFired",                  limit: 255
    t.string   "ShotsHit",                    limit: 255
    t.string   "CriticalHits",                limit: 255
    t.string   "CriticalHitsperMinute",       limit: 255
    t.string   "CriticalHitAccuracy",         limit: 255
    t.string   "EliminationsperLife",         limit: 255
    t.string   "WeaponAccuracy",              limit: 255
    t.string   "TurretsDestroyed",            limit: 255
    t.string   "SelfHealing",                 limit: 255
    t.string   "Eliminations_MostinLife",     limit: 255
    t.string   "MostScorewithinoneLife",      limit: 255
    t.string   "DamageDone_MostinLife",       limit: 255
    t.string   "HealingDone_MostinLife",      limit: 255
    t.string   "WeaponAccuracy_BestinGame",   limit: 255
    t.string   "KillStreak_Best",             limit: 255
    t.string   "CriticalHits_MostinGame",     limit: 255
    t.string   "CriticalHits_MostinLife",     limit: 255
    t.string   "SelfHealing_MostinGame",      limit: 255
    t.string   "SelfHealing_Average",         limit: 10
    t.string   "WinPercentage",               limit: 255
    t.string   "DamageBlocked",               limit: 255
    t.string   "DamageBlocked_MostinGame",    limit: 255
    t.string   "DamageBlocked_Average",       limit: 10
    t.string   "OffensiveAssists",            limit: 255
    t.string   "DefensiveAssists",            limit: 255
    t.string   "DefensiveAssists_Average",    limit: 10
    t.string   "OffensiveAssists_Average",    limit: 10
    t.string   "ReconAssists_MostinGame",     limit: 255
    t.string   "ReconAssists_Average",        limit: 10
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "over_hero_commons", ["over_hero_common_table_id", "over_hero_common_table_type"], name: "hero_common_index", using: :btree
  add_index "over_hero_commons", ["over_hero_id"], name: "index_over_hero_commons_on_over_hero_id", using: :btree

  create_table "over_hero_dvas", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "name",                          limit: 255
    t.string   "MechsCalled",                   limit: 255
    t.string   "MechsCalled_MostinGame",        limit: 255
    t.string   "MechDeaths",                    limit: 255
    t.string   "MechsCalled_Average",           limit: 255
    t.string   "Self_DestructKills",            limit: 255
    t.string   "Self_DestructKills_MostinGame", limit: 255
    t.string   "Self_DestructKills_Average",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_dvas", ["over_tag_id"], name: "index_over_hero_dvas_on_over_tag_id", using: :btree

  create_table "over_hero_genjis", force: :cascade do |t|
    t.integer  "over_tag_id",                 limit: 4
    t.string   "name",                        limit: 255
    t.string   "DragonbladeKills",            limit: 255
    t.string   "DragonbladeKills_MostinGame", limit: 255
    t.string   "DamageReflected",             limit: 255
    t.string   "DamageReflected_MostinGame",  limit: 255
    t.string   "Dragonblades",                limit: 255
    t.string   "DragonbladeKills_Average",    limit: 255
    t.string   "DamageReflected_Average",     limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "over_hero_genjis", ["over_tag_id"], name: "index_over_hero_genjis_on_over_tag_id", using: :btree

  create_table "over_hero_hanzos", force: :cascade do |t|
    t.integer  "over_tag_id",                  limit: 4
    t.string   "name",                         limit: 255
    t.string   "DragonstrikeKills",            limit: 255
    t.string   "DragonstrikeKills_MostinGame", limit: 255
    t.string   "ScatterArrowKills",            limit: 255
    t.string   "ScatterArrowKills_MostinGame", limit: 255
    t.string   "ScatterArrowKills_Average",    limit: 255
    t.string   "DragonstrikeKills_Average",    limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "over_hero_hanzos", ["over_tag_id"], name: "index_over_hero_hanzos_on_over_tag_id", using: :btree

  create_table "over_hero_junkrats", force: :cascade do |t|
    t.integer  "over_tag_id",               limit: 4
    t.string   "name",                      limit: 255
    t.string   "EnemiesTrapped_MostinGame", limit: 255
    t.string   "EnemiesTrapped",            limit: 255
    t.string   "RIP_TireKills_MostinGame",  limit: 255
    t.string   "RIP_TireKills",             limit: 255
    t.string   "EnemiesTrappedaMinute",     limit: 255
    t.string   "RIP_TireKills_Average",     limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "over_hero_junkrats", ["over_tag_id"], name: "index_over_hero_junkrats_on_over_tag_id", using: :btree

  create_table "over_hero_lucios", force: :cascade do |t|
    t.integer  "over_tag_id",                      limit: 4
    t.string   "name",                             limit: 255
    t.string   "SoundBarriersProvided",            limit: 255
    t.string   "SoundBarriersProvided_MostinGame", limit: 255
    t.string   "SoundBarriersProvided_Average",    limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "over_hero_lucios", ["over_tag_id"], name: "index_over_hero_lucios_on_over_tag_id", using: :btree

  create_table "over_hero_masters", force: :cascade do |t|
    t.integer  "over_user_type_id", limit: 4
    t.integer  "play_type",         limit: 4
    t.string   "hero_name",         limit: 255
    t.string   "keyword",           limit: 255
    t.string   "value",             limit: 255
    t.string   "view_group",        limit: 255
    t.string   "view_group_detail", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "over_hero_masters", ["play_type", "over_user_type_id", "hero_name", "keyword"], name: "over_hero_id_name_keyword", using: :btree
  add_index "over_hero_masters", ["play_type", "over_user_type_id", "hero_name", "view_group", "keyword"], name: "over_hero_id_name_grop_key", using: :btree
  add_index "over_hero_masters", ["play_type", "over_user_type_id", "hero_name", "view_group"], name: "over_hero_id_name_grop", using: :btree

  create_table "over_hero_mc_crees", force: :cascade do |t|
    t.integer  "over_tag_id",                  limit: 4
    t.string   "name",                         limit: 255
    t.string   "DeadeyeKills",                 limit: 255
    t.string   "DeadeyeKills_MostinGame",      limit: 255
    t.string   "FantheHammerKills",            limit: 255
    t.string   "FantheHammerKills_Average",    limit: 255
    t.string   "DeadeyeKills_Average",         limit: 255
    t.string   "FantheHammerKills_MostinGame", limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "over_hero_mc_crees", ["over_tag_id"], name: "index_over_hero_mc_crees_on_over_tag_id", using: :btree

  create_table "over_hero_meis", force: :cascade do |t|
    t.integer  "over_tag_id",              limit: 4
    t.string   "name",                     limit: 255
    t.string   "EnemiesFrozen",            limit: 255
    t.string   "EnemiesFrozen_MostinGame", limit: 255
    t.string   "BlizzardKills_MostinGame", limit: 255
    t.string   "BlizzardKills",            limit: 255
    t.string   "EnemiesFrozen_Average",    limit: 255
    t.string   "BlizzardKills_Average",    limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "over_hero_meis", ["over_tag_id"], name: "index_over_hero_meis_on_over_tag_id", using: :btree

  create_table "over_hero_mercies", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "name",                          limit: 255
    t.string   "PlayersResurrected",            limit: 255
    t.string   "PlayersResurrected_MostinGame", limit: 255
    t.string   "PlayersSaved",                  limit: 255
    t.string   "MostPlayersSavedinaGame",       limit: 255
    t.string   "PlayersSaved_Average",          limit: 255
    t.string   "PlayersResurrected_Average",    limit: 255
    t.string   "BlasterKills",                  limit: 255
    t.string   "BlasterKills_MostinGame",       limit: 255
    t.string   "BlasterKills_Average",          limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_mercies", ["over_tag_id"], name: "index_over_hero_mercies_on_over_tag_id", using: :btree

  create_table "over_hero_pharahs", force: :cascade do |t|
    t.integer  "over_tag_id",                 limit: 4
    t.string   "name",                        limit: 255
    t.string   "RocketDirectHits",            limit: 255
    t.string   "BarrageKills",                limit: 255
    t.string   "RocketDirectHits_MostinGame", limit: 255
    t.string   "BarrageKills_MostinGame",     limit: 255
    t.string   "RocketDirectHits_Average",    limit: 255
    t.string   "BarrageKills_Average",        limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "over_hero_pharahs", ["over_tag_id"], name: "index_over_hero_pharahs_on_over_tag_id", using: :btree

  create_table "over_hero_reapers", force: :cascade do |t|
    t.integer  "over_tag_id",                  limit: 4
    t.string   "name",                         limit: 255
    t.string   "SoulsConsumed",                limit: 255
    t.string   "DeathBlossomKills",            limit: 255
    t.string   "SoulsConsumed_MostinGame",     limit: 255
    t.string   "DeathBlossomKills_MostinGame", limit: 255
    t.string   "SoulsConsumed_Average",        limit: 255
    t.string   "DeathBlossomKills_Average",    limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "over_hero_reapers", ["over_tag_id"], name: "index_over_hero_reapers_on_over_tag_id", using: :btree

  create_table "over_hero_reinhardts", force: :cascade do |t|
    t.integer  "over_tag_id",                  limit: 4
    t.string   "name",                         limit: 255
    t.string   "ChargeKills",                  limit: 255
    t.string   "ChargeKills_MostinGame",       limit: 255
    t.string   "FireStrikeKills",              limit: 255
    t.string   "FireStrikeKills_MostinGame",   limit: 255
    t.string   "EarthshatterKills",            limit: 255
    t.string   "EarthshatterKills_MostinGame", limit: 255
    t.string   "FireStrikeKills_Average",      limit: 255
    t.string   "EarthshatterKills_Average",    limit: 255
    t.string   "ChargeKills_Average",          limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "over_hero_reinhardts", ["over_tag_id"], name: "index_over_hero_reinhardts_on_over_tag_id", using: :btree

  create_table "over_hero_roadhogs", force: :cascade do |t|
    t.integer  "over_tag_id",              limit: 4
    t.string   "name",                     limit: 255
    t.string   "EnemiesHooked_MostinGame", limit: 255
    t.string   "EnemiesHooked",            limit: 255
    t.string   "HooksAttempted",           limit: 255
    t.string   "WholeHogKills_MostinGame", limit: 255
    t.string   "WholeHogKills",            limit: 255
    t.string   "HookAccuracy_BestinGame",  limit: 255
    t.string   "WholeHogKills_Average",    limit: 255
    t.string   "EnemiesHooked_Average",    limit: 255
    t.string   "HookAccuracy",             limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "over_hero_roadhogs", ["over_tag_id"], name: "index_over_hero_roadhogs_on_over_tag_id", using: :btree

  create_table "over_hero_soldier76s", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "name",                          limit: 255
    t.string   "HelixRocketsKills_MostinGame",  limit: 255
    t.string   "HelixRocketsKills",             limit: 255
    t.string   "TacticalVisorKills",            limit: 255
    t.string   "TacticalVisorKills_MostinGame", limit: 255
    t.string   "BioticFieldsDeployed",          limit: 255
    t.string   "BioticFieldHealingDone",        limit: 255
    t.string   "TacticalVisorKills_Average",    limit: 255
    t.string   "HelixRocketsKills_Average",     limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_soldier76s", ["over_tag_id"], name: "index_over_hero_soldier76s_on_over_tag_id", using: :btree

  create_table "over_hero_symmetras", force: :cascade do |t|
    t.integer  "over_tag_id",                  limit: 4
    t.string   "name",                         limit: 255
    t.string   "SentryTurretKills",            limit: 255
    t.string   "SentryTurretKills_MostinGame", limit: 255
    t.string   "PlayersTeleported",            limit: 255
    t.string   "PlayersTeleported_MostinGame", limit: 255
    t.string   "ShieldsProvided",              limit: 255
    t.string   "ShieldsProvided_MostinGame",   limit: 255
    t.string   "TeleporterUptime",             limit: 255
    t.string   "TeleporterUptime_BestinGame",  limit: 255
    t.string   "ShieldsProvided_Average",      limit: 255
    t.string   "SentryTurretKills_Average",    limit: 255
    t.string   "PlayersTeleported_Average",    limit: 255
    t.string   "TeleporterUptime_Average",     limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "over_hero_symmetras", ["over_tag_id"], name: "index_over_hero_symmetras_on_over_tag_id", using: :btree

  create_table "over_hero_torbjoerns", force: :cascade do |t|
    t.integer  "over_tag_id",                limit: 4
    t.string   "name",                       limit: 255
    t.string   "ArmorPacksCreated",          limit: 255
    t.string   "TorbjoernKills",             limit: 255
    t.string   "TurretKills",                limit: 255
    t.string   "TorbjoernKills_MostinGame",  limit: 255
    t.string   "MoltenCoreKills",            limit: 255
    t.string   "MoltenCoreKills_MostinGame", limit: 255
    t.string   "TurretKills_Average",        limit: 255
    t.string   "TorbjoernKills_Average",     limit: 255
    t.string   "MoltenCoreKills_Average",    limit: 255
    t.string   "ArmorPacksCreated_Average",  limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "over_hero_torbjoerns", ["over_tag_id"], name: "index_over_hero_torbjoerns_on_over_tag_id", using: :btree

  create_table "over_hero_tracers", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "name",                          limit: 255
    t.string   "PulseBombKills",                limit: 255
    t.string   "PulseBombKills_MostinGame",     limit: 255
    t.string   "PulseBombsAttached_MostinGame", limit: 255
    t.string   "PulseBombsAttached",            limit: 255
    t.string   "PulseBombKills_Average",        limit: 255
    t.string   "PulseBombsAttached_Average",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_tracers", ["over_tag_id"], name: "index_over_hero_tracers_on_over_tag_id", using: :btree

  create_table "over_hero_widowmakers", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "name",                          limit: 255
    t.string   "VenomMineKills",                limit: 255
    t.string   "ScopedHits",                    limit: 255
    t.string   "ScopedShots",                   limit: 255
    t.string   "ScopedCriticalHits",            limit: 255
    t.string   "ScopedCriticalHits_MostinGame", limit: 255
    t.string   "VenomMineKills_MostinGame",     limit: 255
    t.string   "ScopedAccuracy_BestinGame",     limit: 255
    t.string   "VenomMineKills_Average",        limit: 255
    t.string   "ScopedCriticalHits_Average",    limit: 255
    t.string   "ScopedAccuracy",                limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_widowmakers", ["over_tag_id"], name: "index_over_hero_widowmakers_on_over_tag_id", using: :btree

  create_table "over_hero_winstons", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "name",                          limit: 255
    t.string   "PlayersKnockedBack",            limit: 255
    t.string   "PlayersKnockedBack_MostinGame", limit: 255
    t.string   "MeleeKills",                    limit: 255
    t.string   "MeleeKills_MostinGame",         limit: 255
    t.string   "JumpPackKills",                 limit: 255
    t.string   "JumpPackKills_MostinGame",      limit: 255
    t.string   "PlayersKnockedBack_Average",    limit: 255
    t.string   "MeleeKills_Average",            limit: 255
    t.string   "JumpPackKills_Average",         limit: 255
    t.string   "PrimalRageKills",               limit: 255
    t.string   "PrimalRageKills_MostinGame",    limit: 255
    t.string   "PrimalRageKills_Average",       limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_winstons", ["over_tag_id"], name: "index_over_hero_winstons_on_over_tag_id", using: :btree

  create_table "over_hero_zaryas", force: :cascade do |t|
    t.integer  "over_tag_id",                         limit: 4
    t.string   "name",                                limit: 255
    t.string   "LifetimeGravitonSurgeKills",          limit: 255
    t.string   "GravitonSurgeKills_MostinGame",       limit: 255
    t.string   "HighEnergyKills_MostinGame",          limit: 255
    t.string   "HighEnergyKills",                     limit: 255
    t.string   "LifetimeEnergyAccumulation",          limit: 255
    t.string   "EnergyMaximum",                       limit: 255
    t.string   "ProjectedBarriersApplied",            limit: 255
    t.string   "AverageEnergy_BestinGame",            limit: 255
    t.string   "ProjectedBarriersApplied_Average",    limit: 255
    t.string   "HighEnergyKills_Average",             limit: 255
    t.string   "GravitonSurgeKills_Average",          limit: 255
    t.string   "LifetimeAverageEnergy",               limit: 255
    t.string   "ProjectedBarriersApplied_MostinGame", limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "over_hero_zaryas", ["over_tag_id"], name: "index_over_hero_zaryas_on_over_tag_id", using: :btree

  create_table "over_hero_zenyatta", force: :cascade do |t|
    t.integer  "over_tag_id",               limit: 4
    t.string   "name",                      limit: 255
    t.string   "TranscendenceHealing_Best", limit: 255
    t.string   "TranscendenceHealing",      limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "over_hero_zenyatta", ["over_tag_id"], name: "index_over_hero_zenyatta_on_over_tag_id", using: :btree

  create_table "over_heros", force: :cascade do |t|
    t.integer  "over_tag_id",  limit: 4
    t.string   "name",         limit: 255
    t.string   "playtime",     limit: 255
    t.integer  "playtime_min", limit: 4
    t.text     "image",        limit: 65535
    t.string   "percentage",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "over_heros", ["over_tag_id", "name"], name: "index_over_heros_on_over_tag_id_and_name", using: :btree

  create_table "over_platforms", force: :cascade do |t|
    t.integer  "over_tag_id", limit: 4
    t.string   "platform",    limit: 255
    t.string   "region",      limit: 255
    t.boolean  "hasAccount"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "over_profiles", force: :cascade do |t|
    t.integer  "over_tag_id",    limit: 4
    t.string   "username",       limit: 255
    t.string   "level",          limit: 255
    t.string   "playtime",       limit: 255
    t.text     "avatar",         limit: 65535
    t.string   "win_percentage", limit: 255
    t.string   "wins",           limit: 255
    t.string   "lost",           limit: 255
    t.string   "played",         limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

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
    t.string   "tag",            limit: 255
    t.string   "tag_name",       limit: 255
    t.string   "site_url",       limit: 255
    t.boolean  "is_create_data",             default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "over_tags", ["is_create_data"], name: "index_over_tags_on_is_create_data", using: :btree
  add_index "over_tags", ["tag"], name: "index_over_tags_on_tag", using: :btree
  add_index "over_tags", ["tag_name"], name: "index_over_tags_on_tag_name", using: :btree

  create_table "over_user_scores", force: :cascade do |t|
    t.integer  "over_user_type_id", limit: 4
    t.string   "user_type",         limit: 255
    t.integer  "play_type",         limit: 4
    t.string   "keyword",           limit: 255
    t.decimal  "score",                         precision: 11, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "over_user_scores", ["over_user_type_id", "play_type", "keyword"], name: "id_type_key", using: :btree
  add_index "over_user_scores", ["over_user_type_id", "play_type"], name: "id_play_type", using: :btree
  add_index "over_user_scores", ["over_user_type_id"], name: "index_over_user_scores_on_over_user_type_id", using: :btree
  add_index "over_user_scores", ["play_type", "user_type", "keyword", "score"], name: "play_key_score", using: :btree

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

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
