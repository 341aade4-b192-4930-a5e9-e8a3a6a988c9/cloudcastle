var app = angular.module('app', ['ngResource', 'templates', 'ngRoute']);

app.config(function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/home', {
      templateUrl: 'angular/templates/home_section.html',
      controller: 'HomeController',
    })
    .when('/add_user', {
      templateUrl: 'angular/templates/add_user_section.html',
      controller: 'AddUserController',
    })
    .when('/rating', {
      templateUrl: 'angular/templates/rating_section.html',
      controller: 'RatingController',
    })
    .when('/status', {
      templateUrl: 'angular/templates/status_section.html',
      controller: 'StatusController'
    });

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  });
});
