json.array!(@countries) do |country|
  if country
    json.partial! 'countries/players', players: country
    json.partial! 'countries/show', country: country.cached_country
  end
end
