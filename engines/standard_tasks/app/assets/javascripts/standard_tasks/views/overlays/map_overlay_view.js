ETahi.MapOverlayView = ETahi.OverlayView.extend({
  templateName: "standard_tasks/overlays/map_overlay",
  layoutName: "layouts/overlay_layout",

  loadMap: function() {
    function initializeMap() {
      var mapOptions = {
        zoom: 8,
        center: new google.maps.LatLng(-34.397, 150.644)
      };

      var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

      var infoContent = $.parseHTML("<div><input class='annotation'></input><button class='save-annotation button-primary button--green'>Save</button></div>");
      $(infoContent).find('.save-annotation').on('click', function(event) { console.log("foo"); });
      var info = new google.maps.InfoWindow({content: infoContent[0]});

      function placeMarker(location) {
        var marker = new google.maps.Marker({
          position: location,
          map: map
        });

        map.setCenter(location);
        info.open(map, marker)
      }

      google.maps.event.addListener(map, 'click', function(event) {
        placeMarker(event.latLng);
      });
    };


    window.initializeMap = initializeMap;
    function loadScript() {
      var script = document.createElement('script');
      script.type = 'text/javascript';
      script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&' +
      'callback=initializeMap' + '&sensor=false&key=AIzaSyCZHA3rPBtGqIkA-9JHtsQPdDliD4cnjzk';
      document.body.appendChild(script);
    }
    loadScript();
  }.on('didInsertElement')
});
