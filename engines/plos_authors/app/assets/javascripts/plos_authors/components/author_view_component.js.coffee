ETahi.AuthorViewComponent = Ember.Component.extend DragNDrop.Dragable,
  layoutName: 'plos_authors/components/author-view'
  classNames: ['authors-overlay-item']

  hoverState: false
  deleteState: false
  editState: Ember.computed.any('errors')

  attachHoverEvent: (->
    toggleHoverClass = (e) =>
      @toggleProperty 'hoverState'

    @$().hover toggleHoverClass, toggleHoverClass
  ).on('didInsertElement')

  teardownHoverEvent: (->
    @$().off('mouseenter mouseleave')
  ).on('willDestroyElement')

  dragStart: (e) ->
    e.dataTransfer.effectAllowed = 'move'
    ETahi.set('dragItem', @get('plosAuthor'))

  dragEnd: (e) ->
    DragNDrop.draggingStopped('.author-overlay-drop-target')

  actions:
    delete: ->
      @$().fadeOut 150, =>
        @sendAction 'delete', @get('plosAuthor')

    save: ->
      @sendAction 'save', @get('plosAuthor')
      @set 'editState', false

    toggleEditForm: ->
      @toggleProperty 'editState'

    toggleDeleteConfirmation: ->
      @toggleProperty 'deleteState'
