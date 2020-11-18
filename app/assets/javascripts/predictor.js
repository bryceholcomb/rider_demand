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
  //info.addTo(map);
  //legend.addTo(map);
});

//var info = L.control();

//info.onAdd = function (map) {
  //this._div = L.DomUtil.create('div', 'info');
  //this.update();
  //return this._div;
//};

//info.update = function (props) {
  //this._div.innerHTML = '<h4>Current Uber ETA Time</h4>' + (props ? '<b>' + props.name + '</b><br />' + (props.eta / 100) + ' minutes'
    //: 'Hover over a neighborhood');
//};

//var legend = L.control({position: 'bottomright'});

//legend.onAdd = function (map) {

  //var div = L.DomUtil.create('div', 'info legend'),
  //grades = [0, 500, 1000, 1500, 2000, 2500, 3000],
  //labels = [];

  //for (var i = 0; i < grades.length; i++) {
    //div.innerHTML +=
      //'<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
      //(grades[i] / 100) + ((grades[i + 1] / 100) ? ' &ndash; ' + (grades[i + 1] / 100) + '<br>' : '+');
  //}

  //return div;
//};
