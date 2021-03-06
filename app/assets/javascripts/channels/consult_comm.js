'use strict';

// .consult-comm is the high level container for the consult communication
// Currently it contains a .chat-box. It uses websocket (Channel in ROR terms) to
// communicates with the backend.
//
// This functions subscribs with the server backend "Channel" if there exists a
// .consult-comm in the page
$(document).on('turbolinks:load', function () {
  var $consult_comm = $('.consult-comm');
  if ($consult_comm.length == 0) return;
  var $chat = $consult_comm.find('.chat-box');
  var $chat_lines = $chat.find('.chat-lines');
  var $chat_body = $('.chat-con .body');
  var user_id = $consult_comm.data('user-id');

  App.consult_comm = App.cable.subscriptions.create({
    // Channel name, see /app/channels/consult_comm_channel.rb
    channel: 'ConsultCommChannel',
    // use the transaction ID as the channel identifier. The loggined user can
    // only listen to this channel if he is the student or instructor of this
    // transaction. Authentication is checked on backend.
    transaction_id: $consult_comm.data('transaction-id')
  }, {
    // For more information about the callbacks, see
    // http://guides.rubyonrails.org/action_cable_overview.html#client-server-interactions-subscriptions
    //
    // data has the scheme of { type: str, comm_data: {} }
    // type is used for multiplexing chat_line and voice_chat data.
    // comm_data is the actual payload
    received: function received(data) {
      var comm = data.comm_data;
      switch (data.type) {
        case 'chat_line':
          // when a chat_line data is received, append the content to the .chat_lines.
          // Content needs to be first sanitized to avoid arbitrary script injection
          if (comm) {
            console.log("comm:::", comm)
            if(user_id == comm.user_id){
              var $chat_line = $('<div class="reply-by-user msg"> <span class="msg">' + sanitize(comm.content) + '</span> <div class="img" style="background-image: url('+ comm.current_user_image_url +');"></div> </div>')
            }
            else{
              var $chat_line = $('<div class="msg-by-user msg"><div class="img" style="background-image: url('+ comm.current_user_image_url +');"></div> <span class="msg">' + sanitize(comm.content) + '</span>  </div>')
            }
            // put the chat-line to the right if it is a self post.
            // if (user_id == comm.user_id) $chat_line.addClass('chat-line-right');
            // scroll to bottom when new chat-line is appended
            $chat_lines.append($chat_line)
            $chat_body.prop('scrollTop', $chat_body.prop('scrollHeight'));
          }
          // re-enable submit button (disabled at submission)
          $('.chat-input input[type="submit"]').prop('disabled', false);
          break;
        case 'voice_chat':
          // code modified from https://www.html5rocks.com/en/tutorials/webrtc/basics/#simpleRTCPeerConnectionExample
          // including the "start_rtc_peer_conn" below
          if (!this.pc) this.start_rtc_peer_conn();
          switch (comm.type) {
            case 'sdp':
              console.log('sdp received:', comm.payload);
              this.pc.setRemoteDescription(new RTCSessionDescription(comm.payload), function () {
                if (this.pc.remoteDescription.type == 'offer') this.pc.createAnswer(this.localDescCreated, this.logError);
              }, this.logError);
              break;
            case 'candidate':
              console.log("candidated received:", comm.payload);
              this.pc.addIceCandidate(new RTCIceCandidate(comm.payload));
              break;
            default:
              console.log('Unknown voice chat payload type: ' + comm.type);
          }
          break;
        case 'video_chat':
          console.log('==================video chat flag received=========', comm)
          switch (comm.payload) {
            case 'started_video':
              console.log('**************** Partner has initiated the call')
              // $('#publisherContainer').addClass('publisher-container')
              openTok.publishVideo = true
              break;
            case 'started_audio':
              console.log('**************** Partner has initiated the call')
              openTok.publishVideo = false
              // $('#publisherContainer').addClass('publisher-container')
              break;
            case 'cancelled':
              console.log("**************** Partner has cancelled ", comm)
              $('#publisherContainer').removeClass('publisher-container')
              $("#subscriberContainer").removeClass('hidden')
              openTok.unPublish()
              $('#init-video').removeClass('hidden')
              $('#init-audio').removeClass('hidden')
              $('#cancel-video').addClass('hidden')
              $("#flag-info-msg").html('Call is terminated by the host')
              setTimeout(function(){
                $("#flag-info-msg").html('')
                $('.video-chat-wrapper').addClass('hidden')
              }, 5000)
              break;
            case 'ready':
              console.log("**************** Partner is ready to connect *********", comm)
              if(!openTok.connected){
                $('#call-dialog').modal('show')
              }
              break;
            case 'partner_joined':
              console.log("**************** Partner has joined ******", comm)
              $("#flag-info-msg").html('')
              break;
            case 'call_rejected':
              console.log('**************** Partner has rejected the video call *****', comm)
              $('#cancel-video').click()
              $("#flag-info-msg").html('').text('Your partner has rejected the call. Please try later after contacting with him')
              setTimeout(function(){
                $("#flag-info-msg").html('')
              }, 10000)
              break;
            default:
              console.log('************************')
          }
        break;
        case 'error':
          console.log(data);
          break;
      }
    },
    // calls "create_chat_line" on the backend
    // The backend store the chat line to the DB, and broadcast it to all subscribers.
    create_chat_line: function create_chat_line(data) {
      this.perform('create_chat_line', data);
    },
    send_video_status_flag: function send_video_status_flag(data) {
      console.log('==================================', data)
      this.perform('send_video_status_flag', { type: 'candidate', payload: data });
    },
    // calls "setup_voice_chat" on the backend
    // data has the scheme of { type: ('sdp'|'candidate'), payload: Object }
    // Backend is just relaying metadata between the instructor and student
    // so they can setup a rtc connection
    // A stun server (see iceServers below) needs to be running to for setup.
    setup_voice_chat: function setup_voice_chat(data) {
      this.perform('setup_voice_chat', data);
    },
    // see https://www.html5rocks.com/en/tutorials/webrtc/basics/#simpleRTCPeerConnectionExample
    start_rtc_peer_conn: function start_rtc_peer_conn() {
      this.pc = new RTCPeerConnection({
        iceServers: [{
          urls: 'stun:stun.l.google.com:19302'
        }]
      });

      var pc = this.pc;

      this.logError = function (error) {
        console.log(error.name + ': ' + error.message);
      };

      this.localDescCreated = function (desc) {
        pc.setLocalDescription(desc, function () {
          this.setup_voice_chat({ type: 'sdp', payload: pc.localDescription });
        }, this.logError);
      };

      pc.onicecandidate = function (e) {
        if (e.candidate) {
          console.log("onicecandidate:", e.candidate);
          this.setup_voice_chat({ type: 'candidate', payload: e.candidate });
        }
      };

      pc.onnegotiationneeded = function () {
        console.log('onnegotiationneeded');
        pc.createOffer(this.localDescCreated, this.logError);
      };

      pc.onaddstream = function (e) {
        console.log("onaddstream:", e.stream);
        $('audio.remote')[0].src = URL.createObjectURL(e.stream);
      };

      // only audio is required in our case
      navigator.getUserMedia({ 'audio': true }, function (stream) {
        $('audio.local')[0].src = URL.createObjectURL(stream);
        pc.addStream(stream);
      }, this.logError);
    }
  });
});
