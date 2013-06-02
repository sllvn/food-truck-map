'use strict';

angular.module('foodTruckApp.controllers', []).
  controller('FoodTrucksController', function($scope, $resource, $http) {
    $scope.showTruck = function(truck) {
      var marker = L.marker([truck.location.latitude, truck.location.longitude]).addTo(window.map);
      var popupContent = "<h3>" + truck.name + "</h3>";
      marker.bindPopup(popupContent);
    }

    var Truck = $resource('/food_businesses/:foodBusinessId', { truckId: '@id' });

    $scope.trucks = Truck.query(function() {});
  });
