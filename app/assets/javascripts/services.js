'use strict';

foodTruckApp.factory('foodTruckService', ['$resource', '$rootScope', function ($resource, $rootScope) {
  var activeTrucks = [];
  var allTrucks = $resource('/food_businesses.json').query(
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
}]);

