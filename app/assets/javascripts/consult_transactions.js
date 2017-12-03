'use strict';

// trigger form submission at "enter" key press event
// Allowing shift+enter to enter a newline
$(document).on('keypress', 'form.chat-input textarea', function (e) {
  if (e.keyCode == 13 && !e.shiftKey && window.chat_msg_press_enter == 'send_msg') {
    $(this).closest('form').trigger('submit');
    return false;
  }
});

function updateDescriptionCharCount(input, charCountTraget, errorSpan){
  setTimeout(function(){
    $(charCountTraget).text($(input).val().length)

    if($(input).val().length < 400){
      $(input).next(errorSpan).removeClass('hidden')
    }
    else{
      $(input).next(errorSpan).addClass('hidden')
    }
  }, 100)
}

$(document).on('keypress', '#description', function (e) {
  updateDescriptionCharCount("#description", '#description-char-count span', 'span.error')
});

$(document).on('paste', '#description', function (e) {
  updateDescriptionCharCount("#description", '#description-char-count span', 'span.error')
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
      var $chat_body = $('.chat-con .body');
      $chat_lines.prop('scrollTop', $chat_lines.prop('scrollHeight'));
      $chat_body.prop('scrollTop', $chat_body.prop('scrollHeight'));
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

$(document).on('turbolinks:load', function () {

  $('#join-video-dialog').on('click', function(){
    if(openTok.publishVideo){
      $('#init-video').click()
    }
    else{
      $('#init-audio').click()
    }
    $('#call-dialog').modal('hide')
  })

  $('#cancel-video-dialog').on('click', function(){
    App.consult_comm.send_video_status_flag("call_rejected");
    $('#call-dialog').modal('hide')
  })

  $('#init-video').on('click', function(e){
    e.preventDefault()
    openTok.publishVideo = true
    openTok.initPublisher(gon.opentok_api_key, gon.session_id)
    App.consult_comm.send_video_status_flag("started_video");
    $('#init-video').addClass('hidden')
    $("#flag-info-msg").html('').text('Please wait while we are connecting...')
  })
  $('#init-audio').on('click', function(e){
    e.preventDefault()
    openTok.publishVideo = false
    openTok.initPublisher(gon.opentok_api_key, gon.session_id)
    App.consult_comm.send_video_status_flag("started_audio");
    $('#init-audio').addClass('hidden')
    $("#flag-info-msg").html('').text('Please wait while we are connecting...')
  })
  $('#cancel-video').on('click', function(){
    openTok.unPublish()
    $('#init-video').removeClass('hidden')
    $("#flag-info-msg").html('')
    $('#init-audio').removeClass('hidden')
    $('#cancel-video').addClass('hidden')
    $('#publisherContainer').removeClass('publisher-container')
    $("#subscriberContainer").removeClass('hidden')
    App.consult_comm.send_video_status_flag("cancelled");
  })

  $(".chat_press_enter_false").on('change', function(){
    if($(".chat_press_enter_false").prop("checked")){
      window.chat_msg_press_enter = 'new_line'
    }
  })

  $(".chat_press_enter_true").on('change', function(){
    if($(".chat_press_enter_true").prop("checked")){
      window.chat_msg_press_enter = 'send_msg'
    }
  })
})

window.chat_msg_press_enter = 'send_msg'
// Detecting enter key during message sending.
$(document).on('keypress', 'form.message-form textarea', function (e) {
  console.log('keypress...',window.chat_msg_press_enter)
  if (e.keyCode == 13 && !e.shiftKey && window.chat_msg_press_enter == 'send_msg') {
    e.preventDefault();
    // $(this).closest('form').submit();
    $(this).parent().find('.msg-send-btn').click();
    console.log("$(this).closest('.msg-send-btn')", $(this).closest('.msg-send-btn'))
    return false;
  }
});

// Some UI elements
var $publisherContainer = $('#publisherContainer')
var $subscriberContainer = $('#subscriberContainer')

// Open Tok video chat flow
var openTok = {}

// some control flags
openTok.connectionCount = 0;
openTok.connected = false,
openTok.publisherInitialized = false;

// DOM containers
openTok.publisherContainer = 'publisherContainer'
openTok.subscriberContainer = 'subscriberContainer'

// Audio video options
openTok.publishAudio = true
openTok.publishVideo = true

// Some subcriber and publisher properties
openTok.subscriberProperties = function(){
  var options = {insertMode: 'append',width: 300,height: 250, publishAudio: openTok.publishAudio, publishVideo:openTok.publishVideo, videoSource: null};
  if(openTok.publishVideo){
    delete options.videoSource;
  }
  return options
}
openTok.publisherProperties = function(){
  var options = {insertMode: 'append',width: 300,height: 250, publishAudio: openTok.publishAudio, publishVideo:openTok.publishVideo, videoSource: null};
  if(openTok.publishVideo){
    delete options.videoSource;
  }
  console.log("options", options)
  return options
}

openTok.initSession = function(apiKey, sessionId){
  if (OT.checkSystemRequirements() == 1) {
    if(openTok.connected){
      console.log('Session is already initialized!!!')
    }
    else if(!openTok.publisherInitialized){
      console.log('Publisher is not initialized!!!')
    }
    else{
      if(openTok.session == undefined){
        console.log('initing new session!!!!')
        var session = OT.initSession(apiKey, sessionId);
      }
      else{
        return;
      }
      session.on({
        connectionCreated: function (event) {
          console.log('connectionCreated...')
          // openTok.publish()
          openTok.connectionCount++;
          if (event.connection.connectionId != session.connection.connectionId) {
            console.log('Another client connected. ' + openTok.connectionCount + ' total.');
          }
        },
        connectionDestroyed: function (event) {
          openTok.connectionCount--;
          console.log('A client disconnected. ' + openTok.connectionCount + ' total.');
        },
        sessionDisconnected: function (event) {
          // The event is defined by the SessionDisconnectEvent class
          if (event.reason == "networkDisconnected") {
            alert("Your network connection terminated.")
          }
        },
        sessionReconnecting: function() {
          // Display a user interface notification.
          console.log('reconnecting...')
        },
        sessionReconnected: function() {
          // Adjust user interface.
          console.log('Reconnected...')
        }
      });

      session.on("streamCreated", function (event) {
        console.log("New stream in the session: " + event.stream.streamId);

        openTok.session.subscribe(event.stream,
          openTok.subscriberContainer,
          openTok.subscriberProperties(),
          function (error) {
            if (error) {
              console.log(error);
            } else {
              console.log('Subscriber added.');
              App.consult_comm.send_video_status_flag("partner_joined");
              $("#publisherContainer").addClass('publisher-container')
              $("#subscriberContainer").removeClass('hidden')
            }
          }
        )
      })

      session.on("streamDestroyed", function (event) {
        $("#publisherContainer").removeClass('publisher-container')
        $("#subscriberContainer").removeClass('hidden')
        openTok.session.unsubscribe(event.stream)
        console.log("Stream stopped. Reason: " + event.reason);
      });

      openTok.session = session;
    }
  }
  else{
    alert('Please use Chrome...')
  }
}

// init publisher
openTok.initPublisher = function(apiKey,sessionId){
  // Get available audio and video devices
  // var audioInputDevices;
  // var videoInputDevices;
  //
  // OT.getDevices(function(error, devices) {
  //   audioInputDevices = devices.filter(function(element) {
  //     return element.kind == "audioInput";
  //   });
  //   videoInputDevices = devices.filter(function(element) {
  //     return element.kind == "videoInput";
  //   });
  //   for (var i = 0; i < audioInputDevices.length; i++) {
  //     console.log("audio input device: ", audioInputDevices[i].deviceId);
  //   }
  //   for (i = 0; i < videoInputDevices.length; i++) {
  //     console.log("video input device: ", videoInputDevices[i].deviceId);
  //   }
  // });

  // set the publish options
  // Set the videoSource property to null or false in a voice-only session
  var pubOptions = {
    // audioSource: audioInputDevices[0].deviceId,
    // videoSource: videoInputDevices[0].deviceId,
    usePreviousDeviceSelection: true
  };

  // initialize publisher
  var publisher = OT.initPublisher(openTok.publisherContainer, openTok.publisherProperties(), function (error) {
    if (error) {
      console.log(error);
    } else {
      console.log("Publisher initialized.");
      openTok.initSession(apiKey,sessionId);
      openTok.connectSession(gon.token);
    }
  })

  // Add some events
  publisher.on({
    accessAllowed: function (event) {
      // The user has granted access to the camera and mic.
      console.log('Access allowed....')
    },
    accessDenied: function(event) {
      // The user has denied access to the camera and mic.
      console.log('Access denied....')
    },
    accessDialogOpened: function (event) {
      // The Allow/Deny dialog box is opened.
      console.log('accessDialogOpened opened....')
      // Show allow camera message
      // pleaseAllowCamera.style.display = 'block';
    },
    accessDialogClosed: function (event) {
      // The Allow/Deny dialog box is closed.
      console.log('accessDialogOpened closed....')
      // Hide allow camera message
      // pleaseAllowCamera.style.display = 'none';
    },
    streamCreated: function (event) {
      console.log('The publisher started streaming.');
    },
    streamDestroyed: function (event) {
      console.log("The publisher stopped streaming. Reason: "+ event.reason);

      // By default, when a Publisher dispatches the streamDestroyed event,
      // the Publisher is destroyed and removed from the HTML DOM.
      // You can prevent this default behavior by calling the preventDefault() method of the StreamEvent object:
      // event.preventDefault();
    }
  });

  // make it available via openTok object.
  openTok.publisher = publisher;

  // set the openTok.publisherInitialized flag to true
  openTok.publisherInitialized = true
}

// just to attempt 5 times if user is not able to connect.
openTok.reconnectionTries = 0
// connect with session
openTok.connectSession = function(token){
  openTok.session.connect(token, function (error) {
    if (error) {
      console.log("Failed to connect. attempting again. Total tries: "+ openTok.reconnectionTries);
      if(openTok.reconnectionTries < 5){
        openTok.reconnectionTries += 1;
        openTok.connectSession(token);
      }
    } else {
      console.log('You have connected to the session.');
      openTok.reconnectionTries = 0;
      openTok.connected = true;
      openTok.publish()
    }
  });
}

// disconnect session
openTok.disconnectSession = function(){
  openTok.session.disconnect(gon.token)
  openTok.connected = false;
}

// start publishing
openTok.publish = function(){
  openTok.session.publish(openTok.publisher, function(error) {
    if (error) {
      console.log(error);
    } else {
      console.log('Publishing a stream.');
      openTok.publisherInitialized = true;
      $('#cancel-video').removeClass('hidden')
      App.consult_comm.send_video_status_flag("ready");
    }
  });
}

// Unpublish
openTok.unPublish = function(){
  openTok.disconnectSession()
  openTok.session.unpublish(openTok.publisher)
  openTok.publisherInitialized = false
}
