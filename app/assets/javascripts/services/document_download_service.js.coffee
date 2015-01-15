ETahi.DocumentDownloadService = Em.Namespace.create
  initiate: (paperId, downloadFormat) ->
    @paperId = paperId
    @downloadFormat = downloadFormat
    Ember.$.ajax
      url: "/papers/#{@paperId}/export",
      data: {format: @downloadFormat}
      success: (data) =>
        jobId = data['job']['id']
        @checkJobState(jobId)
      error: (data) ->
        throw new Error("Failed to export #{@downloadFormat}")

  checkJobState: (jobId) ->
    status = ""
    @timeout = 2000
    Ember.$.ajax
      url: "/papers/#{@paperId}/status/#{jobId}",
      success: (data) =>
        job = data['job']
        if job.state == "converted"
          Tahi.utils.windowLocation job.url
        else if job.state == "errored"
          throw new Error("Failed to generate #{@downloadFormat}")
        else
          setTimeout (=>
            @checkJobState jobId
          ), @timeout

