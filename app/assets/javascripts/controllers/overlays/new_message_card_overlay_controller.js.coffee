ETahi.NewMessageCardOverlayController = ETahi.NewCardOverlayController.extend
  overlayClass: 'message-overlay'

  disabled: (->
    Ember.isBlank(@get('model.title'))
  ).property('model.title')

  newComment: Ember.computed.alias('model.comments.firstObject')
  hasComment: (->
    !Ember.isBlank(@get('newComment.body'))
  ).property('newComment.body')

  actions:
    createCard: ->
      initialComment = @get('newComment')
      shouldSaveComment = @get('hasComment')
      @get('model').save().then (task) =>
        @get('participations').forEach (part) ->
          part.save()
        if shouldSaveComment
          initialComment.set('task', task)
          initialComment.save()
        else
          initialComment.deleteRecord()
        @send('closeOverlay')
