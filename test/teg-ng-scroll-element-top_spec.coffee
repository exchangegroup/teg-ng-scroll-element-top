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

  beforeEach -> spyOn(@tegNgScrollElementTop, 'getScrollTop').andReturn 300

  describe 'is scrolling needed?', ->
    it 'should scoll', ->
      @elementTop = 350
      result = @tegNgScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe true

    it 'should not scoll', ->
      @elementTop = 310
      result = @tegNgScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe false

  # describe 'scroll to top if needed', ->
  #   describe 'when screen is short', ->
  #     beforeEach -> spyOn(@tegScrollElementTop, 'screenIsShort').andReturn true

  #     it 'checks if scrolling needed', ->
  #       spyOn @tegScrollElementTop, 'scrollingIsNeeded'
  #       @tegScrollElementTop.scrollIfNeeded @element
  #       expect(@tegScrollElementTop.scrollingIsNeeded).toHaveBeenCalledWith @element

  #   describe 'when screen is tall', ->
  #     beforeEach -> spyOn(@tegScrollElementTop, 'screenIsShort').andReturn false

  #     it 'does nothing', ->
  #       spyOn @tegScrollElementTop, 'scrollingIsNeeded'
  #       @tegScrollElementTop.scrollIfNeeded @element
  #       expect(@tegScrollElementTop.scrollingIsNeeded).not.toHaveBeenCalled()

  #   describe 'pulls to to when screen is short and scrolling is needed', ->
  #     beforeEach ->
  #       spyOn(@tegScrollElementTop, 'screenIsShort').andReturn true
  #       spyOn(@tegScrollElementTop, 'scrollingIsNeeded').andReturn true
  #       spyOn(@tegScrollElementTop, 'scroll').andReturn true

  #     it '', ->
  #       @tegScrollElementTop.scrollIfNeeded @element
  #       expect(@tegScrollElementTop.scroll).toHaveBeenCalledWith @element

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
    # @element.offset = -> { top: 200 }
    # @mockJQ.htmlAndBody = { animate: -> }
    # spyOn @mockJQ.htmlAndBody, 'animate'
    # @tegNgScrollElementTop.scroll(@element)
    # expect(@mockJQ.htmlAndBody.animate).toHaveBeenCalledWith({ scrollTop : 190 }, 300)

