ETahi.NotesTask = ETahi.Task.extend({
  qualifiedType: "StandardTasks::NotesTask",
  blah: DS.attr('string'),
  notes: DS.hasMany('note')
});
