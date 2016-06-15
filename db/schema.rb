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

ActiveRecord::Schema.define(version: 20160614131909) do

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

  create_table "over_hero_lucios", force: :cascade do |t|
    t.integer  "over_tag_id",                      limit: 4
    t.string   "SoundBarriersProvided",            limit: 255
    t.string   "SoundBarriersProvided_MostinGame", limit: 255
    t.string   "MeleeFinalBlows_MostinGame",       limit: 255
    t.string   "SoundBarriersProvided_Average",    limit: 50
    t.string   "Eliminations",                     limit: 255
    t.string   "FinalBlows",                       limit: 255
    t.string   "SoloKills",                        limit: 255
    t.string   "ShotsFired",                       limit: 255
    t.string   "ShotsHit",                         limit: 255
    t.string   "CriticalHits",                     limit: 255
    t.string   "DamageDone",                       limit: 255
    t.string   "ObjectiveKills",                   limit: 255
    t.string   "Multikills",                       limit: 255
    t.string   "EnvironmentalKills",               limit: 255
    t.string   "MeleeFinalBlows",                  limit: 255
    t.string   "CriticalHitsperMinute",            limit: 255
    t.string   "CriticalHitAccuracy",              limit: 255
    t.string   "EliminationsperLife",              limit: 255
    t.string   "WeaponAccuracy",                   limit: 255
    t.string   "HealingDone",                      limit: 255
    t.string   "TurretsDestroyed",                 limit: 255
    t.string   "SelfHealing",                      limit: 255
    t.string   "Eliminations_MostinLife",          limit: 255
    t.string   "MostScorewithinoneLife",           limit: 255
    t.string   "DamageDone_MostinLife",            limit: 255
    t.string   "HealingDone_MostinLife",           limit: 255
    t.string   "WeaponAccuracy_BestinGame",        limit: 255
    t.string   "KillStreak_Best",                  limit: 255
    t.string   "DamageDone_MostinGame",            limit: 255
    t.string   "HealingDone_MostinGame",           limit: 255
    t.string   "Eliminations_MostinGame",          limit: 255
    t.string   "FinalBlows_MostinGame",            limit: 255
    t.string   "ObjectiveKills_MostinGame",        limit: 255
    t.string   "ObjectiveTime_MostinGame",         limit: 255
    t.string   "SoloKills_MostinGame",             limit: 255
    t.string   "CriticalHits_MostinGame",          limit: 255
    t.string   "CriticalHits_MostinLife",          limit: 255
    t.string   "SelfHealing_MostinGame",           limit: 255
    t.string   "SelfHealing_Average",              limit: 50
    t.string   "Deaths_Average",                   limit: 50
    t.string   "SoloKills_Average",                limit: 50
    t.string   "ObjectiveTime_Average",            limit: 50
    t.string   "ObjectiveKills_Average",           limit: 50
    t.string   "HealingDone_Average",              limit: 50
    t.string   "FinalBlows_Average",               limit: 50
    t.string   "Eliminations_Average",             limit: 50
    t.string   "DamageDone_Average",               limit: 50
    t.string   "Deaths",                           limit: 255
    t.string   "EnvironmentalDeaths",              limit: 255
    t.string   "Medals_Bronze",                    limit: 255
    t.string   "Medals_Silver",                    limit: 255
    t.string   "Medals_Gold",                      limit: 255
    t.string   "Medals",                           limit: 255
    t.string   "Cards",                            limit: 255
    t.string   "TimePlayed",                       limit: 20
    t.string   "GamesPlayed",                      limit: 255
    t.string   "GamesWon",                         limit: 255
    t.string   "Score",                            limit: 255
    t.string   "ObjectiveTime",                    limit: 255
    t.string   "TimeSpentonFire",                  limit: 255
    t.string   "WinPercentage",                    limit: 255
    t.string   "Multikill_Best",                   limit: 255
    t.string   "OffensiveAssists",                 limit: 255
    t.string   "OffensiveAssists_MostinGame",      limit: 255
    t.string   "DefensiveAssists",                 limit: 255
    t.string   "DefensiveAssists_MostinGame",      limit: 255
    t.string   "DefensiveAssists_Average",         limit: 50
    t.string   "OffensiveAssists_Average",         limit: 50
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "over_hero_lucios", ["Score"], name: "index_over_hero_lucios_on_Score", using: :btree

  create_table "over_hero_soldier76s", force: :cascade do |t|
    t.integer  "over_tag_id",                   limit: 4
    t.string   "HelixRocketsKills_MostinGame",  limit: 255
    t.string   "HelixRocketsKills",             limit: 255
    t.string   "TacticalVisorKills",            limit: 255
    t.string   "TacticalVisorKills_MostinGame", limit: 255
    t.string   "BioticFieldsDeployed",          limit: 255
    t.string   "BioticFieldHealingDone",        limit: 255
    t.string   "MeleeFinalBlows_MostinGame",    limit: 255
    t.string   "TacticalVisorKills_Average",    limit: 50
    t.string   "HelixRocketsKills_Average",     limit: 50
    t.string   "Eliminations",                  limit: 255
    t.string   "FinalBlows",                    limit: 255
    t.string   "SoloKills",                     limit: 255
    t.string   "ShotsFired",                    limit: 255
    t.string   "ShotsHit",                      limit: 255
    t.string   "CriticalHits",                  limit: 255
    t.string   "DamageDone",                    limit: 255
    t.string   "ObjectiveKills",                limit: 255
    t.string   "Multikills",                    limit: 255
    t.string   "MeleeFinalBlows",               limit: 255
    t.string   "CriticalHitsperMinute",         limit: 255
    t.string   "CriticalHitAccuracy",           limit: 255
    t.string   "EliminationsperLife",           limit: 255
    t.string   "WeaponAccuracy",                limit: 255
    t.string   "HealingDone",                   limit: 255
    t.string   "TeleporterPadsDestroyed",       limit: 255
    t.string   "TurretsDestroyed",              limit: 255
    t.string   "SelfHealing",                   limit: 255
    t.string   "Eliminations_MostinLife",       limit: 255
    t.string   "MostScorewithinoneLife",        limit: 255
    t.string   "DamageDone_MostinLife",         limit: 255
    t.string   "HealingDone_MostinLife",        limit: 255
    t.string   "WeaponAccuracy_BestinGame",     limit: 255
    t.string   "KillStreak_Best",               limit: 255
    t.string   "DamageDone_MostinGame",         limit: 255
    t.string   "HealingDone_MostinGame",        limit: 255
    t.string   "Eliminations_MostinGame",       limit: 255
    t.string   "FinalBlows_MostinGame",         limit: 255
    t.string   "ObjectiveKills_MostinGame",     limit: 255
    t.string   "ObjectiveTime_MostinGame",      limit: 255
    t.string   "SoloKills_MostinGame",          limit: 255
    t.string   "CriticalHits_MostinGame",       limit: 255
    t.string   "CriticalHits_MostinLife",       limit: 255
    t.string   "SelfHealing_MostinGame",        limit: 255
    t.string   "SelfHealing_Average",           limit: 50
    t.string   "Deaths_Average",                limit: 50
    t.string   "SoloKills_Average",             limit: 50
    t.string   "ObjectiveTime_Average",         limit: 50
    t.string   "ObjectiveKills_Average",        limit: 50
    t.string   "HealingDone_Average",           limit: 50
    t.string   "FinalBlows_Average",            limit: 50
    t.string   "Eliminations_Average",          limit: 50
    t.string   "DamageDone_Average",            limit: 50
    t.string   "Deaths",                        limit: 255
    t.string   "EnvironmentalDeaths",           limit: 255
    t.string   "Medals_Bronze",                 limit: 255
    t.string   "Medals_Silver",                 limit: 255
    t.string   "Medals_Gold",                   limit: 255
    t.string   "Medals",                        limit: 255
    t.string   "Cards",                         limit: 255
    t.string   "TimePlayed",                    limit: 20
    t.string   "GamesPlayed",                   limit: 255
    t.string   "GamesWon",                      limit: 255
    t.string   "Score",                         limit: 255
    t.string   "ObjectiveTime",                 limit: 255
    t.string   "TimeSpentonFire",               limit: 255
    t.string   "WinPercentage",                 limit: 10
    t.string   "Multikill_Best",                limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "over_hero_soldier76s", ["Score"], name: "index_over_hero_soldier76s_on_Score", using: :btree

  create_table "over_hero_torbjoerns", force: :cascade do |t|
    t.integer  "over_tag_id",                limit: 4
    t.string   "ArmorPacksCreated",          limit: 255
    t.string   "TorbjoernKills",             limit: 255
    t.string   "TurretKills",                limit: 255
    t.string   "TorbjoernKills_MostinGame",  limit: 255
    t.string   "MoltenCoreKills",            limit: 255
    t.string   "MoltenCoreKills_MostinGame", limit: 255
    t.string   "MeleeFinalBlows_MostinGame", limit: 255
    t.string   "TurretKills_Average",        limit: 50
    t.string   "TorbjoernKills_Average",     limit: 50
    t.string   "MoltenCoreKills_Average",    limit: 50
    t.string   "ArmorPacksCreated_Average",  limit: 50
    t.string   "Eliminations",               limit: 255
    t.string   "FinalBlows",                 limit: 255
    t.string   "SoloKills",                  limit: 255
    t.string   "ShotsFired",                 limit: 255
    t.string   "ShotsHit",                   limit: 255
    t.string   "CriticalHits",               limit: 255
    t.string   "DamageDone",                 limit: 255
    t.string   "ObjectiveKills",             limit: 255
    t.string   "MeleeFinalBlows",            limit: 255
    t.string   "CriticalHitsperMinute",      limit: 255
    t.string   "CriticalHitAccuracy",        limit: 255
    t.string   "EliminationsperLife",        limit: 255
    t.string   "WeaponAccuracy",             limit: 255
    t.string   "TurretsDestroyed",           limit: 255
    t.string   "Eliminations_MostinLife",    limit: 255
    t.string   "MostScorewithinoneLife",     limit: 255
    t.string   "DamageDone_MostinLife",      limit: 255
    t.string   "WeaponAccuracy_BestinGame",  limit: 255
    t.string   "KillStreak_Best",            limit: 255
    t.string   "DamageDone_MostinGame",      limit: 255
    t.string   "Eliminations_MostinGame",    limit: 255
    t.string   "FinalBlows_MostinGame",      limit: 255
    t.string   "ObjectiveKills_MostinGame",  limit: 255
    t.string   "ObjectiveTime_MostinGame",   limit: 255
    t.string   "SoloKills_MostinGame",       limit: 255
    t.string   "CriticalHits_MostinGame",    limit: 255
    t.string   "CriticalHits_MostinLife",    limit: 255
    t.string   "Deaths_Average",             limit: 50
    t.string   "SoloKills_Average",          limit: 50
    t.string   "ObjectiveTime_Average",      limit: 50
    t.string   "ObjectiveKills_Average",     limit: 50
    t.string   "FinalBlows_Average",         limit: 50
    t.string   "Eliminations_Average",       limit: 50
    t.string   "DamageDone_Average",         limit: 50
    t.string   "Deaths",                     limit: 255
    t.string   "Medals_Bronze",              limit: 255
    t.string   "Medals_Silver",              limit: 255
    t.string   "Medals_Gold",                limit: 255
    t.string   "Medals",                     limit: 255
    t.string   "Cards",                      limit: 255
    t.string   "TimePlayed",                 limit: 20
    t.string   "GamesPlayed",                limit: 255
    t.string   "GamesWon",                   limit: 255
    t.string   "Score",                      limit: 255
    t.string   "ObjectiveTime",              limit: 255
    t.string   "TimeSpentonFire",            limit: 255
    t.string   "WinPercentage",              limit: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "over_hero_torbjoerns", ["Score"], name: "index_over_hero_torbjoerns_on_Score", using: :btree

  create_table "over_heros", force: :cascade do |t|
    t.integer  "over_tag_id", limit: 4
    t.string   "name",        limit: 255
    t.string   "playtime",    limit: 255
    t.text     "image",       limit: 65535
    t.string   "percentage",  limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

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

  create_table "over_tags", force: :cascade do |t|
    t.string   "tag",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "over_tags", ["tag"], name: "index_over_tags_on_tag", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
