@App.module "Pages", (Pages, App, Backbone, Marionette, $, _) ->

  #Definitions...

  class Pages.Region extends Backbone.Marionette.Region
    template: "pages/main_region",
    el: '#Pages'

  Pages.on "start", ->
    Pages.controller.start()