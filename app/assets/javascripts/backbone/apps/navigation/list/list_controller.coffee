@App.module "Navigation.List", (List, App, Backbone, Marionette, $, _)->

  List.Controller =
    createNavigation: ->
      @data = App.request "navigation:entities"
      @navLayout = @getNavigationLayout()
      @addToAppRegion()

    getNavigationLayout: ->
      new List.Layout

    addToAppRegion: ->
      App.navigationRegion.show @navLayout

    changeRoute: (fragments) ->
      # eg [a,b] check navView for regiions: region_one ? a region_two? b
      # check whats available in

      # layout,
      # check how many levels to rerender
      for fragment, i in fragments
        region = @navLayout.getRegionLevel(i)
        console.log i
        #if(region.name != fragment )
          # create new region and show region
          #region.setName fragment

      #perform a loop and break out if at end or found something new

      #if route is different, then renderer the section level thats appropriate
