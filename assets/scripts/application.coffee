# Bootstrap react
#
# React    = require 'react'
# element  = document.getElementById('react-load-state')
# content  = <p>React: Loaded</p>
#
# React.render content, element

d3       = require 'd3'
topojson = require 'topojson'
width    = 960
height   = 600
path     = d3.geo.path().projection(null)
svg      = d3.select('body').append('svg').attr({ height, width })
radius   = d3.scale.sqrt().domain([0, 1e6]).range([0, 15])

translate = "translate(#{width - 50}, #{height - 20})"
legend    = svg.append('g').attr(class: 'legend', transform: translate)
  .selectAll('g').data([1e6, 3e6, 6e6]).enter().append('g')

legendCircle = r: radius, cy: (d) -> -radius(d)
legend.append('circle').attr(legendCircle)

legendText = dy: '1.3em', y: (d) -> -2 * radius(d)
legend.append('text').attr(legendText).text(d3.format('.1s'))

d3.json 'us', (error, response) ->
  return console.error(error) if error?

  filter       = (base, other) -> base != other
  transform    = (diameter) -> "translate(#{path.centroid(diameter)})"
  radiusCalc   = (data) -> radius(data.properties.population)
  landDatum    = topojson.feature(response, response.objects.nation)
  borderDatum  = topojson.mesh(response, response.objects.states, filter)

  sortedBubbles = topojson.feature(response, response.objects.counties)
    .features
    .sort (base, other) ->
      other.properties.population - base.properties.population

  svg.append('path').datum(landDatum).attr(class: 'land', d: path)
  svg.append('path').datum(borderDatum).attr(class: 'border', d: path)

  svg.append('g').attr(class: 'bubble').selectAll('circle').data(sortedBubbles)
    .enter().append('circle').attr({ transform }).attr(r: radiusCalc)
