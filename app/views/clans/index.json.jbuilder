json.rows do
  json.array!(@clans) do |clan|
    json.partial! 'clans/show', clan: clan
  end
end
json.total @count
