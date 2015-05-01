$(document).on("ready", function() {
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmhvbGNvbWIiLCJhIjoiRkliLWdBVSJ9.wz_RjKxc0iOUgc9Vb2ff3A';
  var map = L.mapbox.map('map', 'bholcomb.lc7kd3m2', { zoomControl: false })
  .setView([39.739, -104.990], 12);

  map.scrollWheelZoom.disable();

  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);

  map.featureLayer.on("ready", function(e) {
    var $city = $("select#event_city_id").children(":selected").text();
    setCity(map, $city);
    addEventPopups(map);
    $("#event_city_id").change(function() {
      map.removeLayer(geojson);
      zoomToNewCity(map);
    });
    $("#event_category_id").change(function() {
      getEvents(map);
    });
    $("#event_product_type").change(function() {
      map.removeLayer(geojson);
      addNeighborhoods(map);
    });
    info.addTo(map);
    legend.addTo(map);
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
      var geojson = $.parseJSON(events)["events"];
      map.featureLayer.setGeoJSON({
        type: "FeatureCollection",
        features: geojson
      });
      appendSidebarEvents(geojson, map);
      addEventPopups(map);
    },
    error:function() {
      $wheel.hide();
      alert("There are no events today for that category. Please select another category.");
    }
  });
};

function addEventPopups(map) {
  map.featureLayer.on("layeradd", function(e){
    var marker = e.layer;
    var properties = marker.feature.properties;
    var popupContent = '<div class="event-popup">' + '<img src=' + properties.image + '>' + '<h3>' +
      properties.title + '</h3>' + '<h4>' + properties.time + '</h4>' + '<h4>' + properties.date + '</h4>' +
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
      addNeighborhoods(map);
    }
  });
};

function appendSidebarEvents(events, map) {
  $(".events").children("a").remove();
  events.forEach(function(event) {
    $(".events").append("<a href='#', class='event-link'><div id='event-item' class='predictor-event'><div class='event-text'><h4 id='title'></h4><p id='time'></p><p id='date'></p><p id='venue'></p></div></div></a>");
    $(".events").children("a:last").find("#title").text(event.properties.title);
    $(".events").children("a:last").find("#time").text(event.properties.time);
    $(".events").children("a:last").find("#venue").text(event.properties.venue);
    $(".events").children("a:last").find("#date").text(event.properties.date);
  });
  $(".event-link").click(function() {
    var currentEvent = $(this);
    openPopupFromSidebar(map, currentEvent)
  });
};

var geojson;

function addNeighborhoods(map) {
  var $product = $("select#event_product_type").children(":selected").text();
  var $city = $("select#event_city_id").children(":selected").text();
  $.ajax({
    url: '/neighborhoods.json',
    data: {city: $city, product: $product},
    success:function(neighborhoods) {
      geojson = L.geoJson(neighborhoods["neighborhoods"], {
        style: style,
        onEachFeature: onEachFeature
      }).addTo(map);
    }
  });
};

function getColor(eta) {
  return eta > 3000 ? '#b10026' :
    eta > 2500  ? '#e31a1c' :
    eta > 2000  ? '#fc4e2a' :
    eta > 1500  ? '#fd8d3c' :
    eta > 1000  ? '#feb24c' :
    eta > 500   ? '#fed976' :
    '#ffffb2';
};

function style(feature) {
  return {
    fillColor: getColor(feature.properties.eta),
    weight: 2,
    opacity: 1,
    color: 'white',
    dashArray: '3',
    fillOpacity: 0.7
  }
};

function highlightFeature(e) {
  var layer = e.target;

  layer.setStyle({
    weight: 5,
    color: '#666',
    dashArray: '',
    fillOpacity: 0.7
  });

  info.update(layer.feature.properties);

  if (!L.Browser.ie && !L.Browser.opera) {
    layer.bringToFront();
  }
};

function resetHighlight(e) {
  geojson.resetStyle(e.target);
  info.update();
};

function zoomToFeature(e) {
  map.fitBounds(e.target.getBounds());
};

function onEachFeature(feature, layer) {
  layer.on({
    mouseover: highlightFeature,
    mouseout: resetHighlight,
    click: zoomToFeature
  });
};

var info = L.control();

info.onAdd = function (map) {
  this._div = L.DomUtil.create('div', 'info');
  this.update();
  return this._div;
};

info.update = function (props) {
  this._div.innerHTML = '<h4>Current Uber ETA Time</h4>' + (props ? '<b>' + props.name + '</b><br />' + (props.eta / 100) + ' minutes'
    : 'Hover over a neighborhood');
};

var legend = L.control({position: 'bottomright'});

legend.onAdd = function (map) {

  var div = L.DomUtil.create('div', 'info legend'),
  grades = [0, 500, 1000, 1500, 2000, 2500, 3000],
  labels = [];

  for (var i = 0; i < grades.length; i++) {
    div.innerHTML +=
      '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
      (grades[i] / 100) + ((grades[i + 1] / 100) ? ' &ndash; ' + (grades[i + 1] / 100) + '<br>' : '+');
  }

  return div;
};
