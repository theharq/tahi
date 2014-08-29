ETahi.WhiteboardImage = DS.Model.extend
  sketchTask: DS.belongsTo('sketchTask', inverse: 'WhiteboardImage')
  data: DS.attr('string')
