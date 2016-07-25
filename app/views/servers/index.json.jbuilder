json.array!(@servers) do |server|
  json.partial! 'servers/verbose', server: server
end
