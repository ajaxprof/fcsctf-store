class NewTransactionsUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "new_transaction_updates_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
