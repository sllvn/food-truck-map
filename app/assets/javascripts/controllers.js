'use strict';

var truckMarker = L.AwesomeMarkers.icon({
  icon: 'truck',
  color: 'green'
});
var standMarker = L.AwesomeMarkers.icon({
  icon: 'food',
  color: 'purple'
});
var currentLocationMarker = L.AwesomeMarkers.icon({
  icon: 'star',
  color: 'blue'
});

var foodTruckApp = angular.module('foodTruckApp.controllers, foodTruckApp.filters', []);

foodTruckApp.controller('FoodTrucksController', function ($scope, $resource, currentLocationService, foodTruckService, broadcastService) {
  $scope.activeTrucks = foodTruckService.getActiveTrucks();

  $scope.showTruck = function (truck) {
    broadcastService.broadcast('showTruckPopup', { truck: truck });
  }

  $scope.distances = [
    { display_text: "Within 1/2 mile", min: 0, max: 0.5 },
    { display_text: "Within 1 mile", min: 0.5, max: 1 },
    { display_text: "Within 2 miles", min: 1, max: 2 },
    { display_text: "Within 5 miles", min: 2, max: 5 },
    { display_text: "Beyond", min: 5, max: 100 },
  ];

  $scope.setDistancesFromLocation = function (currentLatLng) {
    // TODO: what happens if current location loads before trucks?
    angular.forEach($scope.activeTrucks, function (truck) {
      truck.distance = currentLatLng.distanceTo(new L.LatLng(truck.location.latitude, truck.location.longitude));
    });
  };

  $scope.checkInAddress = "";
  $scope.$on('currentLocationChanged', function () {
    $scope.checkInAddress = currentLocationService.latlng.lat + ", " + currentLocationService.latlng.lng;
    $scope.setDistancesFromLocation(currentLocationService.latlng);
    $scope.$apply();
  });
});

foodTruckApp.controller('MapController', function ($scope, $compile, currentLocationService, foodTruckService, broadcastService) {
  $scope.map = L.map('map', {
    center: [40.7638333, -111.8902778],
    zoom: 15,
    minZoom: 12,
    maxZoom: 16
  });
  $scope.map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"));

  $scope.markers = []; // TODO: put markers[] into trucks[] or tie them together somehow?
  $scope.activeTrucks = foodTruckService.getActiveTrucks();

  $scope.$on('trucksFinishedLoading', function () {
    angular.forEach($scope.activeTrucks, function (truck, iterator) {
      var marker = L.marker([truck.location.latitude, truck.location.longitude]);
      marker.options.icon = truck.type == "truck" ? truckMarker : standMarker;
      marker.truckId = truck.id;
      marker.addTo($scope.map);

      // TODO: refactoring candidate, truck="trucks[' + iterator + ']"  is ugly, is there a better way to reference correct truck?
      var popup = marker.bindPopup('<food-truck-popup truck="activeTrucks[' + iterator + ']"/>', { minWidth: 300, maxWidth: 300 });
      $scope.markers.push(marker);
    });
  });


  $scope.$on('showTruckPopup', function () {
    var truck = broadcastService.message.truck;
    angular.forEach($scope.markers, function (marker) {
      if (marker.truckId == truck.id) {
        marker.openPopup();
      }
    });
  });

  $scope.map.on('popupopen', function (e) {
    var popup = angular.element('.leaflet-popup-content');
    $compile(popup)($scope);
    if (!$scope.$$phase) $scope.$digest();
  });

  // TODO: abstract all this into locationService
  // ideally something like:
  // $scope.currentLocation = locationService.currentLocation
  // which has attribute 'marker' or maybe it's just a separate attribute from locationService
  $scope.currentLocationMarker = L.marker();
  $scope.currentLocationMarker.options.icon = currentLocationMarker;
  $scope.currentLocationMarker.options.draggable = true;

  $scope.map.locate({ setView: true, maxZoom: 15 });

  $scope.onLocationFound = function (e) {
    currentLocationService.broadcast(e.latlng);
  };
  $scope.map.on('locationfound', $scope.onLocationFound);

  $scope.onCurrentLocationChanged = function (e) {
    currentLocationService.broadcast(e.target._latlng);
  };
  $scope.currentLocationMarker.on('dragend', $scope.onCurrentLocationChanged);

  $scope.$on('currentLocationChanged', function () {
    $scope.currentLocationMarker.setLatLng(currentLocationService.latlng);
    $scope.currentLocationMarker.addTo($scope.map);
  });
});

