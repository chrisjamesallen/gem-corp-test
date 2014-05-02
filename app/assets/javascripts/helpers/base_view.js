_.extend(Backbone.View.prototype,  {

  initialize: function() {
    this.subViews = [];
    this.name = '';
    this.parentView = null;
    this.state = new Backbone.Model();
    this.setTransition();
  },

  super: function(fn,args){
    var fn_ = this.constructor.__super__[fn];
    if (fn_) {
      this.constructor.__super__[fn].apply(this, args || arguments.callee.caller.arguments);
    }
  },

  destroy: function() {
    this.stopListening();
    this.removeAllChildViews();
    this.remove();
    //remove from parent here?
  },

  leave: function(transition) {
    var deferred;
    deferred = this.transitionOut(transition);

    deferred.done(_.bind(function() {
      debugger;
      this.destroy();
    }, this));

    return deferred;
  },

  setTransition: function(){
    this.animation = TweenMax.from(this.$el, 3,{});
  },

  transitionOut: function(transition) {
    var d= $.Deferred();
    this.state.set('defer:transition', d);
    this.animation.updateTo({'opacity':0},true);
    return  d;
  },

  transitionIn: function(transition) {
    var d= $.Deferred();
    this.state.set('defer:transition', d);
    this.animation.updateTo({'opacity':1},true);
    return  d;
  },

  addSubview: function(view) {
    this.subViews.push(view);
    view.parentView = this;
    //if view not in dom, call render
    if (!jQuery.contains($('body').get(0), view.$el.get(0))) {
      view.$el.appendTo(this.$el);
      view.render();
    }
  },

  removeChild: function(view, removeFn) {
    var viewIndex = _.indexOf(this.subViews, view);
    if(viewIndex){
      this.subViews.splice(viewIndex,1);
      if(removeFn){
        removeFn(view);
      }else{
        view.destroy();
      }
    }
  },

  removeAllChildViews: function(){
    _.each(this.subViews, function(childView) {
      childView.destroy();
    });    
  },

  _bind: function(fn,args){
    return _.bind(fn,this, args);
  }

});
