@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->


  class List.TreeView extends Backbone.Marionette.CompositeView
    template: "navigation/templates/tree_item",
    tagName: "ul"
    initialize: ->
      @collection = @model.nodes

    appendHtml: (collectionView, itemView) ->
      #not sure what this does
      collectionView.$('li:first').append(itemView.el)


  class List.TreeRoot extends Backbone.Marionette.CollectionView
    itemView: List.TreeView


