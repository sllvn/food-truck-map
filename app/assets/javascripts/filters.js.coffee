food_truck_app.filter 'within_range', ->
  (trucks, min, max) ->
    # TODO: refactor this into truckService?
    # we're hitting $digest limit if we do too much filtering
    filtered = []
    angular.forEach trucks, (truck) ->
      truck_miles_distance = truck.distance / 1609.34
      filtered.push truck if truck_miles_distance > min and truck_miles_distance <= max
    filtered

food_truck_app.filter 'active', ->
  (trucks) ->
    filtered = []
    # TODO: use _.select()
    angular.forEach trucks, (truck) ->
      filtered.push truck if truck.status is 'open'
    filtered
