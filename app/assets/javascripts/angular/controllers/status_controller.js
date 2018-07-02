const app = angular.module('app')

app.controller("StatusController", ['$scope', 'User', ($scope, User) => {
  $scope.statuses = User.index()

  $scope.$on("refresh", () => {
    $scope.refresh()
  })

  $scope.refresh = () => {
    $scope.isLoading = true
    User.index(
      (data) => {
        $scope.isLoading = false
        $scope.statuses = data
      }
    )
  }
}])