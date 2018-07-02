var app = angular.module('app')

app.controller("StatusController", ['$scope', 'User', function($scope, User) {
  $scope.statuses = User.index()

  $scope.$on("refresh", function(){
    $scope.refresh()
  })

  $scope.refresh = function() {
    $scope.isLoading = true
    User.index(
      function(data) {
        $scope.isLoading = false
        $scope.statuses = data
      }
    )
  }
}])