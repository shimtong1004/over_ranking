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

end
