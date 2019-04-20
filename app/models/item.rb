class Item < ApplicationRecord
  has_many :transactions

  before_save :sync_quantity, if: :will_save_change_to_quantity?

  private

  def sync_quantity
    ActionCable.server.broadcast 'quantity_updates_channel', id: id, quantity: quantity
  end

end
