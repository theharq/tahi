ETahi.FlowManagerView = Ember.View.extend
  setupColumnHeights:(->
    Tahi.utils.bindColumnResize()
    Tahi.utils.resizeColumnHeaders()
  ).on('didInsertElement')