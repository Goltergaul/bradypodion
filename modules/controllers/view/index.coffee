###
  bradypodion view controller
  @since 0.1.0
###
viewCtrl = ($scope, $state) ->
  transition = ''
  direction  = 'normal'

  $scope.to = (state, back) ->
    direction = if back then 'reverse' else 'normal'
    $state.transitionTo state

  $scope.setTransition = (newTransition) ->
    transition = newTransition

  $scope.getDirection = ->
    direction

  $scope.getFullTransition = ->
    "#{transition}-#{direction}"

  $scope.$on '$stateChangeStart', (
    event
    toState
    toParams
    fromState
    fromParams ) ->

    $scope = event.currentScope
    if $scope.getDirection() is 'reverse'
      $scope.setTransition fromState.transition
    else
      $scope.setTransition toState.transition

angular.module('bp.controllers').controller 'bpViewCtrl', viewCtrl