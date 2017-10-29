'use strict';

// trigger form submission at "enter" key press event
// Allowing shift+enter to enter a newline
$(document).on('keypress', 'form.chat-input textarea', function (e) {
  if (e.keyCode == 13 && !e.shiftKey) {
    $(this).closest('form').trigger('submit');
    return false;
  }
});

// Override default behavior of submitting the chat-line form
$(document).on('submit', 'form.chat-input', function (e) {
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
  $(this).find('textarea').val('')
  return false;
});

// start voice chat
$(document).on('click', '.voice-chat-init', function (e) {
  App.consult_comm.start_rtc_peer_conn();
});

$(document).on('turbolinks:load', function () {
  // scroll all chat lines to bottom at load
  var _iteratorNormalCompletion = true;
  var _didIteratorError = false;
  var _iteratorError = undefined;

  try {
    for (var _iterator = $('.chat-lines')[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
      var chat_lines = _step.value;

      var $chat_lines = $(chat_lines);
      $chat_lines.prop('scrollTop', $chat_lines.prop('scrollHeight'));
    }
  } catch (err) {
    _didIteratorError = true;
    _iteratorError = err;
  } finally {
    try {
      if (!_iteratorNormalCompletion && _iterator.return) {
        _iterator.return();
      }
    } finally {
      if (_didIteratorError) {
        throw _iteratorError;
      }
    }
  }
});
