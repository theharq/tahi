`import Ember from 'ember'`

formatDate = (date, options) ->
  return date unless moment(date).isValid()
  moment(date).format(options.hash.format || "LL")

FormatDateHelper = Ember.Handlebars.makeBoundHelper formatDate

`export { formatDate }`

`export default FormatDateHelper`
