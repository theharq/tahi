ETahi.AuthorDropTargetView = Ember.View.extend DragNDrop.Droppable,
  classNameBindings: [':author-overlay-drop-target', 'isEditable::hidden']

  isEditable: Ember.computed.alias('controller.isEditable')

  position: ( ->
    @get('index') + 1
  ).property('index')

  notAdjacent: (thisPosition, dragItemPosition) ->
    thisPosition <= (dragItemPosition - 1) || thisPosition > (dragItemPosition + 1)

  dragEnter: (e) ->
    if @notAdjacent(this.get('position'), ETahi.get('dragItem.position'))
      DragNDrop.draggingStarted('.author-overlay-drop-target', @.$())
      DragNDrop.cancel(e)

  dragLeave: (e) ->
    DragNDrop.draggingStopped('.author-overlay-drop-target')

  drop: (e) ->
    @get('controller').shiftAuthorPositions ETahi.get('dragItem'), @get('position')
    DragNDrop.draggingStopped('.author-overlay-drop-target')
    e.preventDefault()
    #dragItem will be the author.
    ETahi.set('dragItem', null)
    false
