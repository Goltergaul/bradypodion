# # Table-Header

angular.module('bp.directives').directive 'bpTableHeader', ->
  restrict: 'E'
  transclude: true
  template: ''
  compile: (elem, attrs, transcludeFn) ->
    (scope, element, attrs) ->
      transcludeFn scope, (clone) ->
        element
          .attr(
            role: 'heading')
          .append clone
