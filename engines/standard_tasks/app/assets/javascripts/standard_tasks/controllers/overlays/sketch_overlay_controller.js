ETahi.SketchOverlayController = ETahi.TaskController.extend({
  actions: {
    saveImage: function(data) {
      var image = this.get('whiteboardImage') || this.store.createRecord('whiteboardImage')
      image.set('task', this.get('model'));
      image.set('data', data);
      image.save();
    }
  }
});
