@App = do (Backbone, Marionette) ->

  `_.mixin(_.str.exports());`

  App = new Marionette.Application();

  App.addRegions
    navigationRegion: "#Navigation"
    pageRegion: "#Page"
    footerRegion: "#Footer"

  App.addInitializer ->
    App.module("Navigation").start()

  App.on "initialize:after", (options) ->
    if Backbone.history
        Backbone.history.start({ pushState: true })

  App

