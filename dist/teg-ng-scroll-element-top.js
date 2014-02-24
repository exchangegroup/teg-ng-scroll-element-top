(function () {
  'use strict';
  angular.module('TedNgScrollElementTop', []).factory('tegNgScrollElementTop', [
    '$window',
    '$timeout',
    function ($window, $timeout) {
      return {
        distanceFromTop: 10,
        screenHeightThreshold: 700,
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
          return $timeout(function (_this) {
            return function () {
              return $window.scrollTo(_this.getScrollLeft(), scrollTo);
            };
          }(this), 0);
        },
        screenIsShort: function () {
          return this.screenHeight() < this.screenHeightThreshold;
        },
        scrollingIsNeeded: function (element) {
          return this.getElementTopBound(element) !== this.distanceFromTop;
        },
        getScrollTop: function () {
          return $window.pageYOffset || $window.document.documentElement.scrollTop;
        },
        getScrollLeft: function () {
          return $window.pageXOffset || $window.document.documentElement.scrollLeft;
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