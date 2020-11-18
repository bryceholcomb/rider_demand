$( document ).on('turbolinks:load', function() {
  mapboxgl.accessToken = 'pk.eyJ1IjoiYmhvbGNvbWIiLCJhIjoiRkliLWdBVSJ9.wz_RjKxc0iOUgc9Vb2ff3A';
  var map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/bholcomb/ckhm6e4iv0yxp19rqabe81eyz', // style URL
    center: {lat: 39.739, lon: -104.990}, // starting position [lng, lat]
    zoom: 11 // starting zoom
  });

  map.addControl(new mapboxgl.NavigationControl(), "bottom-right");

  var $cityId = $("select#event_city_id :selected").val();

  setCity(map, $cityId);
  $("#event_city_id").change(function() {
    removeNeighborhoods(map);
    zoomToNewCity(map);
  });
  $("#event_category_id").change(function() {
    getEvents(map);
  });
  $("#event_product_type").change(function() {
    removeNeighborhoods(map);
    addNeighborhoods(map);
  });
});
