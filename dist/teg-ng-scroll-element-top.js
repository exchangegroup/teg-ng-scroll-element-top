(function () {
  angular.module('TedNgScrollElementTop', []).factory('tegNgScrollElementTop', [
    '$window',
    function ($window) {
      return {
        distanceFromTop: 10,
        screenHeightThreshold: 600,
        scrollIfNeeded: function ($element) {
          if (!this.screenIsShort()) {
            return;
          }
          if (!this.scrollingIsNeeded($element)) {
            return;
          }
          return this.scroll($element);
        },
        scroll: function (element) {
          var scrollTo;
          scrollTo = element.getBoundingClientRect().top - this.distanceFromTop;
          return $window.scrollTo(this.getScrollLeft(), scrollTo);
        },
        screenIsShort: function () {
          return this.screenHeight() < this.screenHeightThreshold;
        },
        scrollingIsNeeded: function (element) {
          var elementTop, scrollTop;
          scrollTop = this.getScrollTop();
          elementTop = element.getBoundingClientRect().top;
          return elementTop - scrollTop !== this.distanceFromTop;
        },
        getScrollTop: function () {
          return $window.document.documentElement.scrollTop;
        },
        getScrollLeft: function () {
          return $window.document.documentElement.scrollLeft;
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
  ]);
}.call(this));