@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  class List.Layout extends Marionette.Layout
    template: "navigation/templates/layout"
    regionCollections: []
    #setRegionCollections: ->
      #push each section into each region level
    getRegionLevel: (index) ->
      if(@regions["section" + index])
      else
        console.log('define new region')
        #@addRegion "section" + index, '#s1'
    #task, create regions based on multi composite views
    #task, on request change these views
    #containsSection: (section) ->
      #look up section


  class List.Item extends Marionette.ItemView
    template: 'navigation/templates/item'
    #within check content for children

  #within each item create a heierachy
  class List.Section extends Marionette.CompositeView
    template: 'navigation/templates/navigation'
    itemView: List.Item
    setName: (name) ->
      @name = name