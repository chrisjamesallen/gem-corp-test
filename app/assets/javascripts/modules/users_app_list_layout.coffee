@App.module "UsersApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends Marionette.Layout
    template: 'users/list/template/list_layout'
    regions:
      panelRegion: '#panel-region'
      asideRegion: '#aside-region'
      tableRegion: '#table-region'

  class List.Panel extends Marionette.ItemView
    template: "users/list/template/_panel"

  # A Panel type

  class List.User extends Marionette.ItemView
    template: "users/list/template/_user"
    events:
      "click a.edit" : -> @trigger "edit:user", @model

  class List.Users extends Marionette.CompositeView
    template: "users/list/template/_users"
    itemView: List.User
    itemViewContainer: "tbody"