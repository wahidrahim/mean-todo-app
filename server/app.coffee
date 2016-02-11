express = require 'express'
parser = require 'body-parser'
logger = require 'morgan'
path = require 'path'
mongoose = require 'mongoose'

mongoose.connect('localhost')

Task = mongoose.model 'Task',
  name: String
  done: Boolean
  added: Date

app = express()

app.set 'port', 3000
app.set 'views', path.join('client', 'views')
app.set 'view engine', 'jade'

app.use logger('dev')
app.use parser.json()
app.use '/bower_components', express.static('bower_components')
app.use express.static('client')

app.get '/api/tasks', (req, res) ->
  Task.find (err, tasks) ->
    if err then res.send(err)
    res.json tasks

app.post '/api/tasks', (req, res) ->
  task = new Task
    name: req.body.name
    done: false
    added: new Date
  
  task.save (err, task) ->
    if err then res.status(500).send err
    res.json task

app.put '/api/tasks/:id', (req, res) ->
  Task.findById req.params.id, (err, task) ->
    task.done = !task.done

    task.save (err, task) ->
      if err then res.status(500).send err
      res.json task

app.delete '/api/tasks/:id', (req, res) ->
  Task.findById req.params.id, (err, task) ->
    task.remove (err, task) ->
      if err then res.status(500).send err
      res.json task

app.delete '/api/tasks', (req, res) ->
  Task.remove done: true, (err) ->
    Task.find (err, tasks) ->
      if err then res.status(500).send err
      res.json tasks

app.get '/', (req, res) ->
  res.render 'index'

app.listen app.get('port'),
  console.log 'listening at ' + app.get('port')
