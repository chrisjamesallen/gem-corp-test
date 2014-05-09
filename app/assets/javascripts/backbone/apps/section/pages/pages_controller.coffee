@App.module "Sections.Pages", (Pages, App, Backbone, Marionette, $, _) ->

  Pages.controller =
    count:0
    pageTypes: {
      "default" : "Pages.Basic"
      "video" : "Pages.Video"
    }
    createPageWithNode: (node) ->
      @count +=1
      pageType = node.get('type') ? "video"
      page = eval( Pages.controller.pageTypes[_.sample(["default","video"])] )
      page = new page({ model: node })
      page.$el.attr('count',@count)
      page

