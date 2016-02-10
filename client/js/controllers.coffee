app = angular.module('Todo', [])

app.controller 'TodoController', ($scope, $filter)->
  $scope.tasks = []
  $scope.task = {}

  $scope.incompleteTasks = ()->
    $filter('filter')($scope.tasks, { done: false }).length

  $scope.addTask = (task)->
    if Object.keys(task).length
      task.added = moment().fromNow()
      task.done = false

      $scope.tasks.push task

    $scope.task = {}

  $scope.taskComplete = (task)->
    task.done = !task.done

  $scope.taskClear = (task)->
    $scope.tasks.splice($scope.tasks.indexOf(task), 1)

  $scope.clearCompleted = ()->
    $scope.tasks = $scope.tasks.filter((task)-> !task.done)
