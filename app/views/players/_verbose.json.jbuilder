json.partial! 'players/show', player: player

json.steamIcon asset_url('misc/steam.png')

json.lastEvent player.last_event

json.killstatsPath killstats_player_path(player)
json.weaponsPath weapons_player_path(player)
json.fragsPath player_frags_path(player)

if (country = player.cached_country)
  json.country do
    json.partial! 'countries/show', country: country
  end
end
