app = angular.module('Todo', [])

app.controller 'TodoController', ($scope, $filter, $http) ->
  $scope.task = {}
  $scope.tasks = []

  # get all tasks
  $http.get '/api/tasks'
    .success (tasks) ->
      $scope.tasks = tasks
    .error (error) ->
      console.log error

  # returns the number of incomplete tasks
  $scope.incompleteTasks = () ->
    inc = 0
    $scope.tasks.map (task) ->
      if !task.done then ++inc
    return inc
    #$filter('filter')($scope.tasks, { done: false }).length

  # add task
  $scope.addTask = (task) ->
    if task.name
      $http.post '/api/tasks', task
        .success (task) ->
          $scope.tasks.push task
        .error (error) ->
          console.log error

    # reset new task
    $scope.task = {}

  $scope.toggleComplete = (task) ->
    index = $scope.tasks.indexOf(task)

    $http.put '/api/tasks/'+task._id
      .success (task) ->
        $scope.tasks.splice index, 1, task
      .error (error) ->
        console.log error

  $scope.clearTask = (task) ->
    index = $scope.tasks.indexOf(task)

    $http.delete '/api/tasks/'+task._id
      .success () ->
        $scope.tasks.splice index, 1
      .error (error) ->
        console.log error

  $scope.clearCompleted = () ->
    $http.delete '/api/tasks'
      .success (tasks) ->
        $scope.tasks = tasks

  $scope.timeAgo = (date) ->
    moment(date).fromNow()
