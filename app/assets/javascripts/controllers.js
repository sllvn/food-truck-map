'use strict';

var foodTruckApp = angular.module('foodTruckApp.controllers', []);

// TODO: move to services
foodTruckApp.factory('currentLocationService', function($rootScope) {
  var currentLocation = {};
  currentLocation.latlng = "";

  currentLocation.broadcast = function(latlng) {
    this.latlng = latlng;
    $rootScope.$broadcast('currentLocationChanged');
  };

  return currentLocation;
});

foodTruckApp.controller('FoodTrucksController', function($scope, $resource, $http, currentLocationService) {
  $scope.showTruck = function(truck) {
    var marker = L.marker([truck.location.latitude, truck.location.longitude]).addTo(window.map);
    var popupContent = "<h3>" + truck.name + "</h3>";
    marker.bindPopup(popupContent);
  }

  var Truck = $resource('/food_businesses/:foodBusinessId', { truckId: '@id' });

  $scope.trucks = Truck.query(function() {
    console.log(this);
    angular.forEach($scope.trucks, function(truck) {
      console.log(truck);
    });
  });


  $scope.checkInAddress = "";

  $scope.$on('currentLocationChanged', function() {
    $scope.checkInAddress = currentLocationService.latlng.lat + ", " + currentLocationService.latlng.lng;
    $scope.$apply();
  });
});

foodTruckApp.controller('MapController', function($scope, currentLocationService) {
  $scope.map = L.map('map', {
    center: [40.7638333, -111.8902778],
    zoom: 15
  })
  $scope.map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"))

  $scope.currentLocationMarker = L.marker();
  $scope.currentLocationMarker.options.draggable = true;

  $scope.map.locate({ setView: true, maxZoom: 15 });

  $scope.onLocationFound = function(e) {
    currentLocationService.broadcast(e.latlng);
  }
  $scope.map.on('locationfound', $scope.onLocationFound);

  $scope.onCurrentLocationChanged = function(e) {
    currentLocationService.broadcast(e.target._latlng);
  };
  $scope.currentLocationMarker.on('dragend', $scope.onCurrentLocationChanged);

  $scope.$on('currentLocationChanged', function() {
    $scope.currentLocationMarker.setLatLng(currentLocationService.latlng);
    $scope.currentLocationMarker.addTo($scope.map);
  });
});

