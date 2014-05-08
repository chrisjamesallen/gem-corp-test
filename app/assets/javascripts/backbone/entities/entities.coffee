@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  # API

  API =
    getNavigationData: ->
      new Entities.TreeNode window.data

  # Set Handlers

  App.reqres.setHandler "navigation:entities", ->
    API.getNavigationData()


  # Define Entities

  class Entities.TreeNode extends Entities.Model
    initialize: ->
      nodes  = @.get('nodes')
      if(nodes)
        # so create a property nodes and assign a new collection if sub nodes are available
        @nodes = new Entities.TreeNodeCollection nodes
        @unset "nodes"

    resetHighlights: ()->
      nodes = @nodes
      recursive = (node, index, items) ->
        node.set('highlight',false)
        if node.get('nodes')
          node.get('nodes').each recursive

      @nodes.each recursive


  class Entities.TreeNodeCollection extends Entities.Collection
    model: Entities.TreeNode

