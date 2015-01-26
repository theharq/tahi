`import Ember from 'ember'`
`import RESTless from 'tahi/services/rest-less'`

PaperSubmitOverlayController = Ember.Controller.extend
  overlayClass: 'overlay--fullscreen paper-submit-overlay'

  actions:
    submit: ->
      RESTless.putUpdate(@get('model'), "/submit").then( =>
        @transitionToRoute('application')).catch ({status, model}) =>
          message = switch status
            when 422 then model.get('errors.messages') + " You should probably reload."
            when 403 then "You weren't authorized to do that"
            else "There was a problem saving. Please reload."

          @flash.displayMessage 'error', message

`export default PaperSubmitOverlayController`