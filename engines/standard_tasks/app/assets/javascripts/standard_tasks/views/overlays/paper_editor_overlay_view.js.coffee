ETahi.PaperEditorOverlayView = ETahi.OverlayView.extend Ember.ViewTargetActionSupport,
  templateName: 'standard_tasks/overlays/paper_editor_overlay'
  layoutName: 'layouts/overlay_layout'

  assigned: false

  checkIfEditorIsAssigned: (->
    @set('assigned', true) if @get('controller.editor')
  ).on('didInsertElement')

  showEditForm: (->
    return false if @get('assigned')
    true
  ).property('controller.editor', 'assigned')

  actions:
    remove: ->
      @set 'assigned', false
      @triggerAction({action: 'removeEditor'})
      false

    save: ->
      @set 'assigned', true
      @triggerAction({action: 'saveEditor'})
      false
