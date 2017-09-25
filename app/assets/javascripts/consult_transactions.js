$(document).on('keypress', '.chat-input textarea', function(e) {
  if (e.keyCode == 13 && !e.shiftKey) {
    $(this).select();
    $(this).closest('form').trigger('submit.rails');
    return false;
  }
});
