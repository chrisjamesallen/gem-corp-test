@App.module "Pages", (Pages, App, Backbone, Marionette, $, _) ->

  #Definitions...

  class Pages.Region extends Backbone.Marionette.Region
    template: "pages/main_region",
    el: '#Pages'


  class Pages.Basic extends Backbone.Marionette.ItemView
    template: "data/default"
    className: 'page basic'


  Pages.on "start", ->
    Pages.controller.start()