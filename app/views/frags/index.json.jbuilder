
json.array!(@frags) do |frag|
  json.extract! frag, :id, :eventTime
  killer = Player.cache_find(frag.victimId)
  victim = Player.cache_find(frag.victimId)
  weapon = Weapon.cache_find(frag.weapon, params[:game_game])
  json.killer do
    json.avatarIcon killer.unique_ids.first.avatar_icon
    json.lastName killer.lastName
  end
  json.victim do
    json.avatarIcon victim.unique_ids.first.avatar_icon
    json.lastName victim.lastName
  end
  json.weapon do
    json.code weapon.code
    json.game weapon.game
    json.name weapon.name
  end
  json.url frag_path(frag, format: :json)
end
