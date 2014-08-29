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
      var fullCaption = i.alt;
      var citationIndex = fullCaption.indexOf('Citation:');
      var caption = fullCaption.substr(citationIndex).substr(0, 255);
      var titleIndexStart = fullCaption.indexOf('.') + 2;
      var titleIndexEnd = citationIndex - 11;
      var title = fullCaption.substr(titleIndexStart, titleIndexEnd);

      return Ember.Object.create({
        alt: i.alt,
        src: i.src,
        caption: caption,
        title: title
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
      var store = this.store;

      $.post(postUrl, {url: image.src}, function(data) {
        store.pushPayload('figure', data);
        store.getById('figure', data.figure.id).
          set('caption', image.get('caption')).
          save();
      });
      image.set('added', true);
    },

    filterJournals: function(filter) {
      this.set('filter', filter);
    }
  }
});
