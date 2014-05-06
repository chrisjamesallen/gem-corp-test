@App.module "UsersApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    listUsers: ->
      users = App.request "user:entities"
      @layout = @getLayoutView()  #set layout view
      @layout.on "show", =>
        @showPanel users
        @listUsers users
      App.mainRegion.show @layout

    listUsers: (users) ->
      usersview = @getUsersView users
      usersView.on "itemview:edit:user", (iv, user) ->
        App.vent.trigger "edit:user", user
      @layout.tableRegion.show usersView

    getUsersView: (users) ->
      new List.Users
        collection: users

    getLayoutView: ->
      new List.Layout

    showPanel: (users) ->
      panelView  = @getPanelView users
      @layout.panelRegion.show panelView

    getPanelView: (users) ->
      new List.Panel
        collection: users

    getLayoutView: ->
      new List.Layout

