App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    this.perform('follow')
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('YA TUT')
    console.log(data)
    # Called when there's incoming data on the websocket for this channel
