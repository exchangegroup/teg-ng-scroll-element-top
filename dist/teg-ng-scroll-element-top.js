(function () {
  'use strict';
  angular.module('TedNgScrollElementTop', []).factory('tegNgScrollElementTop', [
    '$window',
    function ($window) {
      return {
        distanceFromTop: 10,
        screenHeightThreshold: 600,
        scrollIfNeeded: function (element) {
          if (!this.screenIsShort()) {
            return;
          }
          if (!this.scrollingIsNeeded(element)) {
            return;
          }
          return this.scroll(element);
        },
        scroll: function (element) {
          var scrollTo;
          scrollTo = this.getScrollTop() + this.getElementTopBound(element) - this.distanceFromTop;
          return $window.scrollTo(this.getScrollLeft(), scrollTo);
        },
        screenIsShort: function () {
          return this.screenHeight() < this.screenHeightThreshold;
        },
        scrollingIsNeeded: function (element) {
          return this.getElementTopBound(element) !== this.distanceFromTop;
        },
        getScrollTop: function () {
          return $window.document.documentElement.scrollTop;
        },
        getScrollLeft: function () {
          return $window.document.documentElement.scrollLeft;
        },
        getElementTopBound: function (element) {
          return Math.round(element.getBoundingClientRect().top);
        },
        screenHeight: function () {
          if (isNaN($window.innerHeight)) {
            return $window.document.documentElement.clientHeight;
          } else {
            return $window.innerHeight;
          }
        }
      };
    }
  ]).directive('tegNgScrollElementTop', [
    'tegNgScrollElementTop',
    function (tegNgScrollElementTop) {
      return {
        link: function (scope, element, attrs) {
          return element.bind('keydown', function (event) {
            return tegNgScrollElementTop.scrollIfNeeded(element[0]);
          });
        }
      };
    }
  ]);
}.call(this));