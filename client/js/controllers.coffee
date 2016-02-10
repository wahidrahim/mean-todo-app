app = angular.module('Todo', [])

app.controller 'TodoController', ($scope)->
  $scope.tasks = []
  $scope.task = {}

  $scope.addTask = (task)->
    if Object.keys(task).length
      task.done = false
      task.added = new Date

      $scope.tasks.push task

    $scope.task = {}
