# # Navbar

angular.module('bp.directives').directive 'bpNavbar', deps [
  '$timeout'
  ], (
  $timeout
  ) ->
  restrict: 'E'
  transclude: true
  template: '<div class="bp-navbar-text" role="heading"></div>'
  compile: (elem, attrs, transcludeFn) ->
    (scope, element, attrs) ->
      element.attr
        role: 'navigation'
      transcludeFn scope, (clone) ->
        $navbarText = element.find('.bp-navbar-text')
        placedButtons = 0
        buttons = []

        navbarText = $navbarText.text()
        for child in clone
          $child = angular.element(child)
          if $child.is('bp-button') or $child.is('bp-icon')
            buttons.push($child)
          else if $child.context.nodeName is '#text' or
                  $child.is('span.ng-scope')
            navbarText += ' ' + $child.text().trim()

        # Trim leading and trailing whitespace
        $navbarText.text navbarText.trim()

        for $button, i in buttons
          if (i+1) <= Math.round(buttons.length/2)
            $button
              .addClass('before')
              .insertBefore $navbarText
          else
            element.append $button.addClass('after')

        unless /^\s*$/.test $navbarText.text() then $timeout ->
          beforeWidth = 0
          afterWidth  = 0
          elem.find('.after').each ->
            afterWidth += $(this).outerWidth()
          elem.find('.before').each ->
            beforeWidth += $(this).outerWidth()

          difference = afterWidth - beforeWidth
          $spacer = $("
            <div style='
              -webkit-box-flex:10;
              max-width:#{Math.abs(difference)}px
            '>")

          if difference > 0
            $spacer.insertBefore $navbarText
          else if difference < 0
            $spacer.insertAfter $navbarText
        , 0
