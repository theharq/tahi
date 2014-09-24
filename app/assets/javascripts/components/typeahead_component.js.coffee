ETahi.TypeAheadComponent = Ember.TextField.extend
  tagName: 'div'
  attributeBindings: ['placeholder']
  classNames: ['form-control']

  autoFocus: false
  source: []
  suggestionSelected: null
  placeholder: ""
  selectedTemplate: null
  resultsTemplate: null
  closeOnSelect: false
  multiSelect: false

  setup:(->
    options = {}
    options.formatSelection = @get('selectedTemplate') if @get('selectedTemplate')
    options.formatResults = @get('resultsTemplate') if @get('resultsTemplate')
    options.allowClear = @get('allowClear')
    options.multiple = @get('multiSelect') if @get('multiSelect')
    options.data = @get('source')
    options.closeOnSelect = @get('closeOnSelect')

    @.$().select2(options)
  ).observes('source.[]')

  # setupSelectedListener: ->
  #   if @get 'suggestionSelected'
  #     @.$().on 'typeahead:selected', (e, item, index) =>
  #       @sendAction 'suggestionSelected', item
  #       @$().typeahead('val', '') if @get 'clearOnSelect'
  #       @get('engine').clearRemoteCache()
  #
  # autoFocusInput: -> @.$().focus() if @get 'autoFocus'
  #
  # formattedData: (item) ->
  #   subvalueProperty = @get('subvalueProperty') || "nonexistentProperty"
  #   valueProperty = @get('valueProperty')
  #   value: item.get(valueProperty)
  #   subvalue: item.get(subvalueProperty)
  #   object: item
  #
  # filter: (items) ->
  #
  # setData: (->
  #   engine = @get('engine')
  #   engine.local = @get('sourceList').map (item) =>
  #     item = Ember.Object.create(item) unless item.get
  #     @formattedData(item)
  #
  #   @.$().typeahead('destroy')
  # ).observes('sourceList')
  #
  # setupEngine: ->
  #   options =
  #     local: @get('sourceList').map (item) =>
  #       item = Ember.Object.create(item) unless item.get
  #       @formattedData(item)
  #
  #     datumTokenizer: (d) -> Bloodhound.tokenizers.whitespace d.value
  #     queryTokenizer: Bloodhound.tokenizers.whitespace
  #     limit: 10
  #
  # _setup: (->
  #   options =
  #     local: @get('sourceList').map (item) =>
  #       item = Ember.Object.create(item) unless item.get
  #       @formattedData(item)
  #
  #     datumTokenizer: (d) -> Bloodhound.tokenizers.whitespace d.value
  #     queryTokenizer: Bloodhound.tokenizers.whitespace
  #     limit: 10
  #
  #   if @get('remoteUrl')
  #     options.remote =
  #       url: @get('remoteUrl')
  #       filter: (response) =>
  #         response.map (item) =>
  #           item = Ember.Object.create(item)
  #           @formattedData(item)
  #
  #   engine = new Bloodhound(options)
  #   engine.initialize(true)
  #   @set('engine', engine)
  #
  #   @.$().typeahead
  #     hint: true
  #     highlight: true
  #     minLength: 1
  #   ,
  #     source: engine.ttAdapter()
  #     displayKey: 'value'
  #     templates:
  #       suggestion: Handlebars.compile('<strong>{{value}}</strong>{{#if subvalue}}<br><div class="tt-suggestion-sub-value">{{subvalue}}</div>{{/if}}')
  #
  #   @setupSelectedListener()
  #   @autoFocusInput()
  # ).on('didInsertElement')
