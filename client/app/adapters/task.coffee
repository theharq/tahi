`import DS from 'ember-data'`

TaskAdapter = DS.ActiveModelAdapter.extend
  pathForType: (type) ->
    'tasks'

`export default TaskAdapter`