describe 'TegNgScrollElementTop helper', ->
  beforeEach -> module('TedNgScrollElementTop')
  beforeEach ->
    @elementTop = 350
    @element =
      getBoundingClientRect: => { top: @elementTop }

  beforeEach ->
    @mockWindow= { }

    angular.mock.module ($provide) =>
      $provide.value '$window', @mockWindow
      null

  beforeEach(inject((@tegNgScrollElementTop, @$timeout) ->))

  describe 'is scrolling needed?', ->
    it 'should scoll', ->
      @elementTop = 200
      result = @tegNgScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe true

    it 'should not scoll', ->
      @elementTop = 10
      result = @tegNgScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe false

  describe 'scroll to top if needed', ->
    beforeEach -> spyOn @tegNgScrollElementTop, 'scroll'

    describe 'when screen is short', ->
      beforeEach ->
        spyOn(@tegNgScrollElementTop, 'screenIsShort').andReturn true

      it 'checks if scrolling needed', ->
        spyOn @tegNgScrollElementTop, 'scrollingIsNeeded'
        @tegNgScrollElementTop.scrollIfNeeded @element
        expect(@tegNgScrollElementTop.scrollingIsNeeded).toHaveBeenCalledWith @element

    describe 'when screen is tall', ->
      beforeEach -> spyOn(@tegNgScrollElementTop, 'screenIsShort').andReturn false

      it 'does nothing', ->
        spyOn @tegNgScrollElementTop, 'scrollingIsNeeded'
        @tegNgScrollElementTop.scrollIfNeeded @element
        expect(@tegNgScrollElementTop.scrollingIsNeeded).not.toHaveBeenCalled()

    describe 'scrolls when screen is short and scrolling is needed', ->
      beforeEach ->
        spyOn(@tegNgScrollElementTop, 'screenIsShort').andReturn true
        spyOn(@tegNgScrollElementTop, 'scrollingIsNeeded').andReturn true

      it '', ->
        @tegNgScrollElementTop.scrollIfNeeded @element
        expect(@tegNgScrollElementTop.scroll).toHaveBeenCalledWith @element

  describe 'check if screen is short', ->
    it 'screen is short', ->
      spyOn(@tegNgScrollElementTop, 'screenHeight').andReturn 480
      expect(@tegNgScrollElementTop.screenIsShort()).toBe true

    it 'screen is tall', ->
      spyOn(@tegNgScrollElementTop, 'screenHeight').andReturn 800
      expect(@tegNgScrollElementTop.screenIsShort()).toBe false

  describe 'screen height', ->
    it 'on modern browsers', ->
      @mockWindow.innerHeight = 212
      expect(@tegNgScrollElementTop.screenHeight()).toBe 212

    it 'on old IE', ->
      @mockWindow.document =
        documentElement:
          clientHeight: 312

      expect(@tegNgScrollElementTop.screenHeight()).toBe 312

  it 'scroll element to top of the page', ->
    @elementTop = 99
    spyOn(@tegNgScrollElementTop, 'getScrollTop').andReturn 57
    spyOn(@tegNgScrollElementTop, 'getScrollLeft').andReturn 7
    @mockWindow.scrollTo = jasmine.createSpy()

    @tegNgScrollElementTop.scroll @element
    @$timeout.flush()

    expect(@mockWindow.scrollTo).toHaveBeenCalledWith(7, 146)

  it 'get page top scrolling position', ->
    @mockWindow.document =
      documentElement:
        scrollTop: 421

    result = @tegNgScrollElementTop.getScrollTop()
    expect(result).toBe 421

  it 'get page left scrolling position', ->
    @mockWindow.document =
      documentElement:
        scrollLeft: 132

    result = @tegNgScrollElementTop.getScrollLeft()
    expect(result).toBe 132
