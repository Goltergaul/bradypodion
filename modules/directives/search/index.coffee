###
  bradypodion search directive
  @since 0.1.0
  @example description of search example
    <bp-search></bp-search>
  @return [Object<restrict|template|link>] Angular directive
###
search = ($compile) ->
  restrict: 'E'
  link: (scope, element, attrs) ->
    $cancel = $compile(
      '<bp-button bp-tap="cancel()" bp-no-scroll="true">Cancel</bp-button>'
      ) scope
    $search = element.find 'input'
    element.append $cancel

    # set input placeholder to "Search" if not already set
    placeholder = $search?.attr 'placeholder'
    if !placeholder? or /^\s*$/.test placerholder
      $search?.attr 'placeholder', 'Search'

    # helper to prevent event default
    preventDefault = (e) ->
      e.preventDefault?()

    $search?.bind 'focus', ->
      # bring in cancel button; shrink input
      padding = (+(element.css 'padding-right').replace('px',''))
      cancelWidth = $cancel.outerWidth()
      inputWidth = element.width() - (padding)
      $search?.css 'width', "#{inputWidth - cancelWidth - padding}px"
      element.addClass 'focus'

      # scroll out UI before search
      if element.prev().length
        element.bind 'touchmove', preventDefault
        setTimeout ->
          window.scrollTo 0, element.prev().outerHeight()
        , 0

    # move out cancel button and grow input
    scope.cancel = ->
      if $search?.is ':focus'
        $search.blur()
      scope.searchTerm = ''
      $search?.css 'width', ''
      element.removeClass 'focus'

    $search?.bind 'blur', (e) ->
      # cancel on blur  if no searchterm is present
      if !scope.searchTerm? or /^\s*$/.test scope.searchTerm
        scope.cancel()
      element.unbind 'touchmove', preventDefault

    # prevents blurring the input automatically
    # so we can fire it at the right time i.e. tap/touchend
    $cancel.bind 'touchstart', preventDefault

    scope.$on '$destroy', ->
      $search?.unbind 'focus blur'
      element.unbind 'touchmove', preventDefault
      $cancel.unbind 'touchstart', preventDefault

angular.module('bp.directives').directive 'bpSearch', search