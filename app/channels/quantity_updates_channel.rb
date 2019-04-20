class QuantityUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quantity_updates_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
