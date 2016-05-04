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

ActiveRecord::Schema.define(version: 0) do

  create_table "geoLiteCity_Blocks", id: false, force: :cascade do |t|
    t.integer "startIpNum", limit: 8, default: 0, null: false
    t.integer "endIpNum",   limit: 8, default: 0, null: false
    t.integer "locId",      limit: 8, default: 0, null: false
  end

  create_table "geoLiteCity_Location", primary_key: "locId", force: :cascade do |t|
    t.string  "country",    limit: 2,                           null: false
    t.string  "region",     limit: 50
    t.string  "city",       limit: 50
    t.string  "postalCode", limit: 10
    t.decimal "latitude",              precision: 14, scale: 4
    t.decimal "longitude",             precision: 14, scale: 4
  end

  create_table "hlstats_Actions", force: :cascade do |t|
    t.string  "game",                    limit: 32,  default: "valve", null: false
    t.string  "code",                    limit: 64,  default: "",      null: false
    t.integer "reward_player",           limit: 4,   default: 10,      null: false
    t.integer "reward_team",             limit: 4,   default: 0,       null: false
    t.string  "team",                    limit: 64,  default: "",      null: false
    t.string  "description",             limit: 128
    t.string  "for_PlayerActions",       limit: 1,   default: "0",     null: false
    t.string  "for_PlayerPlayerActions", limit: 1,   default: "0",     null: false
    t.string  "for_TeamActions",         limit: 1,   default: "0",     null: false
    t.string  "for_WorldActions",        limit: 1,   default: "0",     null: false
    t.integer "count",                   limit: 4,   default: 0,       null: false
  end

  add_index "hlstats_Actions", ["code", "game", "team"], name: "gamecode", unique: true, using: :btree
  add_index "hlstats_Actions", ["code"], name: "code", using: :btree

  create_table "hlstats_Awards", primary_key: "awardId", force: :cascade do |t|
    t.string  "awardType",      limit: 1,   default: "W",     null: false
    t.string  "game",           limit: 32,  default: "valve", null: false
    t.string  "code",           limit: 128, default: "",      null: false
    t.string  "name",           limit: 128, default: "",      null: false
    t.string  "verb",           limit: 128, default: "",      null: false
    t.integer "d_winner_id",    limit: 4
    t.integer "d_winner_count", limit: 4
    t.integer "g_winner_id",    limit: 4
    t.integer "g_winner_count", limit: 4
  end

  add_index "hlstats_Awards", ["game", "awardType", "code"], name: "code", unique: true, using: :btree

  create_table "hlstats_ClanTags", force: :cascade do |t|
    t.string "pattern",  limit: 64,                    null: false
    t.string "position", limit: 6,  default: "EITHER", null: false
  end

  add_index "hlstats_ClanTags", ["pattern"], name: "pattern", unique: true, using: :btree

  create_table "hlstats_Clans", primary_key: "clanId", force: :cascade do |t|
    t.string  "tag",       limit: 64,  default: "", null: false
    t.string  "name",      limit: 128, default: "", null: false
    t.string  "homepage",  limit: 64,  default: "", null: false
    t.string  "game",      limit: 32,  default: "", null: false
    t.integer "hidden",    limit: 1,   default: 0,  null: false
    t.string  "mapregion", limit: 128, default: "", null: false
  end

  add_index "hlstats_Clans", ["game", "tag"], name: "tag", unique: true, using: :btree
  add_index "hlstats_Clans", ["game"], name: "game", using: :btree

  create_table "hlstats_Countries", primary_key: "flag", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "hlstats_Events_Admin", force: :cascade do |t|
    t.datetime "eventTime",                                  null: false
    t.integer  "serverId",   limit: 4,   default: 0,         null: false
    t.string   "map",        limit: 64,  default: "",        null: false
    t.string   "type",       limit: 64,  default: "Unknown", null: false
    t.string   "message",    limit: 255, default: "",        null: false
    t.string   "playerName", limit: 64,  default: "",        null: false
  end

  create_table "hlstats_Events_ChangeName", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.string   "oldName",   limit: 64, default: "", null: false
    t.string   "newName",   limit: 64, default: "", null: false
  end

  add_index "hlstats_Events_ChangeName", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_ChangeRole", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.string   "role",      limit: 64, default: "", null: false
  end

  add_index "hlstats_Events_ChangeRole", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_ChangeTeam", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.string   "team",      limit: 64, default: "", null: false
  end

  add_index "hlstats_Events_ChangeTeam", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_Chat", force: :cascade do |t|
    t.datetime "eventTime",                             null: false
    t.integer  "serverId",     limit: 4,   default: 0,  null: false
    t.string   "map",          limit: 64,  default: "", null: false
    t.integer  "playerId",     limit: 4,   default: 0,  null: false
    t.integer  "message_mode", limit: 1,   default: 0,  null: false
    t.string   "message",      limit: 128, default: "", null: false
  end

  add_index "hlstats_Events_Chat", ["message"], name: "message", type: :fulltext
  add_index "hlstats_Events_Chat", ["playerId"], name: "playerId", using: :btree
  add_index "hlstats_Events_Chat", ["serverId"], name: "serverId", using: :btree

  create_table "hlstats_Events_Connects", force: :cascade do |t|
    t.datetime "eventTime",                                     null: false
    t.integer  "serverId",             limit: 4,   default: 0,  null: false
    t.string   "map",                  limit: 64,  default: "", null: false
    t.integer  "playerId",             limit: 4,   default: 0,  null: false
    t.string   "ipAddress",            limit: 32,  default: "", null: false
    t.string   "hostname",             limit: 255, default: "", null: false
    t.string   "hostgroup",            limit: 255, default: "", null: false
    t.datetime "eventTime_Disconnect"
  end

  add_index "hlstats_Events_Connects", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_Disconnects", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
  end

  create_table "hlstats_Events_Entries", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Events_Entries", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_Frags", force: :cascade do |t|
    t.datetime "eventTime",                               null: false
    t.integer  "serverId",     limit: 4,  default: 0,     null: false
    t.string   "map",          limit: 64, default: "",    null: false
    t.integer  "killerId",     limit: 4,  default: 0,     null: false
    t.integer  "victimId",     limit: 4,  default: 0,     null: false
    t.string   "weapon",       limit: 64, default: "",    null: false
    t.boolean  "headshot",                default: false, null: false
    t.string   "killerRole",   limit: 64, default: "",    null: false
    t.string   "victimRole",   limit: 64, default: "",    null: false
    t.integer  "pos_x",        limit: 3
    t.integer  "pos_y",        limit: 3
    t.integer  "pos_z",        limit: 3
    t.integer  "pos_victim_x", limit: 3
    t.integer  "pos_victim_y", limit: 3
    t.integer  "pos_victim_z", limit: 3
  end

  add_index "hlstats_Events_Frags", ["headshot"], name: "headshot", using: :btree
  add_index "hlstats_Events_Frags", ["killerId"], name: "killerId", using: :btree
  add_index "hlstats_Events_Frags", ["killerRole"], name: "killerRole", length: {"killerRole"=>8}, using: :btree
  add_index "hlstats_Events_Frags", ["map"], name: "map", length: {"map"=>5}, using: :btree
  add_index "hlstats_Events_Frags", ["serverId"], name: "serverId", using: :btree
  add_index "hlstats_Events_Frags", ["victimId"], name: "victimId", using: :btree
  add_index "hlstats_Events_Frags", ["weapon"], name: "weapon16", length: {"weapon"=>16}, using: :btree

  create_table "hlstats_Events_Latency", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.integer  "ping",      limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Events_Latency", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_PlayerActions", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.integer  "actionId",  limit: 4,  default: 0,  null: false
    t.integer  "bonus",     limit: 4,  default: 0,  null: false
    t.integer  "pos_x",     limit: 3
    t.integer  "pos_y",     limit: 3
    t.integer  "pos_z",     limit: 3
  end

  add_index "hlstats_Events_PlayerActions", ["actionId"], name: "actionId", using: :btree
  add_index "hlstats_Events_PlayerActions", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_PlayerPlayerActions", force: :cascade do |t|
    t.datetime "eventTime",                            null: false
    t.integer  "serverId",     limit: 4,  default: 0,  null: false
    t.string   "map",          limit: 64, default: "", null: false
    t.integer  "playerId",     limit: 4,  default: 0,  null: false
    t.integer  "victimId",     limit: 4,  default: 0,  null: false
    t.integer  "actionId",     limit: 4,  default: 0,  null: false
    t.integer  "bonus",        limit: 4,  default: 0,  null: false
    t.integer  "pos_x",        limit: 3
    t.integer  "pos_y",        limit: 3
    t.integer  "pos_z",        limit: 3
    t.integer  "pos_victim_x", limit: 3
    t.integer  "pos_victim_y", limit: 3
    t.integer  "pos_victim_z", limit: 3
  end

  add_index "hlstats_Events_PlayerPlayerActions", ["actionId"], name: "actionId", using: :btree
  add_index "hlstats_Events_PlayerPlayerActions", ["playerId"], name: "playerId", using: :btree
  add_index "hlstats_Events_PlayerPlayerActions", ["victimId"], name: "victimId", using: :btree

  create_table "hlstats_Events_Rcon", force: :cascade do |t|
    t.datetime "eventTime",                             null: false
    t.integer  "serverId",  limit: 4,   default: 0,     null: false
    t.string   "map",       limit: 64,  default: "",    null: false
    t.string   "type",      limit: 6,   default: "UNK", null: false
    t.string   "remoteIp",  limit: 32,  default: "",    null: false
    t.string   "password",  limit: 128, default: "",    null: false
    t.string   "command",   limit: 255, default: "",    null: false
  end

  create_table "hlstats_Events_Statsme", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.string   "weapon",    limit: 64, default: "", null: false
    t.integer  "shots",     limit: 4,  default: 0,  null: false
    t.integer  "hits",      limit: 4,  default: 0,  null: false
    t.integer  "headshots", limit: 4,  default: 0,  null: false
    t.integer  "damage",    limit: 4,  default: 0,  null: false
    t.integer  "kills",     limit: 4,  default: 0,  null: false
    t.integer  "deaths",    limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Events_Statsme", ["playerId"], name: "playerId", using: :btree
  add_index "hlstats_Events_Statsme", ["weapon"], name: "weapon", using: :btree

  create_table "hlstats_Events_Statsme2", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.string   "weapon",    limit: 64, default: "", null: false
    t.integer  "head",      limit: 4,  default: 0,  null: false
    t.integer  "chest",     limit: 4,  default: 0,  null: false
    t.integer  "stomach",   limit: 4,  default: 0,  null: false
    t.integer  "leftarm",   limit: 4,  default: 0,  null: false
    t.integer  "rightarm",  limit: 4,  default: 0,  null: false
    t.integer  "leftleg",   limit: 4,  default: 0,  null: false
    t.integer  "rightleg",  limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Events_Statsme2", ["playerId"], name: "playerId", using: :btree
  add_index "hlstats_Events_Statsme2", ["weapon"], name: "weapon", using: :btree

  create_table "hlstats_Events_StatsmeLatency", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.integer  "ping",      limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Events_StatsmeLatency", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_StatsmeTime", force: :cascade do |t|
    t.datetime "eventTime",                                            null: false
    t.integer  "serverId",  limit: 4,  default: 0,                     null: false
    t.string   "map",       limit: 64, default: "",                    null: false
    t.integer  "playerId",  limit: 4,  default: 0,                     null: false
    t.time     "time",                 default: '2000-01-01 00:00:00', null: false
  end

  add_index "hlstats_Events_StatsmeTime", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_Suicides", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.string   "weapon",    limit: 64, default: "", null: false
    t.integer  "pos_x",     limit: 3
    t.integer  "pos_y",     limit: 3
    t.integer  "pos_z",     limit: 3
  end

  add_index "hlstats_Events_Suicides", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_TeamBonuses", force: :cascade do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",  limit: 4,  default: 0,  null: false
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",  limit: 4,  default: 0,  null: false
    t.integer  "actionId",  limit: 4,  default: 0,  null: false
    t.integer  "bonus",     limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Events_TeamBonuses", ["actionId"], name: "actionId", using: :btree
  add_index "hlstats_Events_TeamBonuses", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Events_Teamkills", force: :cascade do |t|
    t.datetime "eventTime",                            null: false
    t.integer  "serverId",     limit: 4,  default: 0,  null: false
    t.string   "map",          limit: 64, default: "", null: false
    t.integer  "killerId",     limit: 4,  default: 0,  null: false
    t.integer  "victimId",     limit: 4,  default: 0,  null: false
    t.string   "weapon",       limit: 64, default: "", null: false
    t.integer  "pos_x",        limit: 3
    t.integer  "pos_y",        limit: 3
    t.integer  "pos_z",        limit: 3
    t.integer  "pos_victim_x", limit: 3
    t.integer  "pos_victim_y", limit: 3
    t.integer  "pos_victim_z", limit: 3
  end

  add_index "hlstats_Events_Teamkills", ["killerId"], name: "killerId", using: :btree

  create_table "hlstats_Games", primary_key: "code", force: :cascade do |t|
    t.string "name",     limit: 128, default: "",      null: false
    t.string "hidden",   limit: 1,   default: "0",     null: false
    t.string "realgame", limit: 32,  default: "hl2mp", null: false
  end

  create_table "hlstats_Games_Defaults", id: false, force: :cascade do |t|
    t.string "code",      limit: 32,  null: false
    t.string "parameter", limit: 50,  null: false
    t.string "value",     limit: 128, null: false
  end

  create_table "hlstats_Games_Supported", primary_key: "code", force: :cascade do |t|
    t.string "name", limit: 128, null: false
  end

  create_table "hlstats_Heatmap_Config", force: :cascade do |t|
    t.string  "map",     limit: 64,                    null: false
    t.string  "game",    limit: 32,                    null: false
    t.float   "xoffset", limit: 24,                    null: false
    t.float   "yoffset", limit: 24,                    null: false
    t.boolean "flipx",              default: false,    null: false
    t.boolean "flipy",              default: true,     null: false
    t.boolean "rotate",             default: false,    null: false
    t.integer "days",    limit: 1,  default: 30,       null: false
    t.string  "brush",   limit: 5,  default: "small",  null: false
    t.float   "scale",   limit: 24,                    null: false
    t.integer "font",    limit: 1,  default: 10,       null: false
    t.float   "thumbw",  limit: 24, default: 0.170312, null: false
    t.float   "thumbh",  limit: 24, default: 0.170312, null: false
    t.integer "cropx1",  limit: 4,  default: 0,        null: false
    t.integer "cropy1",  limit: 4,  default: 0,        null: false
    t.integer "cropx2",  limit: 4,  default: 0,        null: false
    t.integer "cropy2",  limit: 4,  default: 0,        null: false
  end

  add_index "hlstats_Heatmap_Config", ["map", "game"], name: "gamemap", unique: true, using: :btree

  create_table "hlstats_HostGroups", force: :cascade do |t|
    t.string "pattern", limit: 255, default: "", null: false
    t.string "name",    limit: 255, default: "", null: false
  end

  create_table "hlstats_Livestats", primary_key: "player_id", force: :cascade do |t|
    t.integer "server_id",    limit: 4,  default: 0,     null: false
    t.string  "cli_address",  limit: 32, default: "",    null: false
    t.string  "cli_city",     limit: 64, default: "",    null: false
    t.string  "cli_country",  limit: 64, default: "",    null: false
    t.string  "cli_flag",     limit: 16, default: "",    null: false
    t.string  "cli_state",    limit: 64, default: "",    null: false
    t.float   "cli_lat",      limit: 24
    t.float   "cli_lng",      limit: 24
    t.string  "steam_id",     limit: 64, default: "",    null: false
    t.string  "name",         limit: 64,                 null: false
    t.string  "team",         limit: 64, default: "",    null: false
    t.integer "kills",        limit: 4,  default: 0,     null: false
    t.integer "deaths",       limit: 4,  default: 0,     null: false
    t.integer "suicides",     limit: 4,  default: 0,     null: false
    t.integer "headshots",    limit: 4,  default: 0,     null: false
    t.integer "shots",        limit: 4,  default: 0,     null: false
    t.integer "hits",         limit: 4,  default: 0,     null: false
    t.boolean "is_dead",                 default: false, null: false
    t.integer "has_bomb",     limit: 4,  default: 0,     null: false
    t.integer "ping",         limit: 4,  default: 0,     null: false
    t.integer "connected",    limit: 4,  default: 0,     null: false
    t.integer "skill_change", limit: 4,  default: 0,     null: false
    t.integer "skill",        limit: 4,  default: 0,     null: false
  end

  create_table "hlstats_Maps_Counts", id: false, force: :cascade do |t|
    t.integer "rowId",     limit: 4,  null: false
    t.string  "game",      limit: 32, null: false
    t.string  "map",       limit: 64, null: false
    t.integer "kills",     limit: 4,  null: false
    t.integer "headshots", limit: 4,  null: false
  end

  add_index "hlstats_Maps_Counts", ["rowId"], name: "rowId", using: :btree

  create_table "hlstats_Mods_Defaults", id: false, force: :cascade do |t|
    t.string "code",      limit: 32,  null: false
    t.string "parameter", limit: 50,  null: false
    t.string "value",     limit: 128, null: false
  end

  create_table "hlstats_Mods_Supported", primary_key: "code", force: :cascade do |t|
    t.string "name", limit: 128, null: false
  end

  create_table "hlstats_Options", primary_key: "keyname", force: :cascade do |t|
    t.string  "value",   limit: 128, default: "", null: false
    t.integer "opttype", limit: 1,   default: 1,  null: false
  end

  add_index "hlstats_Options", ["opttype"], name: "opttype", using: :btree

  create_table "hlstats_Options_Choices", id: false, force: :cascade do |t|
    t.string  "keyname",   limit: 32,                  null: false
    t.string  "value",     limit: 128,                 null: false
    t.string  "text",      limit: 128, default: "",    null: false
    t.boolean "isDefault",             default: false, null: false
  end

  add_index "hlstats_Options_Choices", ["keyname"], name: "keyname", using: :btree

  create_table "hlstats_PlayerNames", id: false, force: :cascade do |t|
    t.integer  "playerId",        limit: 4,  default: 0,  null: false
    t.string   "name",            limit: 64, default: "", null: false
    t.datetime "lastuse",                                 null: false
    t.integer  "connection_time", limit: 4,  default: 0,  null: false
    t.integer  "numuses",         limit: 4,  default: 0,  null: false
    t.integer  "kills",           limit: 4,  default: 0,  null: false
    t.integer  "deaths",          limit: 4,  default: 0,  null: false
    t.integer  "suicides",        limit: 4,  default: 0,  null: false
    t.integer  "headshots",       limit: 4,  default: 0,  null: false
    t.integer  "shots",           limit: 4,  default: 0,  null: false
    t.integer  "hits",            limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_PlayerNames", ["name"], name: "name16", length: {"name"=>16}, using: :btree

  create_table "hlstats_PlayerUniqueIds", id: false, force: :cascade do |t|
    t.integer "playerId", limit: 4,  default: 0,  null: false
    t.string  "uniqueId", limit: 64, default: "", null: false
    t.string  "game",     limit: 32, default: "", null: false
    t.integer "merge",    limit: 4
  end

  add_index "hlstats_PlayerUniqueIds", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Players", primary_key: "playerId", force: :cascade do |t|
    t.integer "last_event",        limit: 4,   default: 0,    null: false
    t.integer "connection_time",   limit: 4,   default: 0,    null: false
    t.string  "lastName",          limit: 64,  default: "",   null: false
    t.string  "lastAddress",       limit: 32,  default: "",   null: false
    t.string  "city",              limit: 64,  default: "",   null: false
    t.string  "state",             limit: 64,  default: "",   null: false
    t.string  "country",           limit: 64,  default: "",   null: false
    t.string  "flag",              limit: 16,  default: "",   null: false
    t.float   "lat",               limit: 24
    t.float   "lng",               limit: 24
    t.integer "clan",              limit: 4,   default: 0,    null: false
    t.integer "kills",             limit: 4,   default: 0,    null: false
    t.integer "deaths",            limit: 4,   default: 0,    null: false
    t.integer "suicides",          limit: 4,   default: 0,    null: false
    t.integer "skill",             limit: 4,   default: 1000, null: false
    t.integer "shots",             limit: 4,   default: 0,    null: false
    t.integer "hits",              limit: 4,   default: 0,    null: false
    t.integer "teamkills",         limit: 4,   default: 0,    null: false
    t.string  "fullName",          limit: 128
    t.string  "email",             limit: 64
    t.string  "homepage",          limit: 64
    t.integer "icq",               limit: 4
    t.string  "game",              limit: 32,                 null: false
    t.integer "hideranking",       limit: 4,   default: 0,    null: false
    t.integer "headshots",         limit: 4,   default: 0,    null: false
    t.integer "last_skill_change", limit: 4,   default: 0,    null: false
    t.integer "displayEvents",     limit: 4,   default: 1,    null: false
    t.integer "kill_streak",       limit: 4,   default: 0,    null: false
    t.integer "death_streak",      limit: 4,   default: 0,    null: false
    t.integer "blockavatar",       limit: 4,   default: 0,    null: false
    t.integer "activity",          limit: 4,   default: 100,  null: false
    t.integer "createdate",        limit: 4,   default: 0,    null: false
  end

  add_index "hlstats_Players", ["clan", "playerId"], name: "playerclan", using: :btree
  add_index "hlstats_Players", ["game"], name: "game", using: :btree
  add_index "hlstats_Players", ["hideranking"], name: "hideranking", using: :btree
  add_index "hlstats_Players", ["kills"], name: "kills", using: :btree
  add_index "hlstats_Players", ["skill"], name: "skill", using: :btree

  create_table "hlstats_Players_Awards", id: false, force: :cascade do |t|
    t.date    "awardTime",                        null: false
    t.integer "awardId",   limit: 4,  default: 0, null: false
    t.integer "playerId",  limit: 4,  default: 0, null: false
    t.integer "count",     limit: 4,  default: 0, null: false
    t.string  "game",      limit: 32,             null: false
  end

  create_table "hlstats_Players_History", id: false, force: :cascade do |t|
    t.integer "playerId",        limit: 4,  default: 0,    null: false
    t.date    "eventTime",                                 null: false
    t.integer "connection_time", limit: 4,  default: 0,    null: false
    t.integer "kills",           limit: 4,  default: 0,    null: false
    t.integer "deaths",          limit: 4,  default: 0,    null: false
    t.integer "suicides",        limit: 4,  default: 0,    null: false
    t.integer "skill",           limit: 4,  default: 1000, null: false
    t.integer "shots",           limit: 4,  default: 0,    null: false
    t.integer "hits",            limit: 4,  default: 0,    null: false
    t.string  "game",            limit: 32, default: "",   null: false
    t.integer "headshots",       limit: 4,  default: 0,    null: false
    t.integer "teamkills",       limit: 4,  default: 0,    null: false
    t.integer "kill_streak",     limit: 4,  default: 0,    null: false
    t.integer "death_streak",    limit: 4,  default: 0,    null: false
    t.integer "skill_change",    limit: 4,  default: 0,    null: false
  end

  add_index "hlstats_Players_History", ["eventTime", "playerId", "game"], name: "eventTime", unique: true, using: :btree
  add_index "hlstats_Players_History", ["playerId"], name: "playerId", using: :btree

  create_table "hlstats_Players_Ribbons", id: false, force: :cascade do |t|
    t.integer "playerId", limit: 4,  default: 0, null: false
    t.integer "ribbonId", limit: 4,  default: 0, null: false
    t.string  "game",     limit: 32,             null: false
  end

  create_table "hlstats_Ranks", primary_key: "rankId", force: :cascade do |t|
    t.string  "image",    limit: 30,             null: false
    t.integer "minKills", limit: 4,  default: 0, null: false
    t.integer "maxKills", limit: 4,  default: 0, null: false
    t.string  "rankName", limit: 50,             null: false
    t.string  "game",     limit: 32,             null: false
  end

  add_index "hlstats_Ranks", ["game"], name: "game", length: {"game"=>8}, using: :btree
  add_index "hlstats_Ranks", ["image", "game"], name: "rankgame", unique: true, using: :btree

  create_table "hlstats_Ribbons", primary_key: "ribbonId", force: :cascade do |t|
    t.string  "awardCode",  limit: 50,             null: false
    t.integer "awardCount", limit: 4,  default: 0, null: false
    t.integer "special",    limit: 1,  default: 0, null: false
    t.string  "game",       limit: 32,             null: false
    t.string  "image",      limit: 50,             null: false
    t.string  "ribbonName", limit: 50,             null: false
  end

  add_index "hlstats_Ribbons", ["awardCode", "awardCount", "game", "special"], name: "award", unique: true, using: :btree

  create_table "hlstats_Roles", primary_key: "roleId", force: :cascade do |t|
    t.string  "game",   limit: 32, default: "valve", null: false
    t.string  "code",   limit: 64, default: "",      null: false
    t.string  "name",   limit: 64, default: "",      null: false
    t.string  "hidden", limit: 1,  default: "0",     null: false
    t.integer "picked", limit: 4,  default: 0,       null: false
    t.integer "kills",  limit: 4,  default: 0,       null: false
    t.integer "deaths", limit: 4,  default: 0,       null: false
  end

  add_index "hlstats_Roles", ["game", "code"], name: "gamecode", unique: true, using: :btree

  create_table "hlstats_Servers", primary_key: "serverId", force: :cascade do |t|
    t.string  "address",       limit: 32,  default: "",      null: false
    t.integer "port",          limit: 4,   default: 0,       null: false
    t.string  "name",          limit: 255, default: "",      null: false
    t.integer "sortorder",     limit: 1,   default: 0,       null: false
    t.string  "game",          limit: 32,  default: "valve", null: false
    t.string  "publicaddress", limit: 128, default: "",      null: false
    t.string  "statusurl",     limit: 255
    t.string  "rcon_password", limit: 128, default: "",      null: false
    t.integer "kills",         limit: 4,   default: 0,       null: false
    t.integer "players",       limit: 4,   default: 0,       null: false
    t.integer "rounds",        limit: 4,   default: 0,       null: false
    t.integer "suicides",      limit: 4,   default: 0,       null: false
    t.integer "headshots",     limit: 4,   default: 0,       null: false
    t.integer "bombs_planted", limit: 4,   default: 0,       null: false
    t.integer "bombs_defused", limit: 4,   default: 0,       null: false
    t.integer "ct_wins",       limit: 4,   default: 0,       null: false
    t.integer "ts_wins",       limit: 4,   default: 0,       null: false
    t.integer "act_players",   limit: 4,   default: 0,       null: false
    t.integer "max_players",   limit: 4,   default: 0,       null: false
    t.string  "act_map",       limit: 64,  default: "",      null: false
    t.integer "map_rounds",    limit: 4,   default: 0,       null: false
    t.integer "map_ct_wins",   limit: 4,   default: 0,       null: false
    t.integer "map_ts_wins",   limit: 4,   default: 0,       null: false
    t.integer "map_started",   limit: 4,   default: 0,       null: false
    t.integer "map_changes",   limit: 4,   default: 0,       null: false
    t.integer "ct_shots",      limit: 4,   default: 0,       null: false
    t.integer "ct_hits",       limit: 4,   default: 0,       null: false
    t.integer "ts_shots",      limit: 4,   default: 0,       null: false
    t.integer "ts_hits",       limit: 4,   default: 0,       null: false
    t.integer "map_ct_shots",  limit: 4,   default: 0,       null: false
    t.integer "map_ct_hits",   limit: 4,   default: 0,       null: false
    t.integer "map_ts_shots",  limit: 4,   default: 0,       null: false
    t.integer "map_ts_hits",   limit: 4,   default: 0,       null: false
    t.float   "lat",           limit: 24
    t.float   "lng",           limit: 24
    t.string  "city",          limit: 64,  default: "",      null: false
    t.string  "country",       limit: 64,  default: "",      null: false
    t.integer "last_event",    limit: 4,   default: 0,       null: false
  end

  add_index "hlstats_Servers", ["address", "port"], name: "addressport", unique: true, using: :btree

  create_table "hlstats_Servers_Config", id: false, force: :cascade do |t|
    t.integer "serverId",       limit: 4,   default: 0, null: false
    t.string  "parameter",      limit: 50,              null: false
    t.string  "value",          limit: 128,             null: false
    t.integer "serverConfigId", limit: 4,               null: false
  end

  add_index "hlstats_Servers_Config", ["serverConfigId"], name: "serverConfigId", using: :btree

  create_table "hlstats_Servers_Config_Default", primary_key: "parameter", force: :cascade do |t|
    t.string "value",       limit: 128,      null: false
    t.text   "description", limit: 16777215
  end

  create_table "hlstats_Servers_VoiceComm", primary_key: "serverId", force: :cascade do |t|
    t.string  "name",       limit: 128,                 null: false
    t.string  "addr",       limit: 128,                 null: false
    t.string  "password",   limit: 128
    t.string  "descr",      limit: 255
    t.integer "queryPort",  limit: 4,   default: 51234, null: false
    t.integer "UDPPort",    limit: 4,   default: 8767,  null: false
    t.integer "serverType", limit: 1,   default: 0,     null: false
  end

  add_index "hlstats_Servers_VoiceComm", ["addr", "UDPPort", "queryPort"], name: "address", unique: true, using: :btree

  create_table "hlstats_Teams", primary_key: "teamId", force: :cascade do |t|
    t.string  "game",               limit: 32, default: "valve", null: false
    t.string  "code",               limit: 64, default: "",      null: false
    t.string  "name",               limit: 64, default: "",      null: false
    t.string  "hidden",             limit: 1,  default: "0",     null: false
    t.string  "playerlist_bgcolor", limit: 7
    t.string  "playerlist_color",   limit: 7
    t.integer "playerlist_index",   limit: 1,  default: 0,       null: false
  end

  add_index "hlstats_Teams", ["game", "code"], name: "gamecode", unique: true, using: :btree

  create_table "hlstats_Trend", id: false, force: :cascade do |t|
    t.integer "timestamp", limit: 4,  default: 0,  null: false
    t.string  "game",      limit: 32, default: "", null: false
    t.integer "players",   limit: 4,  default: 0,  null: false
    t.integer "kills",     limit: 4,  default: 0,  null: false
    t.integer "headshots", limit: 4,  default: 0,  null: false
    t.integer "servers",   limit: 4,  default: 0,  null: false
    t.integer "act_slots", limit: 4,  default: 0,  null: false
    t.integer "max_slots", limit: 4,  default: 0,  null: false
  end

  add_index "hlstats_Trend", ["game"], name: "game", using: :btree
  add_index "hlstats_Trend", ["timestamp"], name: "timestamp", using: :btree

  create_table "hlstats_Users", primary_key: "username", force: :cascade do |t|
    t.string  "password", limit: 32, default: "", null: false
    t.integer "acclevel", limit: 4,  default: 0,  null: false
    t.integer "playerId", limit: 4,  default: 0,  null: false
  end

  create_table "hlstats_Weapons", primary_key: "weaponId", force: :cascade do |t|
    t.string  "game",      limit: 32,  default: "valve", null: false
    t.string  "code",      limit: 64,  default: "",      null: false
    t.string  "name",      limit: 128, default: "",      null: false
    t.float   "modifier",  limit: 24,  default: 1.0,     null: false
    t.integer "kills",     limit: 4,   default: 0,       null: false
    t.integer "headshots", limit: 4,   default: 0,       null: false
  end

  add_index "hlstats_Weapons", ["code"], name: "code", using: :btree
  add_index "hlstats_Weapons", ["game", "code"], name: "gamecode", unique: true, using: :btree
  add_index "hlstats_Weapons", ["modifier"], name: "modifier", using: :btree

  create_table "hlstats_server_load", id: false, force: :cascade do |t|
    t.integer "server_id",   limit: 4,  default: 0,   null: false
    t.integer "timestamp",   limit: 4,  default: 0,   null: false
    t.integer "act_players", limit: 1,  default: 0,   null: false
    t.integer "min_players", limit: 1,  default: 0,   null: false
    t.integer "max_players", limit: 1,  default: 0,   null: false
    t.string  "map",         limit: 64
    t.string  "uptime",      limit: 10, default: "0", null: false
    t.string  "fps",         limit: 10, default: "0", null: false
  end

  add_index "hlstats_server_load", ["server_id"], name: "server_id", using: :btree
  add_index "hlstats_server_load", ["timestamp"], name: "timestamp", using: :btree

end
