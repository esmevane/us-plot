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

d3.json 'counties', (error, response) ->
  return console.error(error) if error?

  svg.append('path').datum(topojson.mesh(response)).attr('d', path)
