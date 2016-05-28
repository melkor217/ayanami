#json.extract! @country, :flag, :name
json.partial! 'countries/players', players: @average
