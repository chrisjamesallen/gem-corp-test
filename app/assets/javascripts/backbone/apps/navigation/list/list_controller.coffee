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



#var tree = new TreeNodeCollection(treeData);
#var treeView = new TreeRoot({
#  collection: tree
#});

#treeView.render();
#$("#tree").html(treeView.el);