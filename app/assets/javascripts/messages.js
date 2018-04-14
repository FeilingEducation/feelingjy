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

})

// Doing some DOM manipulation
$(document).on('turbolinks:load', function () {
  var objDiv = document.getElementById("message-history");
  $('.right-message-content .message-history').scrollTop(objDiv.scrollHeight)
  $('.right-message-content .body').scrollTop(objDiv.scrollHeight)
  $('.left-msg-nav-item').on('click', function(){
    $('.left-msg-nav-item').removeClass('active')
    $(this).addClass('active');
    $('.right-message-content').addClass('hidden');
    var $target = $(this).data('target')
    var $scrollHeight = $($target).removeClass('hidden').prop('scrollHeight')
    // console.log('$scrollHeight', $scrollHeight)
    $('.right-message-content .message-history').scrollTop(50000000)
    $('.right-message-content .body').scrollTop(50000000)
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

  $("#message-page").on('keypress', 'form.message-form textarea', function(event) {
      if (event.keyCode === 13 && !event.shiftKey) {
          $("#send-msg-btn").click();
      }
  });

  $("#send-msg-btn").on('click', function (e) {
    // if the send-msg-btn is triggered by click() function, then
    // all of the contact's button will be triggered. But other chatboxes
    // are empty. so prevent these empty messages from sending by adding this.
    console.log($('form.message-form textarea').val())
    if(!$('form.message-form textarea').val()) {
      console.log("in here")
      // e.preventDefault();
    }
    // scroll to the bottom if a message is sent
    else{
      $('.right-message-content .message-history').scrollTop(objDiv.scrollHeight)
      $('.right-message-content .body').scrollTop(objDiv.scrollHeight)
      console.log(objDiv.scrollHeight)
    }
  })
})


// window.msg_press_enter = 'new_line'
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
