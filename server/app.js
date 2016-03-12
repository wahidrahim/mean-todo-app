// Generated by CoffeeScript 1.10.0
(function() {
  var Task, app, dbURI, express, logger, mongoose, parser, path;

  express = require('express');

  parser = require('body-parser');

  logger = require('morgan');

  path = require('path');

  mongoose = require('mongoose');

  dbURI = 'mongodb://localhost';

  if (process.env.NODE_ENV === 'production') {
    dbURI = process.env.MONGOLAB_URI;
  }

  mongoose.connect(dbURI);

  mongoose.connection.on('connected', function() {
    return console.log('Mongoose connected to ' + dbURI);
  });

  Task = mongoose.model('Task', {
    name: String,
    done: Boolean,
    added: Date
  });

  app = express();

  app.set('port', 3000);

  app.set('views', path.join('client', 'views'));

  app.set('view engine', 'jade');

  app.use(logger('dev'));

  app.use(parser.json());

  app.use('/bower_components', express["static"]('bower_components'));

  app.use(express["static"]('client'));

  app.get('/api/tasks', function(req, res) {
    return Task.find(function(err, tasks) {
      if (err) {
        res.send(err);
      }
      return res.json(tasks);
    });
  });

  app.post('/api/tasks', function(req, res) {
    var task;
    task = new Task({
      name: req.body.name,
      done: false,
      added: new Date
    });
    return task.save(function(err, task) {
      if (err) {
        res.status(500).send(err);
      }
      return res.json(task);
    });
  });

  app.put('/api/tasks/:id', function(req, res) {
    return Task.findById(req.params.id, function(err, task) {
      task.done = !task.done;
      return task.save(function(err, task) {
        if (err) {
          res.status(500).send(err);
        }
        return res.json(task);
      });
    });
  });

  app["delete"]('/api/tasks/:id', function(req, res) {
    return Task.findById(req.params.id, function(err, task) {
      return task.remove(function(err, task) {
        if (err) {
          res.status(500).send(err);
        }
        return res.json(task);
      });
    });
  });

  app["delete"]('/api/tasks', function(req, res) {
    return Task.remove({
      done: true
    }, function(err) {
      return Task.find(function(err, tasks) {
        if (err) {
          res.status(500).send(err);
        }
        return res.json(tasks);
      });
    });
  });

  app.get('/', function(req, res) {
    return res.render('index');
  });

  app.listen(app.get('port'), console.log('listening at ' + app.get('port')));

}).call(this);
