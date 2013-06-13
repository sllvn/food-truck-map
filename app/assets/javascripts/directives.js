'use strict';

foodTruckApp.directive('foodTruckPopup', function () {
  return {
    restrict: 'E',
    replace: true,
    scope: {
      truck: "="
    },
    templateUrl: '/templates/directives/food_truck_popup.html'
  };
});