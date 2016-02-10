app = angular.module('Todo', [])

old = {
  name: 'old one'
  done: false
  added: moment('1992-06-14').fromNow()
}

app.controller 'TodoController', ($scope, $filter)->
  $scope.tasks = [old]
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
