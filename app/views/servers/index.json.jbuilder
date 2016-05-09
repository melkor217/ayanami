json.array!(@servers) do |server|
  json.extract! server, :id
  json.url server_url(server, format: :json)
end
