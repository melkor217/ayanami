json.rows do
  json.array! @weapons, partial: 'weapons/show', as: :weapon
end
