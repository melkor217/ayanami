json.extract! server, :id, :name, :publicaddress, :kills, :headshots, :act_map,
              :sortorder, :game,
              :map_started, :last_event, :act_players, :max_players
json.livestats_players server.livestats_players.count
json.url server_path(server, format: :json)
json.path server_path(server)
