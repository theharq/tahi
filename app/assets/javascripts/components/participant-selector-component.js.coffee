ETahi.ParticipantSelectorComponent = Ember.Component.extend
  currentParticipants: []

  availableParticipants: (->
    return [] if @get('everyone.isPending')

    currentParticipantIds = @get('currentParticipants').mapProperty('id')

    (@get('everyone.content').reject (user) ->
      currentParticipantIds.contains("" + user.id)).map (user) ->
        _.extend(user, text: user.full_name)
  ).property('everyone.content.[]', 'currentParticipants.@each')

  remoteUrl: (->
    "/filtered_users/non_participants/#{@get('taskId')}/%QUERY"
  ).property()

  resultsTemplate: (user) ->
    debugger
    Handlebars.compile('<strong>{{user.full_name}}</strong><br><div class="tt-suggestion-sub-value">{{user.info}}</div>')

  actions:
    addParticipant: (newParticipant) ->
      @sendAction("onSelect", newParticipant.object.get('id'))
