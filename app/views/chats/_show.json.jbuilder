json.extract! message, :id, :serverId, :map, :message_mode, :message
json.eventTime "#{time_ago_in_words(message.eventTime)} ago"
json.player do
  json.partial! 'players/show', player: Player.find(message.playerId)
end
