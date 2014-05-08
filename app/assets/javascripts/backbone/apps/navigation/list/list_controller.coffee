@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  List.Controller =
    createNavigation: ->
      @treeNode = App.request("navigation:entities")
      @regionView = new List.TreeRegion
      App.navigationRegion = @regionView
      @view = new List.TreeView { "model": @treeNode }
      @regionView.swap @view
      window.controller = @

    changeRoute: (fragments) ->
      f = 0;
      i = 0;
      fragment = "";
      @treeNode.resetHighlights()
      tree = @treeNode;
      newtree = new App.Entities.Collection
      newtree.add tree
      leaf = tree.nodes #so pick up first fragment
      if _.isEmpty(fragments)
        newtree.add @treeNode.models
        leaf = false

      while leaf
         fragment += fragments[f++] + "/"
         console.log fragment
         if !fragments[f-1]
           break;
         leaf = leaf.findWhere({ slug: _.rtrim(fragment,"/") })
         leaf.set('highlight', true);
         if !leaf
           break;
         newtree.add leaf if fragments[f]
         if !leaf.nodes
           console.log "nono theres no nodes" , leaf
           break;
         leaf = leaf.nodes #nodes become new leaf/branch

      if(newtree.length)
        # create a new tree view
        @nodes = newtree
        @view = new List.TreeView { "collection": newtree }
        @regionView.swap @view

