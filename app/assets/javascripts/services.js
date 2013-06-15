'use strict';

foodTruckApp.factory('currentLocationService', function ($rootScope) {
  var currentLocation = {};
  currentLocation.latlng = "";

  currentLocation.broadcast = function (latlng) {
    this.latlng = latlng;
    $rootScope.$broadcast('currentLocationChanged');
  };

  return currentLocation;
});

foodTruckApp.factory('foodTruckService', function ($resource, $rootScope) {
  var activeTrucks = [];
  var allTrucks = $resource('/food_businesses').query(
    function () {
      angular.forEach(allTrucks, function (truck) {
        if(truck.status == 'open') {
          activeTrucks.push(truck);
        }
      });

      $rootScope.$broadcast('trucksFinishedLoading');
    }
  );

  return {
    getTrucks: function () { return allTrucks; },
    getActiveTrucks: function () { return activeTrucks; }
  };
});

foodTruckApp.factory('broadcastService', function ($rootScope) {
  var eventBroadcaster = {};
  eventBroadcaster.message = '';
  eventBroadcaster.eventName = '';

  eventBroadcaster.broadcast = function (eventName, message) {
    this.message = message;
    this.eventName = eventName;
    this.sendBroadcast();
  };

  eventBroadcaster.sendBroadcast = function () {
    $rootScope.$broadcast(this.eventName);
  };

  return eventBroadcaster;
});
