"use strict"

angular.module('TedNgScrollElementTop', []).
factory('tegNgScrollElementTop', ($window) ->
  distanceFromTop: 10
  screenHeightThreshold: 600

  scrollIfNeeded: (element) ->
    return unless @screenIsShort()
    return unless @scrollingIsNeeded(element)
    @scroll element

  scroll: (element) ->
    scrollTo = @getScrollTop() + @getElementTopBound(element) - @distanceFromTop
    $window.scrollTo(@getScrollLeft(), scrollTo)

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