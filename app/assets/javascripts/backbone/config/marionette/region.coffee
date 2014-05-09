RegionAnimationExtend =

  # Public
  effectType: 'crossFade'

  swap: (view) ->
    if(@currentView and @currentView != view)
      @setDeferrer_()
      @newTween_()
      @bufferView = view
      @bufferView.render()
      Marionette.triggerMethod.call(@bufferView, "show");
      @bufferView.$el.insertAfter(@currentView.$el)
      console.log "go for a swap",@effectType
      $.when( (@transitionIn_ @bufferView), (@transitionOut_ @currentView)  ).then( _.bind(@swapCallbacks_.animationSuccess, this)  )
    else
      @show view
      @currentView = view

  setEffectType: (type) ->
    @effectType = if @effects_[type] then type else @defaultEffectType

  # Private

  defaultEffectType_: 'crossFade'

  effects_: {

    crossFade: (transition, view, deferrer)->
      if transition == 'in'
        tween.from(view.$el, 2, { opacity:1 });
        tween.call(  (=>deferrer.resolve()) )
      else
        tween.to(view.$el, 2, { opacity: 0 },"-=2");
        tween.call( (=>deferrer.resolve()) )

    slideUp: ()->

    slideDown: (transition, view, deferrer, tween)->
      if transition == 'in'
        tween.from(view.$el, 2, { top: -view.$el.height() });
        tween.call(  (=>deferrer.resolve()) )
      else
        tween.to(view.$el, 2, { top: view.$el.height() },"-=2");
        tween.call( (=>deferrer.resolve()) )

  }

  promise_: null

  promiseIn_: null

  promiseOut_: null

  swapCallbacks_: {
    complete: ->
      @close()
      @attachView @bufferView
      @bufferView = null
      console.log 'completed swap'

    stop: ->
      # cancel just one promise from the 'when' promise_ to prevent resolve...
      @promiseIn_.reject()
      @close() #this deletes current view
      @attachView @bufferView #attach existing view
      @removeAnimation_() #just to be safe
      console.log 'swap stopped'

    animationSuccess: ->
      console.log 'animation success!'
      @removeAnimation_() #just to be safe
      @promise_.resolve()
  }

  setDeferrer_: ->
    if @promise_ # reject any previous promise_
      @promise_.reject()#stop any animation, remove oldest view and assign buffer as current
    # reconfigure new deferrer
    @promise_ = $.Deferred()
    @promise_.then( _.bind(@swapCallbacks_.complete, this) , _.bind(@swapCallbacks_.stop, this)  )
    @promiseIn_ = $.Deferred()
    @promiseOut_ = $.Deferred()

  transitionIn_: (view) ->
    defer = @promiseIn_
    if view
      @effects_[@effectType]('in', @bufferView, @promiseIn_, @tween)
    else
      defer.reject()
    defer

  transitionOut_: (view) ->
    defer = @promiseOut_
    if view
      @effects_[@effectType]('out', @currentView, @promiseOut_, @tween)
    else
      defer.reject()
    defer

  removeAnimation_: () ->
    if @tween then @tween.kill()

  newTween_: () ->
    if @tween then @tween.kill()
    @tween = new TimelineLite()
    window.tw = @tween


Backbone.Marionette.Region.prototype extends RegionAnimationExtend
