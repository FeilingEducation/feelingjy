App.messages = App.cable.subscriptions.create("MessagesChannel", {
  connected: function() {
    console.log('Connected with MessagesChannel...')
  },
  disconnected: function() {},
  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('Recenved data...', data)
    // Append the latest message!!
    var $history = $('.message-history.box-' + data.sender_id);
    $history.append(data.html)
    .prop('scrollTop', $history.prop('scrollHeight'))

    // Clear the message text area
    $('#message-box-area').val('')
    console.log("-0-0-0-0-0----0-0-0")
    if(window.location.pathname != "/messages"){
      $('.nav-message').addClass('message-notification')
    }

  }
});
