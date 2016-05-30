json.array!(@servers) do |server|
  json.partial! 'servers/show', server: server
end
