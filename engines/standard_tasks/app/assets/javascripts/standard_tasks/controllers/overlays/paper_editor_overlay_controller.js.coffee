ETahi.PaperEditorOverlayController = ETahi.TaskController.extend
  assigned: false

  select2RemoteSource: (->
    url: @get('select2RemoteUrl')
    dataType: "json"
    quietMillis: 500
    data: (term) ->
      query: term
    results: (data) ->
      results: data.filtered_users
  ).property('select2RemoteUrl')

  resultsTemplate: (user) ->
    user.email

  selectedTemplate: (user) ->
    user.email || user.get('email')

  select2RemoteUrl: Ember.computed 'paper.journal.id', ->
    "/filtered_users/editors/#{@get('model.paper.journal.id')}/"

  actions:
    removeEditor: ->
      @set 'assigned', false
      @set 'editor', undefined
      @send 'saveModel'

    saveEditor: ->
      @set 'assigned', true
      @send('saveModel')

    inviteEditor: (select2User) ->
      @store.find('user', select2User.id).then (user) =>
        @set('editor', user)
