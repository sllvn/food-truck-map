#= require jquery
#= require jquery_ujs
#= require leaflet
#= require twitter/bootstrap
#= require select2
#= require_self

class Map
  constructor: (map_element, lat, lng) ->
    map = L.map map_element, {
      center: [lat, lng]
      zoom: 14
      scrollWheelZoom: false
    }
    map.addLayer new L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg')
    @marker = L.marker([lat, lng], { draggable: true }).addTo(map)
    @marker.on 'dragend', @handleMarkerDrag

  moveMarker: (lat, lng) ->
    console.log 'moving marker'
    @marker.setLatLng(new L.LatLng(lat, lng))

  handleMarkerDrag: (e) ->
    latlng = e.target.getLatLng()
    $('#business_lat').val(latlng.lat)
    $('#business_lng').val(latlng.lng)

$ ->
  lat = $('#business_lat').val()
  lng = $('#business_lng').val()
  if lat and lng
    window.map = new Map('map', lat, lng)

  $('#business_tag_list').select2({ tags: window.all_tags, width: 'copy' }) if $('#business_tag_list')
  $('#business_location_list').select2({ tags: window.all_locations, width: 'copy' }) if $('#business_location_list')

$('#business_lat, #business_lng').change ->
  map.moveMarker($('#business_lat').val(), $('#business_lng').val())
