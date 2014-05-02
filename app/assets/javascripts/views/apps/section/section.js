App.Views.Section = Backbone.View.extend({

  template: JST['section/section'],
  className: "section",

  render: function(){
    this.$el.html(this.template());
    return this;
  }


});
