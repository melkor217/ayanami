json.array!(@clans) do |clan|
  json.partial! 'clans/show', clan: clan
end