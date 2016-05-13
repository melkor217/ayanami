json.array!(@servers) do |server|
  json.extract! server, :id
  json.url server_path(server, format: :json)
end
