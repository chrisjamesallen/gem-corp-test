App.Routers.Apps = Backbone.Router.extend({
  routes: {
    ':s1/:s2/:s3':'tierChange',
    ':s1/:s2':'tierChange',
    ':s1':'tierChange',
    'about_us':'about_us',
    'our_projects':'projects',
    'invest':'invest',
    'media':'media',
    'our_commitment':'our_commitment',
    'contact_us':'contact_us'
  },

  tierChange: function(){
    app.trigger('route:tier',arguments.length);
  },

  about_us: function(){
    console.log('about us');
  },

  our_projects: function(){
    console.log('our projects');
  },

  invest: function(){
    console.log('invest');
  },

  media: function(){
    console.log('media');
  },

  our_commitment: function(){
    console.log('our commitment');
  },

  contact_us: function(){
    console.log('contact us');
  }

});
