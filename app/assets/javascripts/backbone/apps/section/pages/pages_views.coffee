@App.module "Sections.Pages", (Pages, App, Backbone, Marionette, $, _) ->




  class Pages.Basic extends Backbone.Marionette.Layout
    className: 'page basic'
    template: 'pages/basic'
    regions:{
      content: '.content'
    }
    onShow: ->
      #now rendered add content view to region
      content = new Pages.PageContent({model:@model})
      @content.show content


  class Pages.PageContent extends Backbone.Marionette.ItemView
    template: "data/default"
    className: "text"
