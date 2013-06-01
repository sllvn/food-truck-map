'use strict';

angular.module('foodTruckApp.controllers', []).
  controller('FoodTrucksController', function($scope, $resource, $http) {
    $scope.showTruck = function(truck) {
      var marker = L.marker([truck.location.latitude, truck.location.longitude]).addTo(window.map);
      var popupContent = "<h3>" + truck.name + "</h3>";
      marker.bindPopup(popupContent);
    }

    var Truck = $resource('/dummydata.js', { truckId: '@id' });

    $scope.trucks = Truck.query(function() {});

    //var Player = $resource('/players/:playerId', { playerId: '@id' });

    /*$scope.updatePlayers = function() {
      angular.forEach($scope.players, function(player) {
        player.points = "Updating...";
        $http.get('/players/update/' + player.id).
          success(function(data) {
            player.points = data.player.points;
          }).
          error(function() {
            player.points = 'Error';
          })
      });
    }; */
  });
