@App.module "Navigation", (Navigation, App, Backbone, Marionette, $, _) ->



  Navigation.controller =
    start: ->
      new Navigation.Router {controller: @API}
      Navigation.List.Controller.createNavigation()

    API:
      route: ->
        console.log('route ->', arguments)
        Navigation.List.Controller.changeRoute arguments


  # Define Router

  class Navigation.Router extends Marionette.AppRouter
    appRoutes:
      ":s1/:s2/:s3": "route"
      ":s1/:s2": "route"
      ":s1": "route"
      ".*": "route"




  Navigation.on "start", ->
    Navigation.controller.start()


