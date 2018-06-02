var app = angular.module('app', ['ngResource']);

app.factory("User", ['$resource', function($resource) {
  return $resource(
    "/users/:id",
    {
      //id: "@id"
    },
    {
      add: { method: "POST" },
      index: { method: "GET", isArray: true },
      by_rating1: { method: "GET", params: { order_by: "rating1" }, isArray: true },
      by_rating2: { method: "GET", params: { order_by: "rating2" }, isArray: true }
    }
  );
}])

app.controller("AddUserController", ['$rootScope','$scope', 'User', function($rootScope, $scope, User) {

  $scope.newUser = new User();

  $scope.save = 
    function() {
      $scope.isLoading = true;

      User.save(
        { user: $scope.user },
        function(data) {
          //alert(JSON.stringify(data));
          $scope.error = null;
          $scope.isLoading = false;
          $rootScope.$broadcast("refresh");
          window.scrollTo( 0, document.getElementById('status').offsetTop );
        },
        function(err){
          $scope.isLoading = false;
          $scope.error = err.data.error_message; //remove old
        }
      );
    };
}]);

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

app.controller("StatusesController", ['$scope', 'User', function($scope, User) {
  $scope.statuses = User.index()

  $scope.$on("refresh", function(){
    $scope.refresh();
  });

  $scope.refresh = function() {
    $scope.isLoading = true;
    User.index(
      function(data) {
        $scope.isLoading = false;
        $scope.statuses = data;
      }
    );
  };
}])