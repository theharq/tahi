ETahi.TutorialOverlayView = ETahi.OverlayView.extend({
  templateName: "standard_tasks/overlays/tutorial_overlay",
  layoutName: "layouts/overlay_layout",

  setup: function() {

    $('#tahi-tour').click(function(){
      hopscotch.startTour(cardTutorial)
    });

  }.on('didInsertElement')
});
