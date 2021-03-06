`import Ember from 'ember'`
`import startApp from '../helpers/start-app'`
`import { test } from 'ember-qunit'`
`import { paperWithParticipant } from '../helpers/setups'`
`import setupMockServer from '../helpers/mock-server'`
`import Factory from '../helpers/factory'`

app = null
server = null
journalId = null

module 'Integration: Admin Journal Test',
  teardown: ->
    server.restore()
    Ember.run(app, app.destroy)

  setup: ->
    app = startApp()
    server = setupMockServer()
    journal = Factory.createRecord('AdminJournal')
    journalId = journal.id

    adminRole = Factory.createJournalRole journal,
      name: "Admin"
      kind: "admin"
      can_administer_journal: true
      can_view_assigned_manuscript_managers: false
      can_view_all_manuscript_managers: true
      can_view_flow_manager: true

    adminJournalPayload = Factory.createPayload('adminJournal')
    adminJournalPayload.addRecords([journal, adminRole])

    stubbedAdminJournalUserResponse =
      user_roles: []
      admin_journal_users: []

    server.respondWith 'GET', '/admin/journals/authorization', [
      204, 'Content-Type': 'application/html', ""
    ]

    server.respondWith 'PUT', "/admin/journals/#{journalId}", [
      200, "Content-Type": "application/json",
      JSON.stringify adminJournalPayload.toJSON()
    ]

    server.respondWith 'GET', "/admin/journals/#{journalId}", [
      200, "Content-Type": "application/json",
      JSON.stringify adminJournalPayload
    ]

    server.respondWith 'GET', "/admin/journal_users?journal_id=#{journalId}", [
      200, "Content-Type": "application/json", JSON.stringify stubbedAdminJournalUserResponse
    ]

test 'saving doi info will send a put request to the admin journal controller', ->
  adminPage = "/admin/journals/#{journalId}"
  visit adminPage
  .then ->
    click('.admin-doi-settings-edit-button')
    fillIn('.admin-doi-setting-section .doi_publisher_prefix', 'PPREFIX')
    fillIn('.admin-doi-setting-section .doi_journal_prefix', 'JPREFIX')
    fillIn('.admin-doi-setting-section .last_doi_issued', '10000')
    click('.admin-doi-setting-section button')
  andThen ->
    ok _.findWhere(server.requests, { method: 'PUT', url: adminPage })

test 'saving invalid doi info will display an error', ->
  server.respondWith 'PUT', "/admin/journals/#{journalId}", [
    422, "Content-Type": "application/json", JSON.stringify {errors: {doi: ["Invalid"]}}
  ]

  adminPage = "/admin/journals/#{journalId}"
  visit adminPage
  .then ->
    click('.admin-doi-settings-edit-button')
    fillIn('.admin-doi-setting-section .doi_publisher_prefix', 'PPREFIX')
    fillIn('.admin-doi-setting-section .doi_journal_prefix', 'a/b')
    fillIn('.admin-doi-setting-section .last_doi_issued', '10000')
    click('.admin-doi-setting-section button')
  andThen ->
    ok find('.admin-doi-setting-section .error-message').text().match(/Invalid/)
