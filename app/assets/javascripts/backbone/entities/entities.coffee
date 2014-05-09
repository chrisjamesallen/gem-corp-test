@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.TreeNode extends Entities.Model
    initialize: ->
      nodes  = @.get('nodes')
      if(nodes)
        # so create a property nodes and assign a new collection if sub nodes are available
        @nodes = new Entities.TreeNodeCollection nodes
        @unset "nodes"
    pickNode: (fragments) ->
      f=0
      fragment = "";
      leaf = @nodes #so pick up first fragment
      node = leaf
      if _.isEmpty(fragments)
        return @

      while leaf
        fragment += fragments[f++] + "/"
        leaf = leaf.findWhere({ slug: _.rtrim(fragment,"/") })
        if !leaf
          break;
        node = leaf
        if !fragments[f]
          break;
        if !leaf.nodes
          break;
        leaf = leaf.nodes #nodes become new leaf/branch
      console.log('node', node)
      node




    resetHighlights: ()->
      nodes = @nodes
      recursive = (node, index, items) ->
        node.set('highlight',false)
        if node.get('nodes')
          node.get('nodes').each recursive

      @nodes.each recursive


  class Entities.TreeNodeCollection extends Entities.Collection
    model: Entities.TreeNode


  # API

  API =
    getNavigationData: ->
      @data = @data ? new Entities.TreeNode window.data

  App.reqres.setHandler "tree:entities", ->
    API.getNavigationData()
