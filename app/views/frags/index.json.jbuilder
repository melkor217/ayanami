
json.rows do
  json.array!(@frags) do |frag|
    json.extract! frag, :id, :headshot
    json.eventTime frag.eventTime.to_s
    killer = Player.cache_find(frag.killerId)
    victim = Player.cache_find(frag.victimId)
    weapon = Weapon.cache_find(frag.weapon, params[:game_game])
    server = Server.cache_find(frag.serverId)
    json.killer do
      json.avatarIcon killer.unique_ids.first.avatar_icon
      json.lastName killer.lastName
      json.url player_path(killer, format: :json)
      json.path player_path(killer)
    end
    json.victim do
      json.avatarIcon victim.unique_ids.first.avatar_icon
      json.lastName victim.lastName
      json.url player_path(victim, format: :json)
      json.path player_path(victim)
    end
    json.weapon do
      json.code weapon.code
      json.game weapon.game
      json.name weapon.name
      json.icon asset_path("weapons/#{weapon.game}/1/#{weapon.code}.png")
    end
    json.server do
      json.serverId server.serverId
      json.name server.name
      json.path server_path(server)
    end
    json.url frag_path(frag, format: :json)

    if victim.playerId == params[:player_id]
      json.eventType 'death'
    elsif killer.playerId == params[:player_id]
      json.eventType 'kill'
    end
  end
end

json.total @total
