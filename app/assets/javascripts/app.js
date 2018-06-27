var app = angular.module('app', ['ngResource', 'ngRoute']);

var homeUrl = require('./angular/templates/home_section.html.slim');
var addUserUrl = require('./angular/templates/add_user_section.html.slim');
var ratingUrl = require('./angular/templates/rating_section.html.slim');
var statusUrl = require('./angular/templates/status_section.html.slim');


app.config(function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/home', {
      templateUrl: homeUrl,
      controller: 'HomeController',
    })
    .when('/add_user', {
      templateUrl: addUserUrl,
      controller: 'AddUserController',
    })
    .when('/rating', {
      templateUrl: ratingUrl,
      controller: 'RatingController',
    })
    .when('/status', {
      templateUrl: statusUrl,
      controller: 'StatusController'
    });

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  });
});
