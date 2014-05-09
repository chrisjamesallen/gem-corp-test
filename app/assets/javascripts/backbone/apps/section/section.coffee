@App.module "Sections", (Sections, App, Backbone, Marionette, $, _) ->

  class Sections.Region extends Backbone.Marionette.Region
    el: '#Pages'
    swapPageWithNode: (node) ->
      page = Sections.Pages.controller.createPageWithNode(node)
      @swap page

    swapTypes:{
      'default':'crossFade'
      'swipeDown':'swipeDown'
      'swipeUp':'swipeUp'
      'crossFade':'crossFade'
    }

    determineSwapType: ->
      #if newSection= x and oldSection=home (leave home section), swap = swipeDown
      #if newSection= home and oldsection=x (enter home section), swap = swipeUp
      #if newSection == OldSection (same section), swap = fadeInOut
      #if newSectopn != OldSection (different section), swap = fadeInOut
      if @getSection(@currentView) == 'home'
        @setEffectType("slideDown")

    getSection: (view)->
      view.model.get('section')





  Sections.on "start", ->
    Sections.controller.start()


  Sections.controller =
    start: ->
      @treeNode = App.request("tree:entities")
      @region = App.pageRegion = new Sections.Region()
      App.vent.on "route:change", _.bind(@route, @)

    route: (treeList, node) ->
      @region.swapPageWithNode(node)




# so sections do the following things
# swapping transition logic based on section type comparison
# eg section:home page to section:base page == slideup
# swapping transition logic based on sub page transition

# so section has a 'page' region
# from node find out two things:
# transition type
# page type

# check node for swap type
# check node