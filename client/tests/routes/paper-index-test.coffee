`import Ember from 'ember'`
`import { moduleFor, test } from 'ember-qunit'`

moduleFor 'route:paper/index', 'Unit: route/PaperIndex',
  needs: ['model:paper', 'route:paper'],
  setup: ->
    sinon.stub(@subject(), 'replaceWith')

test 'transition to edit route if paper is editable', ->
  editablePaper = Ember.Object.create editable: true
  @subject().afterModel editablePaper

  ok @subject().replaceWith.calledWithExactly('paper.edit', editablePaper)

test 'does not transition to edit route if paper has been submitted', ->
  uneditablePaper = Ember.Object.create editable: false
  @subject().afterModel uneditablePaper

  ok !@subject().replaceWith.called
