ETahi.NotesOverlayController = ETahi.TaskController.extend({
  actions: {
    createNote: function() {
      note = this.store.createRecord('note', {
        title: this.get('noteTitle'),
        body: this.get('noteBody')
      })
      note.save();
      this.get('notes').unshiftObject(note)
      this.set('noteTitle', '')
      this.set('noteBody', '')
    }
  }
});
