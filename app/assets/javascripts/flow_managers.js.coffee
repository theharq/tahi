window.Tahi ||= {}

Card = React.createClass
  cardClass: ->
    Tahi.className
      'card': true
      'flow-card': true
      'completed': @props.task.taskCompleted

  render: ->
    {a, span} = React.DOM
    (a {
        className: @cardClass(),
        onClick: @displayCard,
        "data-card-name": @props.task.cardName,
        "data-task-id":   @props.task.taskId,
        "data-task-path": @props.task.taskPath,
        href: @props.task.taskPath
      },
      (span {className: 'glyphicon glyphicon-ok'}),
      @props.task.taskTitle
    )

  displayCard: (event) ->
    Tahi.overlay.display event, @props.task.cardName

PaperProfile = React.createClass
  render: ->
    {div, h4, a} = React.DOM

    (div {className: 'paper-profile'}, [
      (a {href: @props.profile.paper_path, className: 'paper-title'},
        (h4 {}, @props.profile.title)),

      for task in @props.profile.tasks
        (Card {task: task})])

Flow = React.createClass
  render: ->
    {h2, ul, li, div} = React.DOM

    (li {className: 'column'},
      (h2 {}, @props.title),
      (div {className: 'column-content'},
        (ul {},
          for paperProfile in @props.paperProfiles
            (li {}, PaperProfile {profile: paperProfile}))))

FlowManager = React.createClass
  componentDidMount: ->
    $.getJSON 'flow_manager', (data,status) =>
      @setProps flows: data.flows

  componentDidUpdate: ->
    $('.paper-profile h4').dotdotdot
      height: 40



  render: ->
    {ul} = React.DOM
    (ul {className: 'columns'},
      for flow, index in @props.flows
        Flow {key: "flow-#{index}", paperProfiles: flow.paperProfiles, title: flow.title}
    )

Tahi.flowManager =
  init: ->
    if document.getElementById('flow-manager')
      flowManager = FlowManager flows: []
      React.renderComponent flowManager, document.getElementById('tahi-container')