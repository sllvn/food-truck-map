'use strict';

angular.module('foodTruckApp', ['foodTruckApp.controllers', 'ngResource'])

angular.element(document).ready(function () {
  window.map = L.map('map', {
    center: [40.7638333, -111.8902778],
    zoom: 15
  })
  window.map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"))

  map.locate({setView: true, maxZoom: 15});
  function onLocationFound(e) {
    L.marker(e.latlng).addTo(map);
  }
  map.on('locationfound', onLocationFound);
})
