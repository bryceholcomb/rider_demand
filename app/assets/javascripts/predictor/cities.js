function zoomToNewCity(map) {
  var $cityId = $("select#event_city_id :selected").val();
  setCity(map, $cityId);
};

function setCity(map, cityId) {
  $.ajax({
    url: '/cities.json',
    data: {city_id: cityId},
    success:function(city) {
      map.setCenter({lat: city.latitude, lon: city.longitude}, 11)
      getEvents(map);
      addNeighborhoods(map);
    }
  });
};

