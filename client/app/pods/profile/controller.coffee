`import Ember from 'ember'`
`import FileUploadMixin from 'tahi/mixins/controllers/file-upload'`
`import ValidationErrorsMixin from 'tahi/mixins/validation-errors'`
`import Utils from 'tahi/services/utils'`

ProfileController = Ember.ObjectController.extend FileUploadMixin, ValidationErrorsMixin,
  showAffiliationForm: false
  errorText: ""
  affiliations: Ember.computed.alias "model.affiliationsByDate"

  avatarUploadUrl: ( ->
    "/users/#{@get('model.id')}/update_avatar"
  ).property('id')

  selectableInstitutions: (->
    @get('model.institutions').map (institution) ->
      id: institution
      text: institution
  ).property('model.institutions')

  actions:
    uploadFinished: (data, filename) ->
      @uploadFinished(data, filename)
      @set 'model.avatarUrl', data.avatar_url

    hideNewAffiliationForm: ->
      @clearValidationErrors()
      @set 'showAffiliationForm', false
      @get('newAffiliation').deleteRecord() if @get('newAffiliation.isNew')

    showNewAffiliationForm: ->
      @set 'newAffiliation', @store.createRecord('affiliation')
      @set 'showAffiliationForm', true

    removeAffiliation: (affiliation) ->
      affiliation.destroyRecord() if confirm('Are you sure you want to destroy this affiliation?')

    commitAffiliation:(affiliation) ->
      affiliation.set 'user', @get('model')
      @clearValidationErrors()

      affiliation.save().then(
        (affiliation) =>
          affiliation.get('user.affiliations').addObject(affiliation)
          @send 'hideNewAffiliationForm'
        ,
        (response) =>
          affiliation.set 'user', null
          @displayValidationErrorsFromResponse response
      )

`export default ProfileController`