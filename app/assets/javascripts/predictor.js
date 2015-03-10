$(document).on("ready", function() {
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmhvbGNvbWIiLCJhIjoiRkliLWdBVSJ9.wz_RjKxc0iOUgc9Vb2ff3A';
  var map = L.mapbox.map('map', 'bholcomb.lc7kd3m2', { zoomControl: false })
  .setView([39.739, -104.990], 13);

  map.scrollWheelZoom.disable();

  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);

  map.featureLayer.on("ready", function(e) {
    getEvents(map);
    addEventPopups(map);
    openPopupFromSidebar(map);
  });

  zoomToCity(map);

});

var getEvents = function(map) {
  $.ajax({
    dataType: 'text',
    url: '/events',
    success:function(data) {
      var geojson = $.parseJSON(data);
      map.featureLayer.setGeoJSON({
        type: "FeatureCollection",
        features: geojson
      });
    }
  });
  return false;
};

var addEventPopups = function(map) {
  map.featureLayer.on("layeradd", function(e){
    var marker = e.layer;
    var properties = marker.feature.properties;
    var popupContent = '<div class="event-popup">' + '<h3>' +
      properties.title + '</h3>' + '<h4>' + properties.time + '</h4>' +
      '<h4>' + properties.venue + '</h4>' + '<h4>' + properties.address + '</h4>' + '</div>';
    marker.bindPopup(popupContent, {closeButton: false, minWidth: 300});
  });
};

var openPopupFromSidebar = function(map) {
  $(".predictor-event").click(function(event) {
    var currentEvent = $(this);
    var clickedTitle = currentEvent.find("h4").text();
    map.featureLayer.eachLayer(function(marker) {
      if (marker.feature.properties.title === clickedTitle) {
        var id = marker._leaflet_id
        map._layers[id].openPopup();
      }
    });
  });
};

var zoomToCity = function(map) {
  $("#event_city_id").change(function(city) {
    var $city = $("select option:selected").text();
    $.ajax({
      url: '/city.json',
      data: $city,
      success:function(city) {
        map.setView([city.latitude, city.longitude], 13)
      }
    });
  });
};
