json.extract! server, :id, :name, :publicaddress, :sortorder, :game
json.url server_path(server, format: :json)
json.path server_path(server)
