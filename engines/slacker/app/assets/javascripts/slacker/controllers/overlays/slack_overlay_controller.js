ETahi.SlackOverlayController = ETahi.TaskController.extend({
  message: "",

  actions: {

    share: function() {
      var task = this.model;
      var msg = this.store.createRecord('slackMessage', {
        message: this.get('message'),
        username: "slacker",
        slackTask: task
      });

      var that = this;
      msg.save(function() {
        that.set("message", "");
      });
    }

  }

});
