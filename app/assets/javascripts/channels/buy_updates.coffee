App.buy_updates = App.cable.subscriptions.create "BuyUpdatesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    switch (data.level)
      when 'warn'    then alertify.warning(data.message)
      when 'error'   then alertify.error  (data.message)
      when 'success' then alertify.success(data.message)