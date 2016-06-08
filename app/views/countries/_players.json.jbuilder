country = players.cached_country

json.extract! players, :flag, :players_total,
              :avg_connection_time, :avg_activity, :avg_skill, :avg_kills, :kpd
json.country country.name
json.url country_path(country, format: :json)
json.path country_path(country)
json.icon asset_path('flags-iso/shiny/32/'+players.flag+'.png')
