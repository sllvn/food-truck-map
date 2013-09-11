truck_marker = L.AwesomeMarkers.icon(icon: 'truck', color: 'green')
stand_marker = L.AwesomeMarkers.icon( icon: 'food', color: 'purple')
current_location_marker = L.AwesomeMarkers.icon(icon: 'star', color: 'blue')

food_truck_app = angular.module('food_truck_app.controllers, food_truck_app.filters', [])

food_truck_app.controller 'food_trucks_controller', [
  '$scope', '$compile', '$filter', 'food_truck_service',
  class FoodTruck
    constructor: (@$scope, $compile, $filter, food_truck_service) ->
      @$scope.$watch 'search_text', =>
        filtered_trucks = $filter('filter')(@active_trucks, $scope.search_text)
        this.remove_all_markers_from_map()
        this.add_trucks_to_map(filtered_trucks)

      @active_trucks = food_truck_service.get_all_trucks()
      @active_trucks.$then =>
        this.add_trucks_to_map @active_trucks
        this.set_distances_from_location @current_location_marker.getLatLng()

      @current_location_marker = L.marker()
      @current_location_marker.options.icon = current_location_marker
      @current_location_marker.options.draggable = false
      @current_location_marker.on 'dragend', @current_location_changed

      # TODO: move distances into service
      @distances = [
        { display_text: 'Within 1/2 mile', min: 0, max: 0.5 }
        { display_text: 'Within 1 mile', min: 0.5, max: 1 }
        { display_text: 'Within 2 miles', min: 1, max: 2 }
        { display_text: 'Within 5 miles', min: 2, max: 5 }
        { display_text: 'Beyond', min: 5, max: 100 }
      ]

      # TODO: move map methods into service
      @markers = []
      @map = L.map('map', center: [40.7638333, -111.8902778], zoom: 14, minZoom: 9, maxZoom: 16)
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
      this.set_distances_from_location @current_location_marker.getLatLng()

    # map method
    show_truck: (truck) ->
      angular.forEach @markers, (marker) ->
        marker.openPopup() if marker.truckId is truck.id

    # map method
    set_distances_from_location: (current_lat_lng) ->
      angular.forEach @active_trucks, (truck) ->
        if truck.location and truck.location.latitude and truck.location.longitude
          truck.distance = current_lat_lng.distanceTo(new L.LatLng(truck.location.latitude, truck.location.longitude))
      @$scope.$digest() unless @$scope.$$phase

    # map method
    remove_all_markers_from_map: =>
      angular.forEach @markers, (marker) =>
        @map.removeLayer marker

    # map method
    add_trucks_to_map: (trucks) ->
      angular.forEach trucks, (truck, iterator) =>
        return unless truck.location and truck.location.latitude and truck.location.longitude

        marker = L.marker([truck.location.latitude, truck.location.longitude])
        marker.options.icon = if truck.type is 'truck' then truck_marker else stand_marker
        marker.truckId = truck.id
        marker.addTo @map

        # TODO: refactoring candidate, this is ugly, is there a better way to reference correct truck?
        popup = marker.bindPopup("<food-truck-popup truck=\"food_trucks.active_trucks[#{iterator}]\"/>",
          minWidth: 300
          maxWidth: 300
        )
        @markers.push marker
]

this.food_truck_app = food_truck_app
