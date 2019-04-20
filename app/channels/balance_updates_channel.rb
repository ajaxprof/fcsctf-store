class BalanceUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "balance_updates_channel:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
