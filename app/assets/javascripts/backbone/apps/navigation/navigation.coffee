@App.module "Navigation", (Navigation, App, Backbone, Marionette, $, _) ->

  #Definitions...

  Navigation.on "start", ->
    Navigation.controller.start()
