@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  List.Controller =
    createNavigation: ->
      @treeNodes = App.request "navigation:entities"
      @regionView = new List.TreeRegion
      window.controller = @
      App.navigationRegion = @regionView
      @view = @createTreeView @treeNodes
      @show()

    show: ->
      @regionView.show @view

    createTreeView: (collection) ->
      new List.TreeView { "collection": collection }

    changeRoute: (fragments) ->
      f = 0;
      i = 0;
      fragment;
      tree = @treeNodes;
      newtree = new App.Entities.Collection
      node = tree #so pick up first fragment

      while node
         fragment = fragments[f++]
         if !fragment
           break;

         node = node.findWhere({ nodeName: fragment })
         if !node
           break;

         newtree.add node

         if !node.nodes
           break;
         node = node.nodes


      if(newtree.length)
        # create a new tree view
        @view = @createTreeView newtree
        @show()

