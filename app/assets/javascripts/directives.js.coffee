food_truck_app.directive "foodTruckPopup", ->
  restrict: "E"
  replace: true
  scope:
    truck: "="

  templateUrl: "/templates/directives/food_truck_popup.html"
