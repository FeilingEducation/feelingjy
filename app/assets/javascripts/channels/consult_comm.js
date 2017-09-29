$(document).on('turbolinks:load', function() {
  let $consult_comm = $('.consult-comm');
  if ($consult_comm.length == 0)
    return;
  let $chat = $consult_comm.find('.chat-box');
  let $chat_lines = $chat.find('.chat-lines');
  $chat_lines.prop('scrollTop', $chat_lines.prop('scrollHeight'));
  let user_id = $consult_comm.data('user-id');


  App.consult_comm = App.cable.subscriptions.create({
    channel: 'ConsultCommChannel',
    transaction_id: $consult_comm.data('transaction-id')
  }, {
    received: function(data) {
      let comm = data.comm_data;
      switch (data.type) {
        case 'chat_line':
          let $chat_line = $(`<div><pre>${sanitize(comm.content)}</pre></div>`);
          if (user_id == data.user_id)
            $chat_line.addClass('my-chat-line');
          $chat_lines.append($chat_line).prop('scrollTop', $chat_lines.prop('scrollHeight'));
          $('.chat-input input[type="submit"]').prop('disabled', false);
          break;
        case 'voice_chat':
          console.log(`got voice_chat: ${comm}`);
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
    create_chat_line: function(data) {
      this.perform('create_chat_line', data);
    },
    setup_voice_chat: function(data) {
      this.perform('setup_voice_chat', data);
    },
    start_rtc_peer_conn: function() {
      this.pc = new RTCPeerConnection({
        iceServers: [{
          urls: 'stun:feelingjy.me:3478'
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

      navigator.getUserMedia({'audio': true}, function(stream) {
        $('audio.local')[0].src = URL.createObjectURL(stream);
        pc.addStream(stream);
      }, this.logError);
    }
  });
})
