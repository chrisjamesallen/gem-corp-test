@App.module "Navigation", (Navigation, App, Backbone, Marionette, $, _) ->

  #Definitions...

  class Navigation.Router extends Marionette.AppRouter
    appRoutes:
      ":s1/:s2/:s3": "route"
      ":s1/:s2": "route"
      ":s1": "route"
      ".*": "route"


