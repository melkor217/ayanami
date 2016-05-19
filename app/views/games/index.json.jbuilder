json.array!(@games) do |game|
  json.extract! game, :id, :code, :name, :hidden, :realgame
  json.url game_url(game, format: :json)
end
