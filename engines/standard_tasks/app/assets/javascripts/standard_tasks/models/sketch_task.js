ETahi.SketchTask = ETahi.Task.extend({
  qualifiedType: "StandardTasks::SketchTask",
  whiteboardImage: DS.belongsTo('whiteboardImage', {inverse: 'task'})
});
