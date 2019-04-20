json.extract! transaction, :id, :user, :item_id, :quantity, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
