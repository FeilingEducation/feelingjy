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

$(document).on('turbolinks:load', function () {
  $('#init-video').on('click', function(){
    openTok.initPublisher(gon.opentok_api_key, gon.session_id)
    $('#init-video').addClass('hidden')
    $('#cancel-video').removeClass('hidden')
  })
  $('#cancel-video').on('click', function(){
    openTok.unPublish()
    $('#init-video').removeClass('hidden')
    $('#cancel-video').addClass('hidden')
  })
})

// Open Tok video chat flow
var openTok = {}

// some control flags
openTok.connectionCount = 0;
openTok.connected = false,
openTok.publisherInitialized = false;

// DOM containers
openTok.publisherContainer = 'publisherContainer'
openTok.subscriberContainer = 'subscriberContainer'

// Some subcriber and publisher properties
openTok.subscriberProperties = {insertMode: 'append'};
openTok.publisherProperties = {insertMode: 'append'};

openTok.initSession = function(apiKey, sessionId){
  if (OT.checkSystemRequirements() == 1) {
    if(openTok.connected){
      console.log('Session is already initialized!!!')
    }
    else if(!openTok.publisherInitialized){
      console.log('Publisher is not initialized!!!')
    }
    else{
      var session = OT.initSession(apiKey, sessionId);
      session.on({
        connectionCreated: function (event) {
          console.log('connectionCreated...')
          openTok.publish()
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
          openTok.subscriberProperties,
          function (error) {
            if (error) {
              console.log(error);
            } else {
              console.log('Subscriber added.');
            }
          }
        )
      })

      session.on("streamDestroyed", function (event) {
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
  var pubOptions ={
    // audioSource: audioInputDevices[0].deviceId,
    // videoSource: videoInputDevices[0].deviceId,
    usePreviousDeviceSelection: true
  };

  // initialize publisher
  var publisher = OT.initPublisher(openTok.publisherContainer, openTok.publisherProperties, function (error) {
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

// connect with session
openTok.connectSession = function(token){
  openTok.session.connect(token, function (error) {
    if (error) {
      console.log("Failed to connect.");
    } else {
      console.log('You have connected to the session.');
      openTok.connected = true;
    }
  });
}

// disconnect session
openTok.disconnectSession = function(){
  openTok.session.disconnect()
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
    }
  });
}

// Unpublish
openTok.unPublish = function(){
  openTok.session.unpublish(openTok.publisher)
  openTok.disconnectSession()
  openTok.publisherInitialized = false
}
