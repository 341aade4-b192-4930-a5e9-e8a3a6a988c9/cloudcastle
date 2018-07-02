const app = angular.module('app')

app.controller('AddUserController', ['$rootScope','$scope', 'User', ($rootScope, $scope, User) => {

  $scope.newUser = new User()

  $scope.save =
    function() {
      $scope.isLoading = true

      User.save(
        { user: $scope.user },
        () => {
          $scope.error = null
          $scope.isLoading = false
          $rootScope.$broadcast("refresh")
        },
        (err) => {
          $scope.isLoading = false
          $scope.error = err.data.error_message
        }
      )
    }
}])