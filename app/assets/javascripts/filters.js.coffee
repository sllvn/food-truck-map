food_truck_app.filter 'filter_by_tags', ->
  (trucks, active_tags) ->
    filtered = []

    angular.forEach trucks, (truck) ->
      is_active = false
      intersect = _.intersection active_tags, truck.tag_list
      is_active = true if active_tags.length == 0 or intersect.length > 0

      filtered.push(truck) if is_active

    filtered

