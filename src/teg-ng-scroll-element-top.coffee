angular.module('TedNgScrollElementTop', []).
factory('tegNgScrollElementTop', ($window) ->
  distanceFromTop: 10
  screenHeightThreshold: 600

  scrollIfNeeded: ($element) ->
    return unless @screenIsShort()
    return unless @scrollingIsNeeded($element)
    @scroll $element

  scroll: (element) ->
    scrollTo = element.getBoundingClientRect().top - @distanceFromTop
    $window.scrollTo(@getScrollLeft(), scrollTo)

  screenIsShort: -> @screenHeight() < @screenHeightThreshold

  scrollingIsNeeded: (element) ->
    scrollTop = @getScrollTop()
    elementTop = element.getBoundingClientRect().top
    elementTop - scrollTop != @distanceFromTop

  getScrollTop: -> document.documentElement.scrollTop
  getScrollLeft: -> document.documentElement.scrollLeft

  screenHeight: ->
    if isNaN($window.innerHeight)
      $window.document.documentElement.clientHeight
    else
      $window.innerHeight
)