$(document).on('turbolinks:load', function() {
  let $chat = $('.chat-box');
  if ($chat.length == 0)
    return;
  let $chat_lines = $chat.find('.chat-lines');
  $chat_lines.prop('scrollTop', $chat_lines.prop('scrollHeight'));
  let user_id = $chat.data('user-id');
  App.chat_lines = App.cable.subscriptions.create({
    channel: 'ChatChannel',
    chat_id: $chat.data('chat-id')
  }, {
    received: function(data) {
      let $chat_line = $(`<div><pre>${sanitize(data['content'])}</pre></div>`);
      if (user_id == data['user_id'])
        $chat_line.addClass('my-chat-line');
      $chat_lines.append($chat_line).prop('scrollTop', $chat_lines.prop('scrollHeight'));
    }
  });
})
