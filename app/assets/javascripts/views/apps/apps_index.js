App.Views.AppsIndex = Backbone.View.extend({

  template: JST['apps/index'],
  id: "App",

  render: function(){
    this.$el.appendTo($('body'));
    //create x number of swappable views
    this.addSwappingView('section 1');
    this.addSwappingView('section 2');
    this.addSwappingView('section 3');
    this.currentView = _.first(this.subViews);
    this.listenTo(this, 'route:tier', _.bind(this.swapToTier,this));
    return this;
  },

  addSwappingView: function(name){
    var view;
    view = new App.Views.Section({className:'full-screen large-text centered'});
    this.addSubview(view);
    view.name = name;
    view.$el.html(name);
  },


  swapToTier: function(tier) {
    var target, current, defer;
    console.log('swap to tier',tier);
    target = this.subViews[tier];
    current = this.currentView;
    if(target !== current){
      console.log('going for a swap...');
      //do i need to reject animation?
      this.cancelDeferrer();
      this.newDeferrer(current.transitionIn(), target.transitionOut());
      this.currentView = target;//swap old current with target
    }
  },

  cancelDeferrer: function(){
    var d;
    d = this.deferTransition;
    if(d){
      d.resolve();//resolve exisiting
    }
  },

  newDeferrer: function(viewIn,viewOut){
    var d;
    this.deferTransition = $.Deferred(); //set new deferred
    d = this.deferTransition;
    //set when promise to call defer
    var w = $.when(viewIn,viewOut);
    w.then(d.resolve,d.reject,d.notify);
    //add callbacks
    finishedFn = this._bind(this.swapStateFinished), cancelledFn = this._bind(this.swapStateCancelled), progressFn = this._bind(this.swapStateProgress);
    this.deferTransition.then( finishedFn, cancelledFn, progressFn );
  },

  swapStateFinished: function(){
    console.log('>>>>>>>finished');
  },

  swapStateCancelled: function(){
    console.log('>>>>>>>cancelled');
  },

  swapStateProgress: function(){
    console.log('>>>>>>>progress');
  }


});
