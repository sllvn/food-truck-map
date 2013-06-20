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

foodTruckApp.controller('FoodTrucksController', ['$scope', '$resource', '$compile', '$filter', 'foodTruckService', function ($scope, $resource, $compile, $filter, foodTruckService) {
  $scope.activeTrucks = foodTruckService.getActiveTrucks();

  $scope.showTruck = function (truck) {
    angular.forEach($scope.markers, function (marker) {
      if (marker.truckId == truck.id) {
        marker.openPopup();
      }
    });
  }

  $scope.$watch('searchText', function () {
    var filteredTrucks = $filter('filter')($scope.activeTrucks, $scope.searchText);
    removeAllMarkersFromMap();
    addTrucksToMap(filteredTrucks);
  });

  $scope.distances = [
    { display_text: "Within 1/2 mile", min: 0, max: 0.5 },
    { display_text: "Within 1 mile", min: 0.5, max: 1 },
    { display_text: "Within 2 miles", min: 1, max: 2 },
    { display_text: "Within 5 miles", min: 2, max: 5 },
    { display_text: "Beyond", min: 5, max: 100 },
  ];

  $scope.setDistancesFromLocation = function (currentLatLng) {
    angular.forEach($scope.activeTrucks, function (truck) {
      truck.distance = currentLatLng.distanceTo(new L.LatLng(truck.location.latitude, truck.location.longitude));
    });
  };

  // TODO: move map methods into service
  $scope.map = L.map('map', {
    center: [40.7638333, -111.8902778],
    zoom: 15,
    minZoom: 13,
    maxZoom: 16
  });
  $scope.map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"));

  $scope.markers = [];
  $scope.activeTrucks = foodTruckService.getActiveTrucks();

  var removeAllMarkersFromMap = function () {
    angular.forEach($scope.markers, function (marker) {
      $scope.map.removeLayer(marker);
    });
  };

  $scope.$on('trucksFinishedLoading', function () {
    if($scope.currentLocationMarker.getLatLng()) {
      // if current location loaded first
      $scope.setDistancesFromLocation($scope.currentLocationMarker.getLatLng());
    }

    addTrucksToMap($scope.activeTrucks);
  });

  var addTrucksToMap = function (trucks) {
    angular.forEach(trucks, function (truck, iterator) {
      var marker = L.marker([truck.location.latitude, truck.location.longitude]);
      marker.options.icon = truck.type == "truck" ? truckMarker : standMarker;
      marker.truckId = truck.id;
      marker.addTo($scope.map);

      // TODO: refactoring candidate, truck="trucks[' + iterator + ']"  is ugly, is there a better way to reference correct truck?
      var popup = marker.bindPopup('<food-truck-popup truck="activeTrucks[' + iterator + ']"/>', { minWidth: 300, maxWidth: 300 });
      $scope.markers.push(marker);
    });
  }

  $scope.map.on('popupopen', function (e) {
    var popup = angular.element('.leaflet-popup-content');
    $compile(popup)($scope);
    if (!$scope.$$phase) $scope.$digest();
  });

  $scope.currentLocationMarker = L.marker();
  $scope.currentLocationMarker.options.icon = currentLocationMarker;

  $scope.currentLocationMarker.options.draggable = false;
  $scope.enableCheckin = function () {
    $scope.currentLocationMarker.options.draggable = true;
  };

  $scope.map.locate({ setView: true, maxZoom: 15 });

  $scope.onLocationFound = function (e) {
    $scope.currentLocationMarker.setLatLng(e.latlng);
    $scope.currentLocationMarker.addTo($scope.map);
    $scope.currentLocationChanged();
  };
  $scope.map.on('locationfound', $scope.onLocationFound);

  $scope.checkInAddress = "";
  $scope.currentLocationChanged = function () {
    $scope.checkInAddress = $scope.currentLocationMarker.getLatLng().lat + ", " + $scope.currentLocationMarker.getLatLng().lng;
    $scope.setDistancesFromLocation($scope.currentLocationMarker.getLatLng());
    $scope.$apply();
  };
  $scope.currentLocationMarker.on('dragend', $scope.currentLocationChanged);
}]);

