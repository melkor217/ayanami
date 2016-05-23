json.extract! players, :flag, :players_total, :avg_activity, :avg_skill, :avg_kills, :kpd
json.country players.country.name
json.url country_path(players.country, format: :json)
json.path country_path(players.country)
json.icon asset_path('flags-iso/shiny/32/'+players.flag+'.png')
