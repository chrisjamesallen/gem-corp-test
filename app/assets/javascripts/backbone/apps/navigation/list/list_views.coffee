@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  class List.TreeItem extends Backbone.Marionette.ItemView
    template: "navigation/tree_item"
    tagName: "li"
    className: "page"
    initialize: ->
      if(@model.get('highlight'))
        @$el.addClass('highlight')


  class List.TreeBranchView extends Backbone.Marionette.CollectionView
    template: "navigation/tree_item"
    tagName: "ul"
    className: "tier"
    itemView: List.TreeItem
    initialize: ->
      if(@model)
        @collection = @model.nodes

  #so take
  class List.TreeView extends Backbone.Marionette.CollectionView
    tagName: "ul"
    className: "main collection"
    template: "navigation/tree_item",
    itemView: List.TreeBranchView
    initialize: ->
      if(@model)
        @collection = @model.nodes


  class List.TreeRegion extends Backbone.Marionette.Region
    template: "navigation/navigation_tree",
    el: '#Navigation'

