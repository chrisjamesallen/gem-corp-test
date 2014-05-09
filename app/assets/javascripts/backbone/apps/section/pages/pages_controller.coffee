@App.module "Sections.Pages", (Pages, App, Backbone, Marionette, $, _) ->

  Pages.controller =
    pageTypes: {
      "default" : "Pages.Basic"
    }
    createPageWithNode: (node) ->
      pageType = node.get('type') ? "default"
      page = eval( Pages.controller.pageTypes[pageType] )
      new page({ model: node })

