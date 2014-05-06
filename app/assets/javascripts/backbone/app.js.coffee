@App = do (Backbone, Marionette) ->
  App = new Marionette.Application();
  App.addRegions
    navigationRegion: "#Navigation"
  App.addInitializer ->
    App.module("Navigation").start()

  App.on "initialize:after", (options) ->
    if Backbone.history
        Backbone.history.start()

  App

