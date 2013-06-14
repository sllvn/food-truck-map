'use strict';

foodTruckApp.filter('withinRange', function () {
  return function (trucks, min, max) {
    // TODO: refactor this into truckService? we're hitting $digest limit if we do too much filtering
    var filtered = [];
    angular.forEach(trucks, function (truck) {
      var truckMilesDistance = truck.distance / 1609.34;
      if (truckMilesDistance > min && truckMilesDistance <= max) {
        filtered.push(truck);
      }
    });
    return filtered;
  }
});

foodTruckApp.filter('active', function () {
  return function (trucks) {
    var filtered = [];
    angular.forEach(trucks, function (truck) {
      if (truck.status == "open") {
        filtered.push(truck);
      }
    });
    return filtered;
  };
})