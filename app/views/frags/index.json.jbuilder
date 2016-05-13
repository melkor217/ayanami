json.array!(@frags) do |frag|
  json.extract! frag, :id
  json.url frag_path(frag, format: :json)
end
