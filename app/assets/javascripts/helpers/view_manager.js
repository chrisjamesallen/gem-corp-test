_.extend( Backbone.View.prototype,  {

  swap: function(newView, transition, isChained) {

    var deferred = $.Deferred();

    isChained = isChained || false;
    transition = transition || {};

    if (isChained) {

      if (this.currentView) {
        this.currentView.leave(transition).done(_.bind(function() {
          $(this.el).append(newView.render(transition).el);
          this.currentView = newView;
          deferred.resolve();
        }, this));
      } else {
        $(this.el).append(newView.render(transition).el);
        this.currentView = newView;
        deferred.resolve();
      }

    } else {

      // Destroy current view
      if (this.currentView && this.currentView.leave) {
        this.currentView.leave(transition);
      }

      $(this.el).append(newView.render(transition).el);
      this.currentView = newView;
      deferred.resolve();
    }

    return deferred;
  }
});

