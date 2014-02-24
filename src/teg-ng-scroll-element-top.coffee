"use strict"

angular.module('TedNgScrollElementTop', []).
factory('tegNgScrollElementTop', ($window, $timeout) ->
  distanceFromTop: 10
  screenHeightThreshold: 700

  scrollIfNeeded: (element) ->
    return unless @screenIsShort()
    return unless @scrollingIsNeeded(element)
    @scroll element

  scroll: (element) ->
    scrollTo = @getScrollTop() + @getElementTopBound(element) - @distanceFromTop

    # $timeout is needed to make it work on Android 4.0.2 stock browser
    $timeout((=>
      $window.scrollTo(@getScrollLeft(), scrollTo)
    ), 0)

  screenIsShort: -> @screenHeight() < @screenHeightThreshold

  scrollingIsNeeded: (element) -> @getElementTopBound(element) != @distanceFromTop

  getScrollTop: -> $window.pageYOffset || $window.document.documentElement.scrollTop
  getScrollLeft: -> $window.pageXOffset || $window.document.documentElement.scrollLeft

  # getBoundingClientRect() includes page scrolling
  getElementTopBound: (element) -> Math.round(element.getBoundingClientRect().top)

  screenHeight: ->
    if isNaN($window.innerHeight)
      $window.document.documentElement.clientHeight
    else
      $window.innerHeight
)
.directive 'tegNgScrollElementTop', (tegNgScrollElementTop) ->
  link: (scope, element, attrs) ->
    element.bind 'keydown', (event) ->
      tegNgScrollElementTop.scrollIfNeeded element[0]