class window.Map
  constructor: (options = null) ->
    @options = options
    @map = L.map('map', {
      center: [40.7608333, -111.8402778],
      zoom: 12
    })
    window.map = @map
    @map.addLayer(new L.TileLayer("http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"))

  scale_to_fit: ->
    #for route in @routes
    #  for index in [0..(route.polyline.getPath().length-1)]
    #    bounds.extend(route.polyline.getPath().getAt(index))
    @canvas.fitBounds bounds

  reset: ->

$ ->
  map = new Map()
