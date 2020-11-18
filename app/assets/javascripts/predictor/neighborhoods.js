function addNeighborhoods(map) {
  var $product = $("select#event_product_type").children(":selected").text();
  var $cityId = $("select#event_city_id :selected").val();
  $.ajax({
    url: '/neighborhoods.json',
    data: {city_id: $cityId, product: $product},
    success:function(neighborhoods) {
      map.addSource('neighborhoods', {
        type: "geojson",
        data: {
          type: "FeatureCollection",
          features: neighborhoods
        },
        generateId: true
      });

      map.addLayer({
        'id': 'neighborhood-fills',
        'type': 'fill',
        'source': 'neighborhoods',
        'layout': {},
        'paint': {
          'fill-color': [
            'interpolate',
            ['linear'],
            ['get', 'eta'],
            0,
            '#ffffb2',
            500,
            '#fed976',
            1000,
            '#feb24c',
            1500,
            '#fd8d3c',
            2000,
            '#fc4e2a',
            2500,
            '#e31a1c',
            3000,
            '#b10026'
          ],
          'fill-opacity': [
            'case',
            ['boolean', ['feature-state', 'hover'], false],
            0.7,
            1,
          ]
        }
      });

      var hoveredStateId = null
      map.on('mousemove', 'neighborhood-fills', function (e) {
        // TODO Reset the info box
        if (e.features.length > 0) {
          if (hoveredStateId) {
            map.setFeatureState(
              { source: 'neighborhoods', id: hoveredStateId },
              { hover: false }
            );
          }
          hoveredStateId = e.features[0].id;
          map.setFeatureState(
            { source: 'neighborhoods', id: hoveredStateId },
            { hover: true }
          );
        }
      });

      // When the mouse leaves the state-fill layer, update the feature state of the
      // previously hovered feature.
      map.on('mouseleave', 'neighborhood-fills', function () {
        // TODO Reset the info box
        if (hoveredStateId) {
          map.setFeatureState(
            { source: 'neighborhoods', id: hoveredStateId },
            { hover: false }
          );
        }
        hoveredStateId = null;
      });
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

function removeNeighborhoods(map) {
  map.removeLayer('neighborhood-fills');
  map.removeSource('neighborhoods');
}
