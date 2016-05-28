json.array!(@countries) do |country|
  json.partial! 'countries/players', players: country
  json.partial! 'countries/show', country: country.country
end
