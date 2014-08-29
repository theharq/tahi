ETahi.SketchOverlayView = ETahi.OverlayView.extend({
  templateName: "standard_tasks/overlays/sketch_overlay",
  layoutName: "layouts/overlay_layout",

  setup: function() {
    var self = this;
    var tools = this.$('.sketch-tools');

    $.each(['#f00', '#ff0', '#0f0', '#0ff', '#00f', '#f0f', '#000', '#fff'], function() {
      tools.append("<a class='sketch-control' href='#colors-sketch' data-color='" + this + "' style='background: " + this + ";'></a> ");
    });

    tools.append('<span>&nbsp; &nbsp;</span>');

    $.each([3, 5, 10, 15], function() {
      tools.append("<a href='#colors-sketch' class='sketch-control sketch-pencil-size sketch-pencil-size-" + this + "' data-size='" + this + "' style='background: #ccc'>" + this + "</a> ");
    });

    $('#colors-sketch').sketch();
  }.on('didInsertElement')
});
