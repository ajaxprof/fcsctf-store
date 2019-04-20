class Transaction < ApplicationRecord
  belongs_to :item, required: true
  belongs_to :user, required: true

  validate :balance_must_cover_the_price,
           :item_must_be_in_stock,
           :check_allowed_overhead

  before_create :update_balance, :update_item_quantity, :notify_dashboard

  private

  def balance_must_cover_the_price
    previous_balance = user.balance
    delta = item.price * quantity
    new_balance = previous_balance - delta
    if new_balance < 0
      errors.add(:balance, 'Not enough PTS for transaction')
    end
  end

  def item_must_be_in_stock
    previous_quantity = item.quantity
    delta = quantity
    new_quantity = previous_quantity - delta
    if new_quantity < 0
      errors.add(:quantity, 'Not enough items in stock')
    end
  end

  def check_allowed_overhead
    if item.max_allowed.present?
      current_count = user.transactions.where(item_id: item.id).count
      unless current_count < item.max_allowed
        errors.add(:item, 'You can\'t buy any more of this')
      end
    end
  end

  def update_balance
    previous_balance = user.balance
    delta = item.price * quantity
    new_balance = previous_balance - delta
    user.update(balance: new_balance)
  end

  def update_item_quantity
    previous_quantity = item.quantity
    delta = quantity
    new_quantity = previous_quantity - delta
    item.update(quantity: new_quantity)
  end

  def notify_dashboard
    ActionCable.server.broadcast 'new_transaction_updates_channel', who: user.team_name, how_much: quantity, what: item.title
  end

end
