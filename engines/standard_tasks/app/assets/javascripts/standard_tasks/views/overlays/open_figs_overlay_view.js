ETahi.OpenFigsOverlayView = ETahi.OverlayView.extend({
  templateName: "standard_tasks/overlays/open_figs_overlay",
  layoutName: "layouts/overlay_layout",

  setup: function() {
    var html = this.controller.get('openFigsHtml');
    var images = $('article img', html).map(function(_, i) {
      return { url: i.src, alt: i.alt };
    });
    this.set('images', images.toArray());
  }.on('didInsertElement')
});
