$(function(){
  $(document).on("click", "a[href^='/']", function(event) {
    if (!event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey) {
      event.preventDefault();
      var url = $(event.currentTarget).attr('href').replace(/^\//, "");
      Backbone.history.navigate(url, {trigger:true});
    }
  })
})
