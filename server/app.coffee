express = require 'express'
logger = require 'morgan'
path = require 'path'

app = express()

app.set 'port', 3000
app.set 'views', path.join('client', 'views')
app.set 'view engine', 'jade'

app.use logger('dev')
app.use '/bower_components', express.static('bower_components')
app.use express.static('client')

app.get '/', (req, res)->
  res.render 'index'

app.listen app.get('port'),
  console.log 'listening at ' + app.get('port')
