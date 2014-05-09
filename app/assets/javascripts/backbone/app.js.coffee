@App = do (Backbone, Marionette) ->

  `_.mixin(_.str.exports());`


  class Router extends Marionette.AppRouter
    appRoutes:
      "*path": "route"


  API = {
    route: (url) ->
      routeTree = _.ltrim(url).split('/')
      @treeNode = @treeNode ? App.request("tree:entities")
      @treeNode.pickNode(routeTree)
      App.vent.trigger("route:change", routeTree, @treeNode)
  }

  App = new Marionette.Application();
  App.router = new Router {controller: API }
  App.addRegions
    navigationRegion: "#Navigation"
    pageRegion: "#Pages"
    footerRegion: "#Footer"

  App.addInitializer ->
    App.module("Navigation").start()
    App.module("Pages").start()

  App.on "initialize:after", (options) ->
    if Backbone.history
        Backbone.history.start({ pushState: true })

  App

