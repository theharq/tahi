import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['flash-message'],
  classNameBindings: ['type'],
  layoutName: 'flash-message',

  type: function() {
    return 'flash-message--' + this.get('message.type');
  }.property('message.type'),

  fadeIn: function() {
    this.$().hide().fadeIn(250);
  }.on('didInsertElement'),

  actions: {
    remove: function() {
      var self = this;
      this.$().fadeOut(function() {
        self.sendAction('remove', this.get('message'));
      });
    }
  }
});