var app = angular.module('app');

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
