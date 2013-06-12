'use strict';

var foodTruckApp = angular.module('foodTruckApp.controllers', []);

foodTruckApp.controller('FoodTrucksController', function($scope, $resource, currentLocationService, foodTruckService) {
  $scope.showTruck = function(truck) {
    var marker = L.marker([truck.location.latitude, truck.location.longitude]).addTo(window.map);
    var popupContent = "<h3>" + truck.name + "</h3>";
    marker.bindPopup(popupContent);
  }

  $scope.trucks = foodTruckService.getTrucks();
//  $scope.trucks.then(
//    function(truck) {
//      console.log(truck);
//    },
//    function(response) {
//      console.log(response);
//    }
//  );

  $scope.checkInAddress = "";

  $scope.$on('currentLocationChanged', function() {
    $scope.checkInAddress = currentLocationService.latlng.lat + ", " + currentLocationService.latlng.lng;
    $scope.$apply();
  });
});

foodTruckApp.controller('MapController', function($scope, currentLocationService, foodTruckService) {
  $scope.map = L.map('map', {
    center: [40.7638333, -111.8902778],
    zoom: 15,
    minZoom: 12,
    maxZoom: 16
  });
  $scope.map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"));
  window.map = $scope.map;

  $scope.currentLocationMarker = L.marker();
  $scope.currentLocationMarker.options.draggable = true;

  $scope.map.locate({ setView: true, maxZoom: 15 });

  $scope.onLocationFound = function(e) {
    currentLocationService.broadcast(e.latlng);
  };
  $scope.map.on('locationfound', $scope.onLocationFound);

  $scope.onCurrentLocationChanged = function(e) {
    currentLocationService.broadcast(e.target._latlng);
  };
  $scope.currentLocationMarker.on('dragend', $scope.onCurrentLocationChanged);

  $scope.$on('currentLocationChanged', function() {
    $scope.currentLocationMarker.setLatLng(currentLocationService.latlng);
    $scope.currentLocationMarker.addTo($scope.map);
  });

  $scope.markers = []; // TODO: put markers[] into trucks[] or tie them together somehow?
  $scope.trucks = foodTruckService.getTrucks();
  $scope.trucks.then(
    function(trucks) {
      angular.forEach(trucks, function(truck) {
        var marker = L.marker([truck.location.latitude, truck.location.longitude]).addTo($scope.map);
        $scope.markers.push(marker);
      });
    }
  );
});

