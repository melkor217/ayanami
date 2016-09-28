json.partial! 'players/show', player: player

json.steamIcon asset_url('misc/steam.png')

json.lastEvent player.last_event

json.killstatsPath killstats_player_path(player)
json.weaponsPath weapons_player_path(player)
json.fragsPath player_frags_path(player)
json.chatsPath player_chats_path(player)
json.avgLatency player.latencies.avg_value