@App.module "Navigation", (Navigation, App, Backbone, Marionette, $, _) ->


  Navigation.controller =
    start: ->
      new Navigation.Router {controller: @API}
      Navigation.List.Controller.createNavigation()

    API:
      route: ->
        console.log('route ->', arguments)
        Navigation.List.Controller.changeRoute arguments


  Navigation.on "start", ->
    Navigation.controller.start()


