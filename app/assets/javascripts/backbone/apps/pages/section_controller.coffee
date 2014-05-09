@App.module "Pages", (Pages, App, Backbone, Marionette, $, _) ->

  # lets determine all the page types on the site

  # home page
  # basic
  # video
  #

  Pages.controller =
    start: ->
      console.log( 'starting page controller')
      @treeNode = App.request("tree:entities")
      @region = App.pageRegion = new Pages.Region
      App.vent.on "route:change", _.bind(@route, @)

    route: (treeList, node) ->
      # lets look at the route, pick up the correct node
      # for now lets just make a quick swap on region
      page = new Pages.Basic({ model: node })
      @region.swap page
      page.showContent()
      # here we can start building the swapping view, how do we grab different pages
      # look at the node, is this is a


