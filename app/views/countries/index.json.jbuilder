json.rows do
  json.array!(@countries) do |country|
    json.extract! country, :flag, :players_total, :avg_activity
    json.country country.country.name
    json.url country_path(country.country, format: :json)
    json.path country_path(country.country)
    end
end

json.total @total
