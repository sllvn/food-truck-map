truck_marker = L.AwesomeMarkers.icon(icon: 'truck', markerColor: 'green')
stand_marker = L.AwesomeMarkers.icon( icon: 'cutlery', markerColor: 'purple')
current_location_marker = L.AwesomeMarkers.icon(icon: 'star', markerColor: 'blue')

food_truck_app = angular.module('food_truck_app.controllers, food_truck_app.filters', [])

food_truck_app.controller 'food_trucks_controller', [
  '$scope', '$compile', '$filter', 'food_truck_service', 'tag_service',
  class FoodTruck
    constructor: (@$scope, $compile, $filter, food_truck_service, tag_service) ->
      @$scope.$watch 'active_tags', =>
        filtered_trucks = $filter('filter_by_tags')(@all_trucks, $scope.active_tags)
        this.remove_all_markers_from_map()
        this.add_trucks_to_map(filtered_trucks)

      @$scope.active_tags = []

      @all_trucks = food_truck_service.get_all_trucks()
      @all_trucks.$then =>
        this.add_trucks_to_map @all_trucks

      @all_tags = tag_service.get_all_tags()

      @current_location_marker = L.marker()
      @current_location_marker.options.icon = current_location_marker
      @current_location_marker.options.draggable = false
      @current_location_marker.on 'dragend', @current_location_changed

      # TODO: move map methods into service
      @markers = []
      @map = L.map('map', center: [47.6097, -122.3331], zoom: 14, minZoom: 9, maxZoom: 16)
      @map.addLayer new L.TileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg')

      @map.on 'popupopen', (e) =>
        popup = angular.element('.leaflet-popup-content')
        $compile(popup) @$scope
        @$scope.$digest() unless @$scope.$$phase

      @map.locate
        setView: true
        maxZoom: 15

      @map.on 'locationfound', @on_location_found

    # map method
    on_location_found: (e) =>
      @current_location_marker.setLatLng e.latlng
      @current_location_marker.addTo(@map)

    # map method
    show_truck: (truck) ->
      angular.forEach @markers, (marker) ->
        marker.openPopup() if marker.truckId is truck.id

    # map method
    remove_all_markers_from_map: =>
      angular.forEach @markers, (marker) =>
        @map.removeLayer marker

    # map method
    add_trucks_to_map: (trucks) ->
      angular.forEach trucks, (truck, iterator) =>
        return unless truck.current_location and truck.current_location.latitude and truck.current_location.longitude

        marker = L.marker([truck.current_location.latitude, truck.current_location.longitude])
        marker.options.icon = if truck.type is 'truck' then truck_marker else stand_marker
        marker.truckId = truck.id
        marker.addTo @map

        # TODO: refactoring candidate, this is ugly, is there a better way to reference correct truck?
        popup = marker.bindPopup("<food-truck-popup truck=\"food_trucks.all_trucks[#{iterator}]\"/>",
          minWidth: 300
          maxWidth: 300
        )
        @markers.push marker
]

this.food_truck_app = food_truck_app
