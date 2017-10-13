// .consult-comm is the high level container for the consult communication
// Currently it contains a .chat-box. It uses websocket (Channel in ROR terms) to
// communicates with the backend.
//
// This functions subscribs with the server backend "Channel" if there exists a
// .consult-comm in the page
$(document).on('turbolinks:load', function() {
  let $consult_comm = $('.consult-comm');
  if ($consult_comm.length == 0)
    return;
  let $chat = $consult_comm.find('.chat-box');
  let $chat_lines = $chat.find('.chat-lines');
  let user_id = $consult_comm.data('user-id');


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
    received: function(data) {
      let comm = data.comm_data;
      switch (data.type) {
        case 'chat_line':
          // when a chat_line data is received, append the content to the .chat_lines.
          // Content needs to be first sanitized to avoid arbitrary script injection
          if (comm) {
            let $chat_line = $(`<div class="chat-line"><pre>${sanitize(comm.content)}</pre></div>`);
            // put the chat-line to the right if it is a self post.
            if (user_id == comm.user_id)
              $chat_line.addClass('chat-line-right');
            // scroll to bottom when new chat-line is appended
            $chat_lines.append($chat_line).prop('scrollTop', $chat_lines.prop('scrollHeight'));
          }
          // re-enable submit button (disabled at submission)
          $('.chat-input input[type="submit"]').prop('disabled', false);
          break;
        case 'voice_chat':
          // code modified from https://www.html5rocks.com/en/tutorials/webrtc/basics/#simpleRTCPeerConnectionExample
          // including the "start_rtc_peer_conn" below
          if (!this.pc)
            this.start_rtc_peer_conn();
          switch (comm.type) {
            case 'sdp':
              console.log(`sdp received: ${comm.payload}`);
              this.pc.setRemoteDescription(new RTCSessionDescription(comm.payload), () => {
                if (this.pc.remoteDescription.type == 'offer')
                  this.pc.createAnswer(this.localDescCreated, this.logError);
              }, this.logError);
              break;
            case 'candidate':
              console.log(`candidated received: ${comm.payload}`);
              this.pc.addIceCandidate(new RTCIceCandidate(comm.payload));
              break;
            default:
              console.log('Unknown voice chat payload type: ' + comm.type);
          }
          break
        case 'error':
          console.log(comm.content);
          break;
      }
    },
    // calls "create_chat_line" on the backend
    // The backend store the chat line to the DB, and broadcast it to all subscribers.
    create_chat_line: function(data) {
      this.perform('create_chat_line', data);
    },
    // calls "setup_voice_chat" on the backend
    // data has the scheme of { type: ('sdp'|'candidate'), payload: Object }
    // Backend is just relaying metadata between the instructor and student
    // so they can setup a rtc connection
    // A stun server (see iceServers below) needs to be running to for setup.
    setup_voice_chat: function(data) {
      this.perform('setup_voice_chat', data);
    },
    // see https://www.html5rocks.com/en/tutorials/webrtc/basics/#simpleRTCPeerConnectionExample
    start_rtc_peer_conn: function() {
      this.pc = new RTCPeerConnection({
        iceServers: [{
          urls: 'stun:stun.l.google.com:19302'
        }]
      });

      let pc = this.pc;

      this.logError = (error) => {
        console.log(error.name + ': ' + error.message);
      };

      this.localDescCreated = (desc) => {
        pc.setLocalDescription(desc, () => {
          this.setup_voice_chat({type: 'sdp', payload: pc.localDescription});
        }, this.logError);
      };

      pc.onicecandidate = (e) => {
        if (e.candidate) {
          console.log(`onicecandidate: ${e.candidate}`);
          this.setup_voice_chat({type: 'candidate', payload: e.candidate});
        }
      };

      pc.onnegotiationneeded = () => {
        console.log(`onnegotiationneeded`);
        pc.createOffer(this.localDescCreated, this.logError);
      };

      pc.onaddstream = (e) => {
        console.log(`onaddstream: ${e.stream}`);
        $('audio.remote')[0].src = URL.createObjectURL(e.stream);
      };

      // only audio is required in our case
      navigator.getUserMedia({'audio': true}, function(stream) {
        $('audio.local')[0].src = URL.createObjectURL(stream);
        pc.addStream(stream);
      }, this.logError);
    }
  });
})
