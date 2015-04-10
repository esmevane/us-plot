express = require 'express'
app     = express()

routeToFile = ({ app, route, file }) ->
  app.get route, (request, response) -> response.sendfile file

app.use '/images',  express.static "app/images"
app.use '/scripts', express.static "app/scripts"
app.use '/styles',  express.static "app/styles"

routeToFile app: app, route: '/counties', file: 'build/counties.json'
routeToFile app: app, route: '*',         file: 'app/index.html'

module.exports = app
