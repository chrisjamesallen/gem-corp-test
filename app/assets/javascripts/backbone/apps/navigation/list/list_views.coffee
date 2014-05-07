@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->


  class List.TreeView extends Backbone.Marionette.CompositeView
    template: "navigation/tree_item",
    tagName: "ul"
    initialize: ->
      @collection = @model.nodes

#    appendHtml: (collectionView, itemView) ->
#      #not sure what this does
#      collectionView.$('li:first').append(itemView.el)

  class List.ItemView extends Backbone.Marionette.ItemView
    template: "navigation/tree_item"


  class List.TreeRoot extends Backbone.Marionette.CollectionView
    itemView: List.TreeView


