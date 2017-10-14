// trigger form submission at "enter" key press event
// Allowing shift+enter to enter a newline
$(document).on('keypress', 'form.chat-input textarea', function(e) {
  if (e.keyCode == 13 && !e.shiftKey) {
    $(this).closest('form').trigger('submit');
    return false;
  }
});

// Override default behavior of submitting the chat-line form
$(document).on('submit', 'form.chat-input', function(e) {
  // getFormData is a self defined function in application.js to extract form
  // fields into an Object.
  var data = $(e.target).getFormData();
  // Don't submit if content is empty
  if (data.content == "") {
    return false;
  }
  // disable submit button in case multiple submission before hearing back from server
  $(this).find('input[type="submit"]').prop('disabled', true);
  // send chat-line data to backend
  App.consult_comm.create_chat_line(data);
  // select all text in chat-input for easy typing
  $(this).find('textarea').select();
  return false;
});

// start voice chat
$(document).on('click', '.voice-chat-init', function(e) {
  App.consult_comm.start_rtc_peer_conn();
});

$(document).on('turbolinks:load', function() {
  // scroll all chat lines to bottom at load
  for (var chat_lines of $('.chat-lines')) {
    const $chat_lines = $(chat_lines);
    $chat_lines.prop('scrollTop', $chat_lines.prop('scrollHeight'));
  }
});
