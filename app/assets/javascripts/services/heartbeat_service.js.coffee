ETahi.HeartbeatService = Em.Object.extend
  interval: 90 * 1000
  intervalId: null
  resource: null
  url: null

  init: ->
    resource = @get('resource')
    throw new Error("need to specify resource") unless resource
    @set('url', "#{resource.path()}/heartbeat")

  start: ->
    @heartbeat() # immediate heartbeat
    heartbeatWrapper = => @heartbeat()
    @set('intervalId', setInterval(heartbeatWrapper, @get('interval')))

  stop: ->
    intervalId = @get('intervalId')
    if intervalId
      clearInterval(intervalId)
      @set('intervalId', null)

  heartbeat: ->
    $.ajax
      url: @get('url')
      type: "PUT"
      headers:
        'Tahi-Heartbeat': true