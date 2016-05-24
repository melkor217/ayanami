json.rows do
  json.array!(@weapons) do |weapon|
    json.partial! 'weapons/show', weapon: weapon
  end
end

json.total @total
