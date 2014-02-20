describe 'TegNgScrollElementTop helper', ->
  beforeEach -> module('TedNgScrollElementTop')
  beforeEach ->
    @element = {}

  beforeEach(inject((@tegNgScrollElementTop) ->))

  describe 'is scrolling needed?', ->
    beforeEach -> @mockJQ.window = { scrollTop: -> 300 }

    it 'should be scolled', ->
      @element.offset = -> { top: 350 }
      result = @tegScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe true

    it 'should not scolled', ->
      @element.offset = -> { top: 310 }
      result = @tegScrollElementTop.scrollingIsNeeded(@element)
      expect(result).toBe false

  describe 'scroll to top if needed', ->
    describe 'when screen is short', ->
      beforeEach -> spyOn(@tegScrollElementTop, 'screenIsShort').andReturn true

      it 'checks if scrolling needed', ->
        spyOn @tegScrollElementTop, 'scrollingIsNeeded'
        @tegScrollElementTop.scrollIfNeeded @element
        expect(@tegScrollElementTop.scrollingIsNeeded).toHaveBeenCalledWith @element

    describe 'when screen is tall', ->
      beforeEach -> spyOn(@tegScrollElementTop, 'screenIsShort').andReturn false

      it 'does nothing', ->
        spyOn @tegScrollElementTop, 'scrollingIsNeeded'
        @tegScrollElementTop.scrollIfNeeded @element
        expect(@tegScrollElementTop.scrollingIsNeeded).not.toHaveBeenCalled()

    describe 'pulls to to when screen is short and scrolling is needed', ->
      beforeEach ->
        spyOn(@tegScrollElementTop, 'screenIsShort').andReturn true
        spyOn(@tegScrollElementTop, 'scrollingIsNeeded').andReturn true
        spyOn(@tegScrollElementTop, 'scroll').andReturn true

      it '', ->
        @tegScrollElementTop.scrollIfNeeded @element
        expect(@tegScrollElementTop.scroll).toHaveBeenCalledWith @element

  describe 'check if screen is short', ->
    it 'screen is short', ->
      @mockJQ.window = { height: -> 480 }
      expect(@tegScrollElementTop.screenIsShort()).toBe true

    it 'screen is tall', ->
      @mockJQ.window = { height: -> 800 }
      expect(@tegScrollElementTop.screenIsShort()).toBe false

  it 'scroll element to top of the page', ->
    @element.offset = -> { top: 200 }
    @mockJQ.htmlAndBody = { animate: -> }
    spyOn @mockJQ.htmlAndBody, 'animate'
    @tegScrollElementTop.scroll(@element)
    expect(@mockJQ.htmlAndBody.animate).toHaveBeenCalledWith({ scrollTop : 190 }, 300)

