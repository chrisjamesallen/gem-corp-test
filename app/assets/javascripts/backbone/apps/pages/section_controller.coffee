@App.module "Pages", (Pages, App, Backbone, Marionette, $, _) ->


  Pages.controller =
    start: ->
      @region = App.pageRegion = new Pages.Region
      App.vent.on "route:change", _.bind(@route, @)

    route: (tree) ->
      # here we can start building the swapping view, how do we grab different pages

