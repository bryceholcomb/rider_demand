function getEvents(map) {
  var $wheel = $("#spinning-wheel")
  var $cityId = $("select#event_city_id :selected").val();
  var $category = $("select#event_category_id :selected").val();
  $wheel.show();
  $.ajax({
    dataType: 'text',
    url: '/events.json',
    data: { city_id: $cityId, category_id: $category },
    success:function(events) {
      $wheel.hide();
      var geojson = {
        type: 'FeatureCollection',
        features: JSON.parse(events)
      };
      geojson.features.forEach(function(marker) {
        // create a HTML element for each feature
        var el = document.createElement('div');
        el.className = 'marker';

        // make a marker for each feature and add to the map
        new mapboxgl.Marker({color: "#00607d", symbol: "circle", size: "medium"})
          .setLngLat(marker.geometry.coordinates)
          .setPopup(new mapboxgl.Popup({ offset: 25 }) // add popups
            .setHTML(
              '<div class="event-popup"><h3>' + marker.properties.title + '</h3><p>' + marker.properties.description + '</p></div>')
            )
          .addTo(map);
      });
      appendSidebarEvents(JSON.parse(events), map);
    },
    error:function() {
      $wheel.hide();
      alert("There are no events today for that category. Please select another category.");
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

function openPopupFromSidebar(map, clickedObject) {
  var clickedTitle = clickedObject.find("h4").text();
  map.featureLayer.eachLayer(function(marker) {
    if (marker.feature.properties.title === clickedTitle) {
      var id = marker._leaflet_id
      map._layers[id].openPopup();
    }
  });
};
