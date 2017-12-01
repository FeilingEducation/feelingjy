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
  var $history = $('.message-history.active');
  $history.append($('<div class="message sent-message">' +
  '<div class="msg-thumb"> <img src="' + data.img_url +'"/></div>' +
  '<div class="msg-content-wrapper">' +
  '<span class="fs-120 contact-name"><strong>' + data.sender + '</strong></span>' +
  ' <span class="fs-80 d-block">Posted on: ' + data.timestamp + '</span>' +
  '<div class="msg-content">' +
  ' <p class="mb-1">' + data.content + '</p></div>' +
  '<div class="msg-attachments">' +
  // concatenate all attachment elements
  data.attachments.reduce(function (cat, att) {
    return cat + '<div class="attachment">' + ' <a href="' + att.url + '" target="_blank">' + att.name + '</a>' + '</div>';
  }, '') + '</div></div></div>'


  // scroll to bottom
)).prop('scrollTop', $history.prop('scrollHeight'));
// removed all frontend attachment elements
$this.find('.attachments-container').empty();
$('.message-box-area').val('')
$('.message-history').removeClass('active')
});

$(document).on('ajax:beforeSend', '.message-form', function (e) {
  console.log('beforeSend message-form...')
  var messageForm = e.target
  var messageHistoryCls = $(messageForm).data('boxid')
  if(messageHistoryCls){
    $("."+messageHistoryCls.toString()).addClass('active')
  }

})

// Doing some DOM manipulation
$(document).on('turbolinks:load', function () {
  $('.right-message-content .message-history').scrollTop(5000)
  $('.right-message-content .body').scrollTop(5000)
  $('.left-msg-nav-item').on('click', function(){
    $('.left-msg-nav-item').removeClass('active')
    $(this).addClass('active');
    $('.right-message-content').addClass('hidden');
    var $target = $(this).data('target')
    var $scrollHeight = $($target).removeClass('hidden').prop('scrollHeight')
    // console.log('$scrollHeight', $scrollHeight)
    $('.right-message-content .message-history').scrollTop(5000)
    $('.right-message-content .body').scrollTop(5000)
  })

  $('#send-msg-txt-area').on('keyup', function(){
    $('#msg-char-count').html('')
    $('#msg-char-count').text($(this).val().length)
  })

  $(".press_enter_false").on('change', function(){
    if($(".press_enter_false").prop("checked")){
      window.msg_press_enter = 'new_line'
    }
  })

  $(".press_enter_true").on('change', function(){
    if($(".press_enter_true").prop("checked")){
      window.msg_press_enter = 'send_msg'
    }
  })

})

window.msg_press_enter = 'new_line'
// Detecting enter key during message sending.
$(document).on('keypress', 'form.message-form textarea', function (e) {
  if (e.keyCode == 13 && !e.shiftKey && window.msg_press_enter === 'send_msg') {
    e.preventDefault();
    // $(this).closest('form').submit();
    $(this).parent().find(".send-msg-btn").click()
    return false;
  }
});
