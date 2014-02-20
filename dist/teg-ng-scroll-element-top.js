(function () {
  angular.module('TedNgScrollElementTop', []).factory('tegNgScrollElementTop', [
    'tegJQ',
    function (tegJQ) {
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
        scroll: function ($element) {
          var scrollTo;
          scrollTo = $element.offset().top - this.distanceFromTop;
          return tegJQ.htmlAndBody.animate({ scrollTop: scrollTo }, 300);
        },
        screenIsShort: function () {
          return tegJQ.window.height() < this.screenHeightThreshold;
        },
        scrollingIsNeeded: function ($element) {
          var elementTop, scrollTop;
          scrollTop = tegJQ.window.scrollTop();
          elementTop = $element.offset().top;
          return elementTop - scrollTop !== this.distanceFromTop;
        }
      };
    }
  ]);
}.call(this));