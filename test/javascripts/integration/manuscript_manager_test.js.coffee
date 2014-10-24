module "Integration: Manuscript Manager",
  teardown: -> ETahi.reset()
  setup: ->
    setupApp(integration: true)

    server.respondWith 'GET', /\/papers\/\d+\/manuscript_manager/, [
      204
      'Tahi-Authorization-Check': 'true'
      ""
    ]

test 'It shows a phase and its cards when the user is authorized.', ->
  ef = ETahi.Factory
  paper = ef.createRecord('Paper')
  litePaper = ef.createLitePaper(paper)
  phase = ef.createPhase(paper)
  task = ef.createTask('Task', paper, phase)
  paperPayload = ef.createPayload('paper')
  paperPayload.addRecords([paper, phase, task, litePaper])
  server.respondWith 'GET', "/papers/1", [
    200, {"Content-Type": "application/json"}, JSON.stringify paperPayload.toJSON()
  ]

  visit '/papers/1/manage'
  andThen ->
    ok find('#manuscript-manager').length
