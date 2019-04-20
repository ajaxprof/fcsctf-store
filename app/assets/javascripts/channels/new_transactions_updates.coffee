App.new_transactions_updates = App.cable.subscriptions.create "NewTransactionsUpdatesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('.list-group').prepend("<li class=\"list-group-item list-group-item-info\">#{data.who} => #{data.how_much}x #{data.what}</li>");
