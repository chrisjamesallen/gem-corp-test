@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.NavigationSection extends Entities.Model

  class Entities.NavigationCollection extends Entities.Collection
    model: Entities.NavigationSection

  API =
    getNavigationData: ->
      new Entities.NavigationCollection window.data.structure

  App.reqres.setHandler "navigation:entities", ->
    API.getNavigationData()