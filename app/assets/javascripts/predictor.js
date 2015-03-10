$(document).on("ready", function() {
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmhvbGNvbWIiLCJhIjoiRkliLWdBVSJ9.wz_RjKxc0iOUgc9Vb2ff3A';
  var map = L.mapbox.map('map', 'bholcomb.lc7kd3m2', { zoomControl: false })
  .setView([39.739, -104.990], 13);

  map.scrollWheelZoom.disable();

  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);

  map.featureLayer.on("ready", function(e) {
    var $city = $("select option:selected").text();
    setCity(map, $city)
    addEventPopups(map);
    $("#event_city_id").change(function() {
      zoomToNewCity(map)
    });
  });
});

var setCity = function(map, city) {
  $.ajax({
    url: '/cities.json',
    data: city,
    success:function(city) {
      map.setView([city.latitude, city.longitude], 13)
    }
  });
  getEvents(map, city);
};

var getEvents = function(map, city) {
  $.ajax({
    dataType: 'text',
    url: '/events.json',
    data: city,
    success:function(events) {
      var geojson = $.parseJSON(events);
      map.featureLayer.setGeoJSON({
        type: "FeatureCollection",
        features: geojson
      });
      appendSidebarEvents(geojson);
      addEventPopups(map);
    }
  });
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

//var openPopupFromSidebar = function(map) {
  //var currentEvent = $(this);
  //var clickedTitle = currentEvent.find("h4").text();
  //map.featureLayer.eachLayer(function(marker) {
    //if (marker.feature.properties.title === clickedTitle) {
      //var id = marker._leaflet_id
      //map._layers[id].openPopup();
    //}
  //});
//};

var zoomToNewCity = function(map) {
  var $city = $("select option:selected").text();
  $.ajax({
    url: '/cities.json',
    data: $city,
    success:function(city) {
      map.setView([city.latitude, city.longitude], 13)
    }
  });
  getEvents(map, $city);
};

var appendSidebarEvents = function(events) {
  $(".events").children("a").remove();
  events.forEach(function(event) {
    $(".events").append("<div id='event-item' class='predictor-event'><h4 id='title'></h4><p id='time'></p><p id='venue'></p></div><div class='chevron-pointer'><i class='fa fa-chevron-right'></i></div>");
    $(".events").children(".predictor-event:last").find("#title").text(event.properties.title);
    $(".events").children(".predictor-event:last").find("#time").text(event.properties.time);
    $(".events").children(".predictor-event:last").find("#venue").text(event.properties.venue);
  });
};
