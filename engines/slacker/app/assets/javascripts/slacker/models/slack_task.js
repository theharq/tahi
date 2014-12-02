ETahi.SlackTask = ETahi.Task.extend({
  qualifiedType: "Slacker::SlackTask",
  slackMessages: DS.hasMany('slackMessage'),

  message: DS.attr('string')
});
