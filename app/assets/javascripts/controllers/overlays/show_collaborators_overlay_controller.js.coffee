ETahi.ShowCollaboratorsOverlayController = Em.ObjectController.extend
  allUsers: (->
    @store.all('user') #simply getting all users for now
  ).property()

  availableCollaborators: Ember.computed.setDiff('allUsers', 'collaborators')

  addedCollaborations: Ember.computed.setDiff('collaborations.content','initialCollaborations')
  removedCollaborations: Ember.computed.setDiff('initialCollaborations','collaborations.content')

  paper: null
  initialCollaborations: null
  collaborations: null

  collaborators: (->
    @get('collaborations').mapBy('user')
  ).property('collaborations.@each')

  actions:
    addNewCollaborator: (newCollaborator) ->
      paper = @get('paper')
      existingRecord = @store.all('collaboration').find (c) ->
        # if this collaborator's record was previously removed from the paper make sure we use THAT one and not a
        # new record.
        c.get('oldPaper') == paper && c.get('user') == newCollaborator

      newCollaboration = existingRecord || @store.createRecord('collaboration', paper: paper, user: newCollaborator)
      @get('collaborations').addObject(newCollaboration)

    removeCollaborator: (collaborator) ->
      collaboration = @get('collaborations').findBy('user', collaborator)
      # since the relationship between paper and collaboration is a proper hasMany, if we remove the
      # collaboration from the papers' collection of them ember will also unset the paper field on the collaboration.
      # if the user tries to re-add that collaborator to the paper without reloading we need to do some extra checking
      # to make sure that ember doesn't create a new record but rather uses the one we just removed here.
      collaboration.set('oldPaper', collaboration.get('paper'))
      @get('collaborations').removeObject(collaboration)

    save: ->
      addPromises = @get('addedCollaborations').map (collaboration) =>
        collaboration.save()

      deletePromises = @get('removedCollaborations').map (collaboration) ->
        collaboration.destroyRecord()

      Ember.RSVP.all(_.union(addPromises, deletePromises)).then =>
        @send('closeOverlay')
