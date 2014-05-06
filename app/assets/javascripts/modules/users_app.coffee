@App.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "users/:id/edit":"editUser"
      "users/:id":"showUser"
      "users":"listUsers"

  API =
    editUser: (id) ->
      UsersApp.Edit.Controller.editUser id

    showUser: (id) ->
      UsersApp.Show.Controller.showUser id

    listUser: ->
      UsersApp.List.Controller.listUsers()

  App.vent.on "edit:user", (user) ->
    Backbone.history.navigate "users/#{user.id}/edit" #manually update router
    API.editUser user:id

  App.addInitializer ->
    new UsersApp.Router
      controller: API




