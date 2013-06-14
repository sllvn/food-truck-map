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

foodTruckApp.factory('foodTruckService', function ($resource, $q, $rootScope) {
  return {
    getTrucks: function () {
      var deferred = $q.defer();
      $resource('/food_businesses/:truckId', { truckId: '@truckId' }).query(
        function (event) {
          deferred.resolve(event);
        },
        function (response) {
          deferred.reject(event);
        });

      return deferred.promise;
    }
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
