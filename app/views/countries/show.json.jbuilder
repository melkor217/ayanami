#json.extract! @country, :flag, :name
json.partial! 'countries/show', players: @average
