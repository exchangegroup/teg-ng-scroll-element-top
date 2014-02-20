angular.module('TedNgScrollElementTop', []).
factory('tegNgScrollElementTop', (tegJQ) ->
  distanceFromTop: 10
  screenHeightThreshold: 600

  scrollIfNeeded: ($element) ->
    return unless @screenIsShort()
    return unless @scrollingIsNeeded($element)
    @scroll $element

  scroll: ($element) ->
    scrollTo = $element.offset().top - @distanceFromTop
    tegJQ.htmlAndBody.animate({scrollTop: scrollTo}, 300)

  screenIsShort: -> tegJQ.window.height() < @screenHeightThreshold

  scrollingIsNeeded: ($element) ->
    scrollTop = tegJQ.window.scrollTop()
    elementTop = $element.offset().top
    elementTop - scrollTop != @distanceFromTop
)