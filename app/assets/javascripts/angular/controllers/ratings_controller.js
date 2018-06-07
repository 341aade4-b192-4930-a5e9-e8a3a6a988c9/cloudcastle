var app = angular.module('app');

app.controller("RatingsController", ['$scope', 'User', function($scope, User) {
  $scope.rating1 = User.by_rating1()
  $scope.rating2 = User.by_rating2()

  $scope.$on("refresh", function(){
    $scope.refresh();
  });

  $scope.refresh = function() {
    $scope.isLoading1 = true;
    $scope.isLoading2 = true;

    User.by_rating1(
      function(data) {
        $scope.rating1 = data;
        $scope.isLoading1 = false;
      }
    );

    User.by_rating2(
      function(data) {
        $scope.rating2 = data;
        $scope.isLoading2 = false;
      }
    );
  };
}])