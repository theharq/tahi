ETahi.NotesOverlayView = ETahi.OverlayView.extend({
  templateName: "standard_tasks/overlays/notes_overlay",
  layoutName: "layouts/overlay_layout",

  setup: function() {
  }.on('didInsertElement')
});

ETahi.NotesView = Ember.View.extend({
  templateName: "standard_tasks/notes",
  // layoutName: "layouts/overlay_layout",

  setup: function() {
  }.on('didInsertElement')
});

ETahi.NotesRoute = Ember.Route.extend({
  model: function() {
    this.store.find('notes')
  }
});

ETahi.Note = DS.Model.extend({
  title: DS.attr('string'),
  body: DS.attr('string'),
  notesTask: DS.belongsTo('notesTask')
})

ETahi.NoteController = Ember.ObjectController.extend({
})
