ETahi.WhiteboardImage = DS.Model.extend
  task: DS.belongsTo('sketchTask')
  data: DS.attr('string')
