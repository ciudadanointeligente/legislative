// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var TypeaheadCtrl = function ($scope) {
  $scope.selected_author = undefined;
  $scope.authors = authors_list;
};