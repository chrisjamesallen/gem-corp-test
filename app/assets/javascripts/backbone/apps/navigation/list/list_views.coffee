@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  class List.TreeBranchView extends Backbone.Marionette.CompositeView
    template: "navigation/tree_item"
    tagName: "ul"
    initialize: ->
      if(@model)
        @collection = @model.nodes


  class List.TreeView  extends Backbone.Marionette.CompositeView
    tagName: "ul"
    template: "navigation/tree",
    itemView: List.TreeBranchView
    initialize: ->
      if(@model)
        @collection = @model.nodes

#    appendHtml: (collectionView, itemView) ->
#      #not sure what this does
#      collectionView.$('li:first').append(itemView.el)



  class List.TreeRegion extends Backbone.Marionette.Region
    template: "navigation/navigation_tree",
    el: '#Navigation'
    promise: null
    promise_animate_in: null
    promise_animate_out: null

    callbacks: {
      complete: =>
        console.log "animation complete!"
        @close
        @attachView @bufferView

      stop: =>
        console.log "animation fail!"
        @promise_animate_in.reject()
        @promise_animate_out.reject()

    }

    el_callbacks: {
      success: =>
        console.log "el  show view"
        debugger;
        @promise.resolve()

      fail: =>
        console.log "el fail"
        @promise.reject()
        #kill animation promises if still happening
        @bufferView.$el.stop()
        @currentView.$el.stop()
        @close #this deletes current view
        @currentView = @bufferView

    }

    swap: (view) ->
      if(@currentView and @currentView != view)
        #basically fade out current region and fade in targetRegion
        if @promise
          @promise.reject()
        # reassign defer
        @promise = $.Deferred()
        @promise.then( (=>@callbacks.complete), (=>@callbacks.stop)  )

        console.log("render", view)
        #switch
        @bufferView = view
        @bufferView.render()
        @bufferView.$el.insertAfter(@currentView.$el)

        # create when promise for completing both animations
        $.when( @animateIn @bufferView, @animateOut @currentView  ).then( (=>@el_callbacks.success), (=>@el_callbacks.fail) )

      else
        @show view
        @currentView = view


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

