@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->


  API =
    getNavigationData: ->
      new Entities.TreeNodeCollection window.data.structure

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

  class Entities.TreeNodeCollection extends Entities.Collection
    model: Entities.TreeNode
