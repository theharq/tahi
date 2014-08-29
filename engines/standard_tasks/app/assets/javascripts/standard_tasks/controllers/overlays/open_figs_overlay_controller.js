ETahi.OpenFigsOverlayController = ETahi.TaskController.extend({
  figureUploadUrl: function() {
    return "/papers/" + this.get('litePaper.id') + "/figures";
  }.property('litePaper.id'),

  actions: {
    addFigure: function(image) {
      var postUrl = "/papers/" + this.get('litePaper.id') + "/figures";
      $.post(postUrl, {url: image.url});
    }
  }
});
