'use strict';

// Callback for message-form submission.
// See /views/instructor_info/_message-box.html.erb
// and messages_controller#create
//
// A message is sent asynchronously to the backend in JSON format
// The reply is handled by this callback to append a new message element to the
// .message-history element. Each attachment associated with the message will
// appear as a link.
$(document).on('ajax:success', '.message-form', function (e) {
  var data = e.detail[0];
  var $this = $(this);
  var $history = $('.message-history');
  $history.append($('<div class="message">' + ' <span class="fs-120 d-block"><strong>' + data.sender + '</strong></span>' + ' <span class="fs-80 d-block">Posted on: ' + data.timestamp + '</span>' + ' <p class="mb-1">' + data.content + '</p>' +
  // concatenate all attachment elements
  data.attachments.reduce(function (cat, att) {
    return cat + '<div class="attachment">' + ' <a href="' + att.url + '" target="_blank">' + att.name + '</a>' + '</div>';
  }, '') + '</div>'
  // scroll to bottom
  )).prop('scrollTop', $history.prop('scrollHeight'));
  // removed all frontend attachment elements
  $this.find('.attachments-container').empty();
});
