App.balance_updates = App.cable.subscriptions.create "BalanceUpdatesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#balance').text data.balance