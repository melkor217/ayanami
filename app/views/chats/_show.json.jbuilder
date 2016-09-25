json.extract! message, :id, :map, :message_mode, :message
json.eventTime "#{time_ago_in_words(message.eventTime)} ago"
json.player do
  json.partial! 'players/show', player: Player.cache_find(message.playerId)
end
json.server do
  json.partial! 'servers/show', server: Server.cache_find(message.serverId)
end
