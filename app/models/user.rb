class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions

  before_save :sync_balance, if: :will_save_change_to_balance?

  def email_required?;false;end
  def email_changed?;false;end
  def will_save_change_to_email?;false;end

  def notify(message, level='warn')
    ActionCable.server.broadcast "buy_updates_channel:#{id}", level: level, message: message
  end

  private

  def sync_balance
    ActionCable.server.broadcast "balance_updates_channel:#{id}", balance: balance
  end
end
