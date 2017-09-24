$(document).on('turbolinks:load', function() {
  let $chat = $('.chat-box');
  if ($chat.length == 0)
    return;
  App.chat_lines = App.cable.subscriptions.create({
    channel: 'ChatChannel',
    chat_id: $chat.data('chat-id')
  }, {
    received: function(data) {
      $chat.find('.chat-lines').append($(`<div><span>${data['content']}</span></div>`));
      console.log(data);
    }
  });
})
