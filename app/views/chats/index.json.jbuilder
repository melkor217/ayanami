json.rows do
  json.array!(@messages) do |message|
    json.partial! 'chats/show', message: message
  end
end

json.total @total
