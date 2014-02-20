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

  beforeEach(inject((@tegNgScrollElementTop) ->))

  describe 'is scrolling needed?', ->
    beforeEach ->
      spyOn(@tegNgScrollElementTop, 'getScrollTop').andReturn 300

    it 'should scoll', ->
      @elementTop = 350
      result = @tegNgScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe true

    it 'should not scoll', ->
      @elementTop = 310
      result = @tegNgScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe false

  describe 'scroll to top if needed', ->
    describe 'when screen is short', ->
      beforeEach -> spyOn(@tegNgScrollElementTop, 'screenIsShort').andReturn true

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

    describe 'pulls to to when screen is short and scrolling is needed', ->
      beforeEach ->
        spyOn(@tegNgScrollElementTop, 'screenIsShort').andReturn true
        spyOn(@tegNgScrollElementTop, 'scrollingIsNeeded').andReturn true
        spyOn(@tegNgScrollElementTop, 'scroll').andReturn true

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
    spyOn(@tegNgScrollElementTop, 'getScrollLeft').andReturn 7
    @mockWindow.scrollTo = jasmine.createSpy()
    @elementTop = 200
    @tegNgScrollElementTop.scroll @element
    expect(@mockWindow.scrollTo).toHaveBeenCalledWith(7, 190)