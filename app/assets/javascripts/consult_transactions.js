$(document).on('keypress', 'form.chat-input textarea', function(e) {
  if (e.keyCode == 13 && !e.shiftKey) {
    $(this).closest('form').trigger('submit');
    return false;
  }
});

$(document).on('submit', 'form.chat-input', function(e) {
  let data = $(e.target).getFormData();
  if (data.content == "") {
    return false;
  }
  $(this).find('input[type="submit"]').prop('disabled', true);
  App.consult_comm.create_chat_line(data);
  $(this).find('textarea').select();
  return false;
});

$(document).on('click', '.voice-chat-init', function(e) {
  App.consult_comm.start_rtc_peer_conn();
});
