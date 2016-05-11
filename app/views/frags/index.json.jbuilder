json.array!(@frags) do |frag|
  json.extract! frag, :id
  json.url frag_url(frag, format: :json)
end
