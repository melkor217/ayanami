json.country country.name
json.flag country.flag
json.url country_path(country, format: :json)
json.path country_players_path(country)
json.icon asset_path('flags-iso/shiny/32/'+country.flag+'.png')
