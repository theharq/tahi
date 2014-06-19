ETahi.QuestionComponent = Ember.Component.extend
  tagName: 'div'
  helpText: null

  model: (->
    ident = @get('ident')
    throw "you must specify an ident" unless ident

    question = @get('task.questions').findProperty('ident', ident)

    unless question
      task = @get('task')
      question = task.get('store').createRecord 'question',
        question: @get('question')
        ident: ident
        task: task
        additionalData: [{}]

    question

  ).property('task', 'ident')

  additionalData: Em.computed.alias('model.additionalData')

  change: ->
    Ember.run.debounce(this, this._saveModel, 500)

  _saveModel: ->
    @get('model').save()
