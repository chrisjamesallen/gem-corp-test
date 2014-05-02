/*
* Gemfields Corporate
*
 * Events
  *
*
*
*
* */

window.App = {
  Models: {},
  Collections: {},
  Views: {},
  Support: {},
  Routers: {},
  initialize: function() {
    window.router = new App.Routers.Apps();
    window.app = new App.Views.AppsIndex();
    window.app.render();
    Backbone.history.start({pushState:false});
  }
};


$(document).ready(function(){
  App.initialize();
});
