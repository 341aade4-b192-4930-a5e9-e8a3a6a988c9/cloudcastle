var app = angular.module('app', ['ngResource', 'ngRoute']);

var homeTemplateUrl = require('ngtemplate-loader!html-loader!slim-lang-loader!./angular/templates/home_section.html.slim');
var addUserTemplateUrl = require('ngtemplate-loader!html-loader!slim-lang-loader!./angular/templates/add_user_section.html.slim');
var ratingTemplateUrl = require('ngtemplate-loader!html-loader!slim-lang-loader!./angular/templates/rating_section.html.slim');
var statusTemplateUrl = require('ngtemplate-loader!html-loader!slim-lang-loader!./angular/templates/status_section.html.slim');


app.config(function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/home', {
      templateUrl: homeTemplateUrl,
      controller: 'HomeController',
    })
    .when('/add_user', {
      templateUrl: addUserTemplateUrl,
      controller: 'AddUserController',
    })
    .when('/rating', {
      templateUrl: ratingTemplateUrl,
      controller: 'RatingController',
    })
    .when('/status', {
      templateUrl: statusTemplateUrl,
      controller: 'StatusController'
    });

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  });
});
