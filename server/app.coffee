express = require 'express'
path = require 'path'

app = express()

app.set 'port', 3000
app.set 'views', path.join 'client', 'views'
app.set 'view engine', 'jade'

app.get '/', (req, res)->
  res.render 'index'

app.listen app.get('port'),
  console.log 'listening at ' + app.get('port')
