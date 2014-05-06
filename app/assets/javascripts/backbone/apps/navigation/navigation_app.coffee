@App.module "Navigation", (Navigation, App, Backbone, Marionette, $, _) ->

  class Navigation.Router extends Marionette.AppRouter
    appRoutes:
      ":s1/:s2/:s3": "route"
      ":s1/:s2": "route"
      ":s1": "route"
      ".*": "route"

  API =
    route: ->
     console.log('route ->', arguments) #looking at argument lenght we can determine section to grab
     Navigation.List.Controller.changeRoute arguments
     #most basic, take the fragments and send to navigation controller

  # Add any Module Vents here...

  Navigation.on "start", ->
    new Navigation.Router
      controller: API
    Navigation.List.Controller.createNavigation()