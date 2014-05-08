@App.module "Navigation", (Navigation, App, Backbone, Marionette, $, _) ->


  Navigation.controller =
    start: ->
#      new Navigation.Router {controller: Navigation.controller.API }       #omited for now
      App.vent.on "route:change", _.bind(@route, @)
      Navigation.List.Controller.createNavigation()

    route:(tree) ->
      Navigation.List.Controller.changeRoute arguments

    API:
      route: ->
        console.log('route ->', arguments)
        Navigation.List.Controller.changeRoute arguments
