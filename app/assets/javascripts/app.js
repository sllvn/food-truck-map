'use strict';

// Declare app level module which depends on filters, and services
angular.module('foodTruckApp', ['foodTruckApp.controllers', 'ngResource'])

angular.element(document).ready(function () {
  window.map = L.map('map', {
    center: [40.7608333, -111.8402778],
    zoom: 12
  })
  window.map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"))
})
