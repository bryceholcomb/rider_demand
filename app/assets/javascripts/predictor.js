$(document).on("ready", function() {
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmhvbGNvbWIiLCJhIjoiRkliLWdBVSJ9.wz_RjKxc0iOUgc9Vb2ff3A';
  var map = L.mapbox.map('map', 'bholcomb.lc7kd3m2', { zoomControl: false })
  .setView([39.739, -104.990], 13);

  map.scrollWheelZoom.disable();

  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);

  map.featureLayer.on("ready", function(e) {
    var $city = $("select#event_city_id").children(":selected").text();
    setCity(map, $city);
    addEventPopups(map);
    $("#event_city_id").change(function() {
      zoomToNewCity(map);
    });
    $("#event_category_id").change(function() {
      getEvents(map);
    });
  });
});

function getEvents(map) {
  var $wheel = $("#spinning-wheel")
  var $city = $("select#event_city_id").children(":selected").text();
  var $category = $("select#event_category_id").children(":selected").val();
  $wheel.show();
  $.ajax({
    dataType: 'text',
    url: '/events.json',
    data: { city: $city, category_id: $category },
    success:function(events) {
      $wheel.hide();
      var geojson = $.parseJSON(events);
      map.featureLayer.setGeoJSON({
        type: "FeatureCollection",
        features: geojson
      });
      appendSidebarEvents(geojson, map);
      addEventPopups(map);
    },
    error:function() {
      alert("Could not load the events");
    }
  });
};

function addEventPopups(map) {
  map.featureLayer.on("layeradd", function(e){
    var marker = e.layer;
    var properties = marker.feature.properties;
    var popupContent = '<div class="event-popup">' + '<img src=' + properties.image + '>' + '<h3>' +
      properties.title + '</h3>' + '<h4>' + properties.time + '</h4>' +
      '<h4>' + properties.venue + '</h4>' + '<h4>' + properties.address + '</h4>' + '</div>';
    marker.bindPopup(popupContent, {closeButton: false, minWidth: 300});
  });
};

function openPopupFromSidebar(map, clickedObject) {
  var clickedTitle = clickedObject.find("h4").text();
  map.featureLayer.eachLayer(function(marker) {
    if (marker.feature.properties.title === clickedTitle) {
      var id = marker._leaflet_id
      map._layers[id].openPopup();
    }
  });
};

function zoomToNewCity(map) {
  var $city = $("select#event_city_id").children(":selected").text();
  setCity(map, $city);
};

function setCity(map, city) {
  $.ajax({
    url: '/cities.json',
    data: city,
    success:function(city) {
      map.setView([city.latitude, city.longitude], 13)
      getEvents(map);
    }
  });
};

function appendSidebarEvents(events, map) {
  $(".events").children("a").remove();
  events.forEach(function(event) {
    $(".events").append("<a href='#', class='event-link'><div id='event-item' class='predictor-event'><div class='event-text'><h4 id='title'></h4><p id='time'></p><p id='venue'></p></div><div class='chevron-pointer'><i class='fa fa-chevron-right'></i></div></div></a>");
    $(".events").children("a:last").find("#title").text(event.properties.title);
    $(".events").children("a:last").find("#time").text(event.properties.time);
    $(".events").children("a:last").find("#venue").text(event.properties.venue);
  });
  $(".event-link").click(function() {
    var currentEvent = $(this);
    openPopupFromSidebar(map, currentEvent)
  });
};
