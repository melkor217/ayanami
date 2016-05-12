json.array!(@countries) do |country|
  json.extract! country, :flag, :players_total, :avg_activity, :avg_skill, :avg_kills, :kpd
  json.country country.country.name
  json.url country_path(country.country, format: :json)
  json.path country_path(country.country)
end
