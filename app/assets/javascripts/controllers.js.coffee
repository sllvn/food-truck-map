truck_marker = L.AwesomeMarkers.icon(
  icon: 'truck'
  color: 'green'
)
stand_marker = L.AwesomeMarkers.icon(
  icon: 'food'
  color: 'purple'
)
current_location_marker = L.AwesomeMarkers.icon(
  icon: 'star'
  color: 'blue'
)

food_truck_app = angular.module('food_truck_app.controllers, food_truck_app.filters', [])

food_truck_app.controller 'FoodTrucksController', ['$scope', '$resource', '$compile', '$filter', 'food_truck_service', ($scope, $resource, $compile, $filter, food_truck_service) ->
  $scope.active_trucks = food_truck_service.get_active_trucks()
  $scope.show_truck = (truck) ->
    angular.forEach $scope.markers, (marker) ->
      marker.openPopup() if marker.truckId is truck.id

  $scope.$watch 'searchText', ->
    filtered_trucks = $filter('filter')($scope.active_trucks, $scope.searchText)
    remove_all_markers_from_map()
    add_trucks_to_map filtered_trucks

  # TODO: move distances into service
  $scope.distances = [
    { display_text: 'Within 1/2 mile', min: 0, max: 0.5 }
    { display_text: 'Within 1 mile', min: 0.5, max: 1 }
    { display_text: 'Within 2 miles', min: 1, max: 2 }
    { display_text: 'Within 5 miles', min: 2, max: 5 }
    { display_text: 'Beyond', min: 5, max: 100 }
  ]
  $scope.set_distances_from_location = (current_lat_lng) ->
    angular.forEach $scope.active_trucks, (truck) ->
      truck.distance = current_lat_lng.distanceTo(new L.LatLng(truck.location.latitude, truck.location.longitude))

  # TODO: move map methods into service
  $scope.map = L.map('map',
    center: [40.7638333, -111.8902778]
    zoom: 15
    minZoom: 13
    maxZoom: 16
  )
  $scope.map.addLayer new L.TileLayer('http://a.tile.openstreetmap.org/{z}/{x}/{y}.png')
  $scope.markers = []
  $scope.active_trucks = food_truck_service.get_active_trucks()
  remove_all_markers_from_map = ->
    angular.forEach $scope.markers, (marker) ->
      $scope.map.removeLayer marker

  $scope.$on 'trucks_finished_loading', ->
    # if current location loaded first
    $scope.set_distances_from_location $scope.current_location_marker.getLatLng() if $scope.current_location_marker.getLatLng()
    add_trucks_to_map $scope.active_trucks

  add_trucks_to_map = (trucks) ->
    angular.forEach trucks, (truck, iterator) ->
      marker = L.marker([truck.location.latitude, truck.location.longitude])
      marker.options.icon = if truck.type is 'truck' then truck_marker else stand_marker
      marker.truckId = truck.id
      marker.addTo $scope.map

      # TODO: refactoring candidate, this is ugly, is there a better way to reference correct truck?
      popup = marker.bindPopup("<food-truck-popup truck=\"active_trucks[#{iterator}]\"/>",
        minWidth: 300
        maxWidth: 300
      )
      $scope.markers.push marker

  $scope.map.on 'popupopen', (e) ->
    popup = angular.element('.leaflet-popup-content')
    $compile(popup) $scope
    $scope.$digest() unless $scope.$$phase

  $scope.current_location_marker = L.marker()
  $scope.current_location_marker.options.icon = current_location_marker
  $scope.current_location_marker.options.draggable = false
  $scope.enable_checkin = ->
    $scope.current_location_marker.options.draggable = true

  $scope.map.locate
    setView: true
    maxZoom: 15

  $scope.onLocationFound = (e) ->
    $scope.current_location_marker.setLatLng e.latlng
    $scope.current_location_marker.addTo $scope.map
    $scope.current_location_changed()

  $scope.map.on 'locationfound', $scope.onLocationFound
  $scope.check_in_address = ''
  $scope.current_location_changed = ->
    $scope.check_in_address = "#{$scope.current_location_marker.getLatLng().lat}, #{$scope.current_location_marker.getLatLng().lng}"
    $scope.set_distances_from_location $scope.current_location_marker.getLatLng()
    $scope.$apply()

  $scope.current_location_marker.on 'dragend', $scope.current_location_changed
]

this.food_truck_app = food_truck_app
