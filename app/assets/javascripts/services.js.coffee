food_truck_app.factory 'food_truck_service', ['$resource', '$rootScope', ($resource, $rootScope) ->
  active_trucks = []
  all_trucks = $resource('/food_businesses.json').query ->
    angular.forEach all_trucks, (truck) ->
      active_trucks.push truck if truck.status is 'open'

  get_all_trucks: -> all_trucks

  get_active_trucks: -> active_trucks
]
