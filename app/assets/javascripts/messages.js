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
  console.log(data)

  // var msg = $('<div class="msg-by-user msg"><div class="img" style="background-image: url('+ data.img_url +');"></div> <span class="msg">' + sanitize(data.content) + '</span>  </div>')
  var msg = $('<div class="reply-by-user msg"> <span class="msg">' + sanitize(data.content) + '</span> <div class="img" style="background-image: url('+ data.img_url +');"></div></div>' +
  data.attachments.reduce(function (cat, att) {
    return cat + '<div class="attachment">' + ' <a href="' + att.url + '" target="_blank">' + att.name + '</a>' + '</div>';
  }, '') +
  '<div class="date-time-con">' +
    '<div class="date-time-send">'+ data.timestamp +'</div>' +
  '</div>'
)

  $history.append(
    msg
  //   $('<div class="message sent-message msg-by-user">' +
  // '<div class="msg-thumb"> <img src="' + data.img_url +'"/></div>' +
  // '<div class="msg-content-wrapper">' +
  // '<div class="msg-content">' +
  // ' <p class="mb-1">' + data.content + '</p></div>' +
  // '<div class="msg-attachments">' +
  // // concatenate all attachment elements
  // data.attachments.reduce(function (cat, att) {
  //   return cat + '<div class="attachment">' + ' <a href="' + att.url + '" target="_blank">' + att.name + '</a>' + '</div>';
  // }, '') + '</div></div></div>'


  // scroll to bottom
// )
).prop('scrollTop', $history.prop('scrollHeight'));
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

  setTimeout(function(){
    console.log("clearing message box1...")
    $('#message-box-area').val('')
  },50)

})

// Doing some DOM manipulation
$(document).on('turbolinks:load', function () {
  var objDiv = document.getElementById("message-history");
  $('.right-message-content .message-history').scrollTop(500000000)
  $('.right-message-content .body').scrollTop(500000000)
  $('.left-msg-nav-item').on('click', function(){
    $('.left-msg-nav-item').removeClass('active')
    $(this).addClass('active');
    $('.right-message-content').addClass('hidden');
    $('.right-message-content').removeClass('valid-right-message-content'); // lei added: add a class to identify which chat box is active
    var $target = $(this).data('target')
    var $scrollHeight = $($target).removeClass('hidden').prop('scrollHeight')
    $($target).addClass('valid-right-message-content')
    // console.log('$scrollHeight', $scrollHeight)
    $('.right-message-content .message-history').scrollTop(500000000)
    $('.right-message-content .body').scrollTop(500000000)
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

  // $("#message-page").on('keypress', 'form.message-form textarea', function(e) {
  //     if (e.keyCode === 13 && !e.shiftKey) {
  //       e.preventDefault();
  //       $(this).parent().find(".send-msg-btn").click()
  //       return false;
  //     }
  // });

  // lei added: if send-btn is click, scroll to the bottom. also, prevent clicking
  // if the textarea is empty
  $(".send-msg-btn").on('click', function (e) {
    var $textarea = $(".valid-right-message-content form.message-form textarea")
    if(!$textarea.val()) {
      e.preventDefault();
    }
    // // scroll to the bottom if a message is sent
    else{
      $('.valid-right-message-content .message-history').scrollTop(500000000)
      $('.valid-right-message-content .body').scrollTop(500000000)
    }
  })
})


// window.msg_press_enter = 'send_msg'
// // Detecting enter key during message sending.
// $(document).on('keypress', 'form.message-form textarea', function (e) {
//   if (e.keyCode == 13 && !e.shiftKey && window.msg_press_enter === 'send_msg') {
//     e.preventDefault();
//     // $(this).closest('form').submit();
//     $(this).parent().find(".send-msg-btn").click()
//     return false;
//   }
// });


// add this so that the chatbox contacts can scroll all the way up even thought its parent
// has overflow:hidden
$(document).ready(function() {
  $(".chat-name").css("max-height", ($(".msg-left-wrapper").height()-$(".chat-myinfo").height()-60));
});
