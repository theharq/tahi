ETahi.VideoCardOverlayView=ETahi.OverlayView.extend({
  templateName: 'overlays/video_card_overlay',
  layoutName: 'layouts/overlay_layout',

  loadScript: function() {
    var self = this;
    $.getScript('https://api.bistri.com/bistri.conference.min.js').then(function() {
      // Ugh, give the browser some time to parse?
      Em.run.later(function() { self.setup(); }, 1000);
    });
  }.on('didInsertElement'),

  room: 'myMeetingRoom',
  localStreamReady: false,

  joinRoom: function () {
    // if the local stream (webcam) is ready
    if (!this.get('localStreamReady')) {
      alert('local media is not ready');
      return;
    }

    BistriConference.joinRoom(this.get('room'));
  },

  quitRoom: function () {
    var room = this.get('room');
    BistriConference.endCalls(room);
    BistriConference.quitRoom(room);
  },

  setup: function() {
    var self = this;
    this.set('localStreamReady', false);

    BistriConference.init({
      appId: "840a2305",
      appKey: "77d872c20ec4eeffaad5d5191704d82b",
      debug: true
    });

    /*
     * we add a handler to manage "onConnected" event triggered by the signaling server
     * this event occurs when user is connected to the signaling server
     */
    BistriConference.signaling.addHandler("onConnected", function () {
      // we are now connected to the signaling server, 
      // we can request access to the user webcam
      BistriConference.startStream("webcamSD",function(localStream){
        this.get('localStreamReady', true);

        var node = self.$('.video-container');

        // we "insert" the local video stream into a container
        BistriConference.attachStream(localStream, node.get(0), {
            // video auto start after being inserted
            autoplay: true,
            // video switch to fullscreen when user click on it
            fullscreen: true
        });
      });
    });

    /*
     * we add a handler to manage "onJoinedRoom" event triggered by the signaling server
     * this event occurs when user join the conference room
     */
    BistriConference.signaling.addHandler("onJoinedRoom", function (result) {
        // we entered the conference room.
        // we request a call start with every single member already present in the room
        var roomMembers = result.members;
        for (var i = 0; i < roomMembers.length; i++) {
            BistriConference.call(roomMembers[i].id,room);
        }

        // we hide "Join Conference" button
        document.querySelector(".join").style.display = "none";

        //  and show "Quit Conference" button
        document.querySelector(".quit").style.display = "inline";
    });

    /*
     * we add a handler to manage "onJoinRoomError" event triggered by the signaling server
     * this event occurs when user fails to join the conference room
     */
    BistriConference.signaling.addHandler("onJoinRoomError", function (error) {
        // we can't handle more than 4 participants in a same room (for performance issue) 
       alert(error.text+" ("+error.code+")" );
    });

    /*
     * we add a handler to manage "onQuittedRoom" event triggered by the signaling server
     * this event occurs when user has quitted the conference room
     */
    BistriConference.signaling.addHandler("onQuittedRoom", function (data) {
        // we hide "Quit Conference" button
        document.querySelector(".quit").style.display = "none";

        // and we show "Join Conference" button
        document.querySelector(".join").style.display = "inline";

    });

    /*
     * we add a handler to manage "onStreamAdded" event triggered by the stream manager
     * this event occurs when a local or remote video stream is received
     */
    BistriConference.streams.addHandler("onStreamAdded", function (remoteStream, pid) {
      var node = document.querySelector('.video-container');

      // we "insert" the video stream into a container
      BistriConference.attachStream(remoteStream, node, {
          // video auto start after being inserted
          autoplay: true,
          // video switch to fullscreen when user click on it
          fullscreen: true
      });
    });

    /*
     * we add a handler to manage "onStreamClosed" event triggered by the stream manager
     * this event occurs when a local or remote stream is closed
     */
    BistriConference.streams.addHandler("onStreamClosed", function (remoteStream, pid) {
      BistriConference.detachStream(remoteStream);
    });

    BistriConference.connect();
  },

  actions: {
    joinRoom: function() { this.joinRoom(); },
    quitRoom: function() { this.quitRoom(); }
  }
});
