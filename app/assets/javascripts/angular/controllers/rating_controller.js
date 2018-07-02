const app = angular.module('app')

app.controller("RatingController", ['$scope', 'User', ($scope, User) => {
  $scope.rating1 = User.by_rating1()
  $scope.rating2 = User.by_rating2()

  $scope.$on("refresh", () => {
    $scope.refresh()
  })

  $scope.refresh = () => {
    $scope.isLoading1 = true
    $scope.isLoading2 = true

    User.by_rating1(
      (data) => {
        $scope.rating1 = data
        $scope.isLoading1 = false
      }
    )

    User.by_rating2(
      (data) => {
        $scope.rating2 = data
        $scope.isLoading2 = false
      }
    );
  };
}])