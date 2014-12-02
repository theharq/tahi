ETahi.SlackMessage = DS.Model.extend({
  slackTask: DS.belongsTo('slackTask'),

  username: DS.attr('string'),
  message: DS.attr('string')
});
