@App.module "Pages", (Pages, App, Backbone, Marionette, $, _) ->

  class Pages.Region extends Backbone.Marionette.Region
    template: 'pages/main_region',
    el: '#Pages'

  class Pages.Basic extends Backbone.Marionette.Layout
    className: 'page basic'
    template: 'pages/basic'
    regions:{
      content: '.content'
    }
    showContent: ->
      if @model
        content = new Pages.PageContent({model:@model})
        @content.show content

  class Pages.PageContent extends Backbone.Marionette.ItemView
    template: "data/default"
    className: "text"

  Pages.on "start", ->
    Pages.controller.start()