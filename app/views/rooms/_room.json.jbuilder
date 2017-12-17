json.extract! room, :id, :roomType, :description, :image, :quantity, :price, :created_at, :updated_at
json.url room_url(room, format: :json)
