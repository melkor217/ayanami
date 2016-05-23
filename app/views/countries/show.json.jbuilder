#json.extract! @country, :flag, :name
json.players do
  json.partial! 'countries/show', players: @players
end
