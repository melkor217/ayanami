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

ActiveRecord::Schema.define(version: 20160521183149) do

  create_table "geoLiteCity_Blocks", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "startIpNum", default: 0, null: false, unsigned: true
    t.bigint "endIpNum",   default: 0, null: false, unsigned: true
    t.bigint "locId",      default: 0, null: false, unsigned: true
  end

  create_table "geoLiteCity_Location", primary_key: "locId", id: :bigint, default: 0, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "country",    limit: 2,                           null: false
    t.string  "region",     limit: 50
    t.string  "city",       limit: 50
    t.string  "postalCode", limit: 10
    t.decimal "latitude",              precision: 14, scale: 4
    t.decimal "longitude",             precision: 14, scale: 4
  end

  create_table "hlstats_Actions", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "game",                    limit: 32,  default: "valve", null: false
    t.string  "code",                    limit: 64,  default: "",      null: false
    t.integer "reward_player",                       default: 10,      null: false
    t.integer "reward_team",                         default: 0,       null: false
    t.string  "team",                    limit: 64,  default: "",      null: false
    t.string  "description",             limit: 128
    t.string  "for_PlayerActions",       limit: 1,   default: "0",     null: false
    t.string  "for_PlayerPlayerActions", limit: 1,   default: "0",     null: false
    t.string  "for_TeamActions",         limit: 1,   default: "0",     null: false
    t.string  "for_WorldActions",        limit: 1,   default: "0",     null: false
    t.integer "count",                               default: 0,       null: false, unsigned: true
    t.index ["code", "game", "team"], name: "gamecode", unique: true, using: :btree
    t.index ["code"], name: "code", using: :btree
  end

  create_table "hlstats_Awards", primary_key: "awardId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "awardType",      limit: 1,   default: "W",     null: false
    t.string  "game",           limit: 32,  default: "valve", null: false
    t.string  "code",           limit: 128, default: "",      null: false
    t.string  "name",           limit: 128, default: "",      null: false
    t.string  "verb",           limit: 128, default: "",      null: false
    t.integer "d_winner_id",                                               unsigned: true
    t.integer "d_winner_count",                                            unsigned: true
    t.integer "g_winner_id",                                               unsigned: true
    t.integer "g_winner_count",                                            unsigned: true
    t.index ["game", "awardType", "code"], name: "code", unique: true, using: :btree
  end

  create_table "hlstats_ClanTags", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "pattern",  limit: 64,                    null: false
    t.string "position", limit: 6,  default: "EITHER", null: false
    t.index ["pattern"], name: "pattern", unique: true, using: :btree
  end

  create_table "hlstats_Clans", primary_key: "clanId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "tag",       limit: 64,  default: "", null: false
    t.string  "name",      limit: 128, default: "", null: false
    t.string  "homepage",  limit: 64,  default: "", null: false
    t.string  "game",      limit: 32,  default: "", null: false
    t.integer "hidden",    limit: 1,   default: 0,  null: false, unsigned: true
    t.string  "mapregion", limit: 128, default: "", null: false
    t.index ["game", "tag"], name: "tag", unique: true, using: :btree
    t.index ["game"], name: "game", using: :btree
  end

  create_table "hlstats_Countries", primary_key: "flag", id: :string, limit: 16, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "hlstats_Events_Admin", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                                 null: false
    t.integer  "serverId",              default: 0,         null: false, unsigned: true
    t.string   "map",        limit: 64, default: "",        null: false
    t.string   "type",       limit: 64, default: "Unknown", null: false
    t.string   "message",               default: "",        null: false
    t.string   "playerName", limit: 64, default: "",        null: false
  end

  create_table "hlstats_Events_ChangeName", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.string   "oldName",   limit: 64, default: "", null: false
    t.string   "newName",   limit: 64, default: "", null: false
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_ChangeRole", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.string   "role",      limit: 64, default: "", null: false
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_ChangeTeam", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.string   "team",      limit: 64, default: "", null: false
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_Chat", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                             null: false
    t.integer  "serverId",                 default: 0,  null: false, unsigned: true
    t.string   "map",          limit: 64,  default: "", null: false
    t.integer  "playerId",                 default: 0,  null: false, unsigned: true
    t.integer  "message_mode", limit: 1,   default: 0,  null: false
    t.string   "message",      limit: 128, default: "", null: false
    t.index ["message"], name: "message", type: :fulltext
    t.index ["playerId"], name: "playerId", using: :btree
    t.index ["serverId"], name: "serverId", using: :btree
  end

  create_table "hlstats_Events_Connects", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                                    null: false
    t.integer  "serverId",                        default: 0,  null: false, unsigned: true
    t.string   "map",                  limit: 64, default: "", null: false
    t.integer  "playerId",                        default: 0,  null: false, unsigned: true
    t.string   "ipAddress",            limit: 32, default: "", null: false
    t.string   "hostname",                        default: "", null: false
    t.string   "hostgroup",                       default: "", null: false
    t.datetime "eventTime_Disconnect"
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_Disconnects", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
  end

  create_table "hlstats_Events_Entries", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_Frags", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                               null: false
    t.integer  "serverId",                default: 0,     null: false, unsigned: true
    t.string   "map",          limit: 64, default: "",    null: false
    t.integer  "killerId",                default: 0,     null: false, unsigned: true
    t.integer  "victimId",                default: 0,     null: false, unsigned: true
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
    t.index ["headshot"], name: "headshot", using: :btree
    t.index ["killerId"], name: "killerId", using: :btree
    t.index ["killerRole"], name: "killerRole", length: {"killerRole"=>8}, using: :btree
    t.index ["map"], name: "map", length: {"map"=>5}, using: :btree
    t.index ["serverId"], name: "serverId", using: :btree
    t.index ["victimId"], name: "victimId", using: :btree
    t.index ["weapon"], name: "weapon16", length: {"weapon"=>16}, using: :btree
  end

  create_table "hlstats_Events_Latency", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.integer  "ping",                 default: 0,  null: false, unsigned: true
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_PlayerActions", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.integer  "actionId",             default: 0,  null: false, unsigned: true
    t.integer  "bonus",                default: 0,  null: false
    t.integer  "pos_x",     limit: 3
    t.integer  "pos_y",     limit: 3
    t.integer  "pos_z",     limit: 3
    t.index ["actionId"], name: "actionId", using: :btree
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_PlayerPlayerActions", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                            null: false
    t.integer  "serverId",                default: 0,  null: false, unsigned: true
    t.string   "map",          limit: 64, default: "", null: false
    t.integer  "playerId",                default: 0,  null: false, unsigned: true
    t.integer  "victimId",                default: 0,  null: false, unsigned: true
    t.integer  "actionId",                default: 0,  null: false, unsigned: true
    t.integer  "bonus",                   default: 0,  null: false
    t.integer  "pos_x",        limit: 3
    t.integer  "pos_y",        limit: 3
    t.integer  "pos_z",        limit: 3
    t.integer  "pos_victim_x", limit: 3
    t.integer  "pos_victim_y", limit: 3
    t.integer  "pos_victim_z", limit: 3
    t.index ["actionId"], name: "actionId", using: :btree
    t.index ["playerId"], name: "playerId", using: :btree
    t.index ["victimId"], name: "victimId", using: :btree
  end

  create_table "hlstats_Events_Rcon", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                             null: false
    t.integer  "serverId",              default: 0,     null: false, unsigned: true
    t.string   "map",       limit: 64,  default: "",    null: false
    t.string   "type",      limit: 6,   default: "UNK", null: false
    t.string   "remoteIp",  limit: 32,  default: "",    null: false
    t.string   "password",  limit: 128, default: "",    null: false
    t.string   "command",               default: "",    null: false
  end

  create_table "hlstats_Events_Statsme", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.string   "weapon",    limit: 64, default: "", null: false
    t.integer  "shots",                default: 0,  null: false, unsigned: true
    t.integer  "hits",                 default: 0,  null: false, unsigned: true
    t.integer  "headshots",            default: 0,  null: false, unsigned: true
    t.integer  "damage",               default: 0,  null: false, unsigned: true
    t.integer  "kills",                default: 0,  null: false, unsigned: true
    t.integer  "deaths",               default: 0,  null: false, unsigned: true
    t.index ["playerId"], name: "playerId", using: :btree
    t.index ["weapon"], name: "weapon", using: :btree
  end

  create_table "hlstats_Events_Statsme2", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.string   "weapon",    limit: 64, default: "", null: false
    t.integer  "head",                 default: 0,  null: false, unsigned: true
    t.integer  "chest",                default: 0,  null: false, unsigned: true
    t.integer  "stomach",              default: 0,  null: false, unsigned: true
    t.integer  "leftarm",              default: 0,  null: false, unsigned: true
    t.integer  "rightarm",             default: 0,  null: false, unsigned: true
    t.integer  "leftleg",              default: 0,  null: false, unsigned: true
    t.integer  "rightleg",             default: 0,  null: false, unsigned: true
    t.index ["playerId"], name: "playerId", using: :btree
    t.index ["weapon"], name: "weapon", using: :btree
  end

  create_table "hlstats_Events_StatsmeLatency", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.integer  "ping",                 default: 0,  null: false, unsigned: true
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_StatsmeTime", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                                            null: false
    t.integer  "serverId",             default: 0,                     null: false, unsigned: true
    t.string   "map",       limit: 64, default: "",                    null: false
    t.integer  "playerId",             default: 0,                     null: false, unsigned: true
    t.time     "time",                 default: '2000-01-01 00:00:00', null: false
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_Suicides", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.string   "weapon",    limit: 64, default: "", null: false
    t.integer  "pos_x",     limit: 3
    t.integer  "pos_y",     limit: 3
    t.integer  "pos_z",     limit: 3
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_TeamBonuses", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                         null: false
    t.integer  "serverId",             default: 0,  null: false, unsigned: true
    t.string   "map",       limit: 64, default: "", null: false
    t.integer  "playerId",             default: 0,  null: false, unsigned: true
    t.integer  "actionId",             default: 0,  null: false, unsigned: true
    t.integer  "bonus",                default: 0,  null: false
    t.index ["actionId"], name: "actionId", using: :btree
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Events_Teamkills", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.datetime "eventTime",                            null: false
    t.integer  "serverId",                default: 0,  null: false, unsigned: true
    t.string   "map",          limit: 64, default: "", null: false
    t.integer  "killerId",                default: 0,  null: false, unsigned: true
    t.integer  "victimId",                default: 0,  null: false, unsigned: true
    t.string   "weapon",       limit: 64, default: "", null: false
    t.integer  "pos_x",        limit: 3
    t.integer  "pos_y",        limit: 3
    t.integer  "pos_z",        limit: 3
    t.integer  "pos_victim_x", limit: 3
    t.integer  "pos_victim_y", limit: 3
    t.integer  "pos_victim_z", limit: 3
    t.index ["killerId"], name: "killerId", using: :btree
  end

  create_table "hlstats_Games", primary_key: "code", id: :string, limit: 32, default: "", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name",     limit: 128, default: "",      null: false
    t.string "hidden",   limit: 1,   default: "0",     null: false
    t.string "realgame", limit: 32,  default: "hl2mp", null: false
  end

  create_table "hlstats_Games_Defaults", primary_key: ["code", "parameter"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "code",      limit: 32,  null: false
    t.string "parameter", limit: 50,  null: false
    t.string "value",     limit: 128, null: false
  end

  create_table "hlstats_Games_Supported", primary_key: "code", id: :string, limit: 32, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 128, null: false
  end

  create_table "hlstats_Heatmap_Config", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
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
    t.integer "cropx1",             default: 0,        null: false
    t.integer "cropy1",             default: 0,        null: false
    t.integer "cropx2",             default: 0,        null: false
    t.integer "cropy2",             default: 0,        null: false
    t.index ["map", "game"], name: "gamemap", unique: true, using: :btree
  end

  create_table "hlstats_HostGroups", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "pattern", default: "", null: false
    t.string "name",    default: "", null: false
  end

  create_table "hlstats_Livestats", primary_key: "player_id", id: :integer, default: 0, force: :cascade, options: "ENGINE=MEMORY DEFAULT CHARSET=utf8" do |t|
    t.integer "server_id",               default: 0,     null: false
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
    t.integer "kills",                   default: 0,     null: false
    t.integer "deaths",                  default: 0,     null: false
    t.integer "suicides",                default: 0,     null: false
    t.integer "headshots",               default: 0,     null: false
    t.integer "shots",                   default: 0,     null: false
    t.integer "hits",                    default: 0,     null: false
    t.boolean "is_dead",                 default: false, null: false
    t.integer "has_bomb",                default: 0,     null: false
    t.integer "ping",                    default: 0,     null: false
    t.integer "connected",               default: 0,     null: false
    t.integer "skill_change",            default: 0,     null: false
    t.integer "skill",                   default: 0,     null: false
  end

  create_table "hlstats_Maps_Counts", primary_key: ["game", "map"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "rowId",                null: false
    t.string  "game",      limit: 32, null: false
    t.string  "map",       limit: 64, null: false
    t.integer "kills",                null: false
    t.integer "headshots",            null: false
    t.index ["rowId"], name: "rowId", using: :btree
  end

  create_table "hlstats_Mods_Defaults", primary_key: ["code", "parameter"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "code",      limit: 32,  null: false
    t.string "parameter", limit: 50,  null: false
    t.string "value",     limit: 128, null: false
  end

  create_table "hlstats_Mods_Supported", primary_key: "code", id: :string, limit: 32, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 128, null: false
  end

  create_table "hlstats_Options", primary_key: "keyname", id: :string, limit: 32, default: "", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "value",   limit: 128, default: "", null: false
    t.integer "opttype", limit: 1,   default: 1,  null: false
    t.index ["opttype"], name: "opttype", using: :btree
  end

  create_table "hlstats_Options_Choices", primary_key: ["keyname", "value"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "keyname",   limit: 32,                  null: false
    t.string  "value",     limit: 128,                 null: false
    t.string  "text",      limit: 128, default: "",    null: false
    t.boolean "isDefault",             default: false, null: false
    t.index ["keyname"], name: "keyname", using: :btree
  end

  create_table "hlstats_PlayerNames", primary_key: ["playerId", "name"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer  "playerId",                   default: 0,  null: false, unsigned: true
    t.string   "name",            limit: 64, default: "", null: false
    t.datetime "lastuse",                                 null: false
    t.integer  "connection_time",            default: 0,  null: false, unsigned: true
    t.integer  "numuses",                    default: 0,  null: false, unsigned: true
    t.integer  "kills",                      default: 0,  null: false, unsigned: true
    t.integer  "deaths",                     default: 0,  null: false, unsigned: true
    t.integer  "suicides",                   default: 0,  null: false, unsigned: true
    t.integer  "headshots",                  default: 0,  null: false, unsigned: true
    t.integer  "shots",                      default: 0,  null: false, unsigned: true
    t.integer  "hits",                       default: 0,  null: false, unsigned: true
    t.index ["name"], name: "name16", length: {"name"=>16}, using: :btree
  end

  create_table "hlstats_PlayerUniqueIds", primary_key: ["uniqueId", "game"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "playerId",            default: 0,  null: false, unsigned: true
    t.string  "uniqueId", limit: 64, default: "", null: false
    t.string  "game",     limit: 32, default: "", null: false
    t.integer "merge",                                         unsigned: true
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Players", primary_key: "playerId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "last_event",                    default: 0,    null: false
    t.integer "connection_time",               default: 0,    null: false, unsigned: true
    t.string  "lastName",          limit: 64,  default: "",   null: false
    t.string  "lastAddress",       limit: 32,  default: "",   null: false
    t.string  "city",              limit: 64,  default: "",   null: false
    t.string  "state",             limit: 64,  default: "",   null: false
    t.string  "country",           limit: 64,  default: "",   null: false
    t.string  "flag",              limit: 16,  default: "",   null: false
    t.float   "lat",               limit: 24
    t.float   "lng",               limit: 24
    t.integer "clan",                          default: 0,    null: false, unsigned: true
    t.integer "kills",                         default: 0,    null: false, unsigned: true
    t.integer "deaths",                        default: 0,    null: false, unsigned: true
    t.integer "suicides",                      default: 0,    null: false, unsigned: true
    t.integer "skill",                         default: 1000, null: false, unsigned: true
    t.integer "shots",                         default: 0,    null: false, unsigned: true
    t.integer "hits",                          default: 0,    null: false, unsigned: true
    t.integer "teamkills",                     default: 0,    null: false, unsigned: true
    t.string  "fullName",          limit: 128
    t.string  "email",             limit: 64
    t.string  "homepage",          limit: 64
    t.integer "icq",                                                       unsigned: true
    t.string  "game",              limit: 32,                 null: false
    t.integer "hideranking",                   default: 0,    null: false, unsigned: true
    t.integer "headshots",                     default: 0,    null: false, unsigned: true
    t.integer "last_skill_change",             default: 0,    null: false
    t.integer "displayEvents",                 default: 1,    null: false, unsigned: true
    t.integer "kill_streak",                   default: 0,    null: false
    t.integer "death_streak",                  default: 0,    null: false
    t.integer "blockavatar",                   default: 0,    null: false, unsigned: true
    t.integer "activity",                      default: 100,  null: false
    t.integer "createdate",                    default: 0,    null: false
    t.index ["clan", "playerId"], name: "playerclan", using: :btree
    t.index ["game"], name: "game", using: :btree
    t.index ["hideranking"], name: "hideranking", using: :btree
    t.index ["kills"], name: "kills", using: :btree
    t.index ["skill"], name: "skill", using: :btree
  end

  create_table "hlstats_Players_Awards", primary_key: ["awardTime", "awardId", "playerId", "game"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.date    "awardTime",                        null: false
    t.integer "awardId",              default: 0, null: false, unsigned: true
    t.integer "playerId",             default: 0, null: false, unsigned: true
    t.integer "count",                default: 0, null: false, unsigned: true
    t.string  "game",      limit: 32,             null: false
  end

  create_table "hlstats_Players_History", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "playerId",                   default: 0,    null: false, unsigned: true
    t.date    "eventTime",                                 null: false
    t.integer "connection_time",            default: 0,    null: false, unsigned: true
    t.integer "kills",                      default: 0,    null: false, unsigned: true
    t.integer "deaths",                     default: 0,    null: false, unsigned: true
    t.integer "suicides",                   default: 0,    null: false, unsigned: true
    t.integer "skill",                      default: 1000, null: false, unsigned: true
    t.integer "shots",                      default: 0,    null: false, unsigned: true
    t.integer "hits",                       default: 0,    null: false, unsigned: true
    t.string  "game",            limit: 32, default: "",   null: false
    t.integer "headshots",                  default: 0,    null: false, unsigned: true
    t.integer "teamkills",                  default: 0,    null: false, unsigned: true
    t.integer "kill_streak",                default: 0,    null: false
    t.integer "death_streak",               default: 0,    null: false
    t.integer "skill_change",               default: 0,    null: false
    t.index ["eventTime", "playerId", "game"], name: "eventTime", unique: true, using: :btree
    t.index ["playerId"], name: "playerId", using: :btree
  end

  create_table "hlstats_Players_Ribbons", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "playerId",            default: 0, null: false, unsigned: true
    t.integer "ribbonId",            default: 0, null: false, unsigned: true
    t.string  "game",     limit: 32,             null: false
  end

  create_table "hlstats_Ranks", primary_key: "rankId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "image",    limit: 30,             null: false
    t.integer "minKills",            default: 0, null: false, unsigned: true
    t.integer "maxKills",            default: 0, null: false
    t.string  "rankName", limit: 50,             null: false
    t.string  "game",     limit: 32,             null: false
    t.index ["game"], name: "game", length: {"game"=>8}, using: :btree
    t.index ["image", "game"], name: "rankgame", unique: true, using: :btree
  end

  create_table "hlstats_Ribbons", primary_key: "ribbonId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "awardCode",  limit: 50,             null: false
    t.integer "awardCount",            default: 0, null: false
    t.integer "special",    limit: 1,  default: 0, null: false
    t.string  "game",       limit: 32,             null: false
    t.string  "image",      limit: 50,             null: false
    t.string  "ribbonName", limit: 50,             null: false
    t.index ["awardCode", "awardCount", "game", "special"], name: "award", unique: true, using: :btree
  end

  create_table "hlstats_Roles", primary_key: "roleId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "game",   limit: 32, default: "valve", null: false
    t.string  "code",   limit: 64, default: "",      null: false
    t.string  "name",   limit: 64, default: "",      null: false
    t.string  "hidden", limit: 1,  default: "0",     null: false
    t.integer "picked",            default: 0,       null: false, unsigned: true
    t.integer "kills",             default: 0,       null: false, unsigned: true
    t.integer "deaths",            default: 0,       null: false, unsigned: true
    t.index ["game", "code"], name: "gamecode", unique: true, using: :btree
  end

  create_table "hlstats_Servers", primary_key: "serverId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0" do |t|
    t.string  "address",       limit: 32,  default: "",      null: false
    t.integer "port",                      default: 0,       null: false, unsigned: true
    t.string  "name",                      default: "",      null: false
    t.integer "sortorder",     limit: 1,   default: 0,       null: false
    t.string  "game",          limit: 32,  default: "valve", null: false
    t.string  "publicaddress", limit: 128, default: "",      null: false
    t.string  "statusurl"
    t.string  "rcon_password", limit: 128, default: "",      null: false
    t.integer "kills",                     default: 0,       null: false
    t.integer "players",                   default: 0,       null: false
    t.integer "rounds",                    default: 0,       null: false
    t.integer "suicides",                  default: 0,       null: false
    t.integer "headshots",                 default: 0,       null: false
    t.integer "bombs_planted",             default: 0,       null: false
    t.integer "bombs_defused",             default: 0,       null: false
    t.integer "ct_wins",                   default: 0,       null: false
    t.integer "ts_wins",                   default: 0,       null: false
    t.integer "act_players",               default: 0,       null: false
    t.integer "max_players",               default: 0,       null: false
    t.string  "act_map",       limit: 64,  default: "",      null: false
    t.integer "map_rounds",                default: 0,       null: false
    t.integer "map_ct_wins",               default: 0,       null: false
    t.integer "map_ts_wins",               default: 0,       null: false
    t.integer "map_started",               default: 0,       null: false
    t.integer "map_changes",               default: 0,       null: false
    t.integer "ct_shots",                  default: 0,       null: false
    t.integer "ct_hits",                   default: 0,       null: false
    t.integer "ts_shots",                  default: 0,       null: false
    t.integer "ts_hits",                   default: 0,       null: false
    t.integer "map_ct_shots",              default: 0,       null: false
    t.integer "map_ct_hits",               default: 0,       null: false
    t.integer "map_ts_shots",              default: 0,       null: false
    t.integer "map_ts_hits",               default: 0,       null: false
    t.float   "lat",           limit: 24
    t.float   "lng",           limit: 24
    t.string  "city",          limit: 64,  default: "",      null: false
    t.string  "country",       limit: 64,  default: "",      null: false
    t.integer "last_event",                default: 0,       null: false, unsigned: true
    t.index ["address", "port"], name: "addressport", unique: true, using: :btree
  end

  create_table "hlstats_Servers_Config", primary_key: ["serverId", "parameter"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "serverId",                   default: 0, null: false, unsigned: true
    t.string  "parameter",      limit: 50,              null: false
    t.string  "value",          limit: 128,             null: false
    t.integer "serverConfigId",                         null: false, unsigned: true
    t.index ["serverConfigId"], name: "serverConfigId", using: :btree
  end

  create_table "hlstats_Servers_Config_Default", primary_key: "parameter", id: :string, limit: 50, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "value",       limit: 128,      null: false
    t.text   "description", limit: 16777215,              collation: "utf8_unicode_ci"
  end

  create_table "hlstats_Servers_VoiceComm", primary_key: "serverId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "name",       limit: 128,                 null: false
    t.string  "addr",       limit: 128,                 null: false
    t.string  "password",   limit: 128
    t.string  "descr"
    t.integer "queryPort",              default: 51234, null: false, unsigned: true
    t.integer "UDPPort",                default: 8767,  null: false, unsigned: true
    t.integer "serverType", limit: 1,   default: 0,     null: false
    t.index ["addr", "UDPPort", "queryPort"], name: "address", unique: true, using: :btree
  end

  create_table "hlstats_Teams", primary_key: "teamId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "game",               limit: 32, default: "valve", null: false
    t.string  "code",               limit: 64, default: "",      null: false
    t.string  "name",               limit: 64, default: "",      null: false
    t.string  "hidden",             limit: 1,  default: "0",     null: false
    t.string  "playerlist_bgcolor", limit: 7
    t.string  "playerlist_color",   limit: 7
    t.integer "playerlist_index",   limit: 1,  default: 0,       null: false, unsigned: true
    t.index ["game", "code"], name: "gamecode", unique: true, using: :btree
  end

  create_table "hlstats_Trend", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "timestamp",            default: 0,  null: false
    t.string  "game",      limit: 32, default: "", null: false
    t.integer "players",              default: 0,  null: false
    t.integer "kills",                default: 0,  null: false
    t.integer "headshots",            default: 0,  null: false
    t.integer "servers",              default: 0,  null: false
    t.integer "act_slots",            default: 0,  null: false
    t.integer "max_slots",            default: 0,  null: false
    t.index ["game"], name: "game", using: :btree
    t.index ["timestamp"], name: "timestamp", using: :btree
  end

  create_table "hlstats_Users", primary_key: "username", id: :string, limit: 16, default: "", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "password", limit: 32, default: "", null: false
    t.integer "acclevel",            default: 0,  null: false
    t.integer "playerId",            default: 0,  null: false
  end

  create_table "hlstats_Weapons", primary_key: "weaponId", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "game",      limit: 32,  default: "valve", null: false
    t.string  "code",      limit: 64,  default: "",      null: false
    t.string  "name",      limit: 128, default: "",      null: false
    t.float   "modifier",  limit: 24,  default: 1.0,     null: false
    t.integer "kills",                 default: 0,       null: false, unsigned: true
    t.integer "headshots",             default: 0,       null: false, unsigned: true
    t.index ["code"], name: "code", using: :btree
    t.index ["game", "code"], name: "gamecode", unique: true, using: :btree
    t.index ["modifier"], name: "modifier", using: :btree
  end

  create_table "hlstats_server_load", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "server_id",              default: 0,   null: false
    t.integer "timestamp",              default: 0,   null: false
    t.integer "act_players", limit: 1,  default: 0,   null: false
    t.integer "min_players", limit: 1,  default: 0,   null: false
    t.integer "max_players", limit: 1,  default: 0,   null: false
    t.string  "map",         limit: 64
    t.string  "uptime",      limit: 10, default: "0", null: false
    t.string  "fps",         limit: 10, default: "0", null: false
    t.index ["server_id"], name: "server_id", using: :btree
    t.index ["timestamp"], name: "timestamp", using: :btree
  end

end
