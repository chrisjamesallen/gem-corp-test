@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  List.Controller =
    createNavigation: ->
      @treeNodes = App.request "navigation:entities"
      @view = new List.TreeRoot { collection: @treeNodes }
      window.controller = @
      @showAsAppRegion()

    showAsAppRegion: ->
      App.navigationRegion.show @view

    changeRoute: (fragments) ->
      f = 0;
      i = 0;
      fragment;
      tree = @treeNodes;
      @newtree = new App.Entities.Collection
      node = tree #so pick up first fragment

      while node
         fragment = fragments[f++]
         if !fragment
           break;

         node = node.findWhere({ nodeName: fragment })
         if !node
           break;

         @newtree.add node
         #console.log node

         if !node.nodes
           break;
         node = node.nodes

      if(@newtree.length)
        @view.collection = @newtree
        @view.render()

