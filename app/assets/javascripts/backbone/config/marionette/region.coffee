RegionAnimationExtend =

  # Public

  effectType: 'crossFade'

  swap: (view) ->
    if(@currentView and @currentView != view)
      @prepareTransition_()
      # setup new 'buffer' view
      @bufferView = view
      @bufferView.render()
      Marionette.triggerMethod.call(@bufferView, "show");
      @bufferView.$el.insertAfter(@currentView.$el)
      # animate
      console.log "swapping a to b",@currentView.$el.attr('count'), @bufferView.$el.attr('count')
      @animate_()
    else
      @show view
      @currentView = view

  setEffectType: (type) ->
    @effectType = if @effects_[type] then type else @defaultEffectType


  # Private

  defaultEffectType_: 'crossFade'

  effects_: {

    crossFade: (inView, outView, deferrer, tween)->
      tween.from(inView.$el, 2, { top: -inView.$el.height() });
      tween.to(outView.$el, 2, { top: outView.$el.height() },"-=2");
      tween.call( (=>deferrer.resolve()) )

    slideUp: (inView, outView, deferrer, tween)->
      tween.from(inView.$el, 2, { top: inView.$el.height() });
      tween.to(outView.$el, 2, { top: -outView.$el.height() },"-=2");
      tween.call( (=>deferrer.resolve()) )

    slideDown: (inView, outView, deferrer, tween)->
      tween.from(inView.$el, 2, { top: -inView.$el.height() });
      tween.to(outView.$el, 2, { top: outView.$el.height() },"-=2");
      tween.call( (=>deferrer.resolve()) )

  }

  promise_: null

  swapCallbacks_: {

    complete: ->
      @close()
      @attachView @bufferView
      @bufferView = null
      console.log 'completed swap'

    stop: ->
      # cancel just one promise from the 'when' promise_ to prevent resolve...
      @close() #this deletes current view
      @attachView @bufferView #attach existing view
      @killTween_() #just to be safe
      console.log 'swap stopped'

  }

  prepareTransition_:  ->
    @setDeferrer_()
    @setTween_()

  animate_: ->
    @setViewOverflow_()
    @effects_[@effectType](@bufferView,@currentView, @promise_,@tween)

  setViewOverflow_: ->
    @currentView.overflow = @currentView.$el.css('overflow')
    @bufferView.overflow = @bufferView.$el.css('overflow')
    height = $(window).height()
    @currentView.$el.height(height)
    @bufferView.$el.height(height)
    @bufferView.$el.css('overflow','hidden')
    @currentView.$el.css('overflow','hidden')

  setDeferrer_: ->
    if @promise_ # reject any previous promise_
      @promise_.reject()#stop any animation, remove oldest view and assign buffer as current
    # reconfigure new deferrer
    @promise_ = $.Deferred()
    @promise_.then( _.bind(@swapCallbacks_.complete, this) , _.bind(@swapCallbacks_.stop, this)  )

  setTween_: () ->
    if @tween then @tween.kill()
    @tween = new TimelineLite()
    window.tw = @tween

  killTween_: () ->
    if @tween then @tween.kill()

  releaseViewOverflow_: ->
    @bufferView.css('overflow',@bufferView.overflow)
    @currentView.css('overflow',@currentView.overflow)

Backbone.Marionette.Region.prototype extends RegionAnimationExtend
