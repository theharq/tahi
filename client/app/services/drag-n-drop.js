import Ember from 'ember';

/**
  ## How to Use


  Draggable Component:

  ```
  import Ember from 'ember';
  import DragNDrop from 'tahi/services/drag-n-drop';

  export default Ember.Component.extend(DragNDrop.DraggableMixin, {
    dragStart: function(e) {
      DragNDrop.dragItem = this.get('model');
    }
  });
  ```

  Droppable Component:

  ```
  import Ember from 'ember';
  import DragNDrop from 'tahi/services/drag-n-drop';

  export default Ember.Component.extend(DragNDrop.DroppableMixin, {
    removeDragStyles: function() {
      this.$().removeClass('current-drop-target');
    },

    dragOver: function(e) {
      this.$().addClass('current-drop-target');
    }

    dragLeave: function(e) {
      this.removeDragStyles();
    },

    dragEnd: function(e) {
      this.removeDragStyles();
    },

    drop: function(e) {
      this.removeDragStyles();
      this.sendAction('somethingImportant', DragNDrop.dragItem);
      // Cleanup:
      DragNDrop.dragItem = null;
      // Prevent bubblbing:
      return DragNDrop.cancel(e);
    }
  });
  ```

  If applying a class on `dragOver` you'll want to remove that class in `dragLeave`, `dragEnd`, and `drop`.
  One or more of these events will fire but it's hard to know which ones.

  ## How it Works

  1. Drag event -> Set DragNDrop.dragItem
  1. Drop event -> Send DragNDrop.dragItem through action
*/

var cancelDragEvent = function(e) {
  e.preventDefault();
  e.stopPropagation();
  return false;
};

export default {
  /**
    @property dragItem
    @type Whatever String, array, Ember class, whatever. Used to pass data from drag object to drop object.
    @default null
  */

  dragItem: null,

  /**
    Cancel event

    ```
    DragNDrop.cancel(event);
    ```

    @method cancel
    @param {Object} event jQuery event to stop
  */

  cancel: function(e) {
    return cancelDragEvent(e);
  },

  DraggableMixin: Ember.Mixin.create({
    attributeBindings: ['draggable'],
    draggable: true,

    /**
      ```
      dragStart: function(e) {
        DragNDrop.dragItem = this.get('model');
      }
      ```

      @method dragStart
      @param {Object} event jQuery event
    */

    dragStart: function() { throw new Error("Implement dragStart"); }
  }),

  DroppableMixin: Ember.Mixin.create({
    /**
      Prevent annoying HTML5 drag-n-drop nonsense

      @private
      @method _dragEnter
      @param {Object} event jQuery event to stop
      @return {Boolean} false
    */
    _dragEnter: function(e) {
      return cancelDragEvent(e);
    }.on('dragEnter'),

    /**
      Prevent annoying HTML5 drag-n-drop nonsense

      @private
      @method _dragOver
      @param {Object} event jQuery event to stop
      @return {Boolean} false
    */

    _dragOver: function(e) {
      return cancelDragEvent(e);
    }.on('dragOver'),

    /**
      Catch drop event

      ```
      drop: function(e) {
        this.sendAction('somethingImportant', DragNDrop.dragItem);
        return DragNDrop.cancel(event);
      }
      ```

      @method drop
      @param {Object} event jQuery
    */

    drop: function() { throw new Error("Implement drop"); }
  })
};
