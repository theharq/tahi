`import Ember from 'ember'`

DisplayValue = Ember.Handlebars.makeBoundHelper (value, options) ->
  if Ember.isEmpty(value) then options.hash.or else value.htmlSafe()

`export default DisplayValue`
