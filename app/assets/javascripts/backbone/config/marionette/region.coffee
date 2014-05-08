SwappingRegionExtend =
    promise: null
    promise_animate_in: null
    promise_animate_out: null

    callbacks: {
      complete: ->
        #console.log "swap complete!"
        @close()
        @attachView @bufferView
        @bufferView = null

      stop: ->
        #console.log "animation stopped!"
        @promise_animate_in.reject() #cancel 'when' promise from resolving
        @bufferView.$el.stop()
        @currentView.$el.stop()
        @close() #this deletes current view
        @attachView @bufferView

      animationSuccess: ->
        #console.log "animation success!"
        @promise.resolve()
    }



    swap: (view) ->
      if(@currentView and @currentView != view)
        # go for a swap
        console.log "swapping"
        @setDeferrer()
        # add new bufferview after currentview
        @bufferView = view
        @bufferView.render()
        @bufferView.$el.insertAfter(@currentView.$el)
        # when animate finishes resolve main object deferrer
        $.when( (@animateIn @bufferView), (@animateOut @currentView)  ).then( _.bind(@callbacks.animationSuccess, this)  )

      else
        #console.log "going for a swap"
        @show view
        @currentView = view

    setDeferrer: ->
      if @promise # reject any previous promise
        @promise.reject()#stop any animation, remove oldest view and assign buffer as current
      # reconfigure new deferrer
      @promise = $.Deferred()
      @promise.then( _.bind(@callbacks.complete, this) , _.bind(@callbacks.stop, this)  )

    animateIn: (view) ->
      @promise_animate_in = $.Deferred()
      defer = @promise_animate_in
      if view
        view.$el.fadeIn 1000, ()=>
          defer.resolve()
      else
        defer.reject()
      defer

    animateOut: (view) ->
      @promise_animate_out = $.Deferred()
      defer = @promise_animate_out
      if view
        view.$el.fadeOut 1000, ()=>
          defer.resolve()
      else
        defer.reject()
      defer


Backbone.Marionette.Region.prototype extends SwappingRegionExtend
