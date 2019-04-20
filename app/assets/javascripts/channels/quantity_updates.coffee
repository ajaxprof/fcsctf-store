App.quantity_updates = App.cable.subscriptions.create "QuantityUpdatesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#item-#{data.id}").text data.quantity
