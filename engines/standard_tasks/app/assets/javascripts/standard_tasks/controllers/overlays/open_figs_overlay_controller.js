ETahi.OpenFigsOverlayController = ETahi.TaskController.extend({
  filter: null,

  figureUploadUrl: function() {
    return "/papers/" + this.get('litePaper.id') + "/figures";
  }.property('litePaper.id'),

  journals: [
    'PLoS Genet',
    'PLoS Biol',
    'PLoS ONE',
    'PLoS Comput Biol',
    'PLoS Negl Trop Dis'
  ],

  images: function() {
    var html = this.get('openFigsHtml');
    return $('article img', html).toArray().map(function(i) {
      return Ember.Object.create({
        alt: i.alt,
        src: i.src
      });
    });
  }.property('openFigsHtml'),

  filteredImages: function() {
    if (!this.get('filter')) return this.get('images');

    var currentFilter = this.get('filter');
    return this.get('images').filter(function(i) {
      return i.get('alt').indexOf(currentFilter) >= 0;
    });
  }.property('filter'),

  actions: {
    addFigure: function(image) {
      var postUrl = "/papers/" + this.get('litePaper.id') + "/figures";
      $.post(postUrl, {url: image.src});
      image.set('added', true);
    },

    filterJournals: function(filter) {
      console.log('===> filtering by:', filter);
      this.set('filter', filter);
    }
  }
});
