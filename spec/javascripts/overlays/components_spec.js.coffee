describe "Tahi overlay components", ->
  describe "RailsForm", ->
    describe "#render", ->
      beforeEach ->
        @component = Tahi.overlays.components.RailsForm
          action: '/form/action'
          formContent: React.DOM.input({type: 'foo'})

      it "renders a form with the specified action", ->
        form = @component.render()
        expect(form.props.action).toEqual '/form/action'

      it "contains a hidden div component", ->
        hiddenDiv = @component.render().props.children[0]
        expect(hiddenDiv.constructor).toEqual Tahi.overlays.components.RailsFormHiddenDiv.componentConstructor

      it "contains provided content", ->
        input = @component.render().props.children[1]
        expect(input.props.type).toEqual 'foo'

  describe "CompletedCheckbox", ->
    beforeEach ->
      @successCallback = jasmine.createSpy 'successCallback'
      @component = Tahi.overlays.components.CompletedCheckbox
        action: '/form/action'
        onSuccess: @successCallback

    describe "#formContent", ->
      context "when the task has been completed", ->
        beforeEach -> @component.props.taskCompleted = true

        it "checks the checkbox", ->
          checkbox = @component.formContent().props.children[1]
          expect(checkbox.props.defaultChecked).toEqual true

      context "when the task has not been completed", ->
        beforeEach -> @component.props.taskCompleted = false

        it "does not check the checkbox", ->
          checkbox = @component.formContent().props.children[1]
          expect(checkbox.props.defaultChecked).toEqual false

    describe "#render", ->
      it "generates a form for the task", ->
        # paperId, taskId, taskCompleted
        form = @component.render()
        expect(form.props.action).toEqual '/form/action'

    describe "#componentDidMount", ->
      it "sets up submit on change for the check box", ->
        spyOn Tahi, 'setupSubmitOnChange'
        html = $('<form><input type="checkbox" /></form>')[0]
        @component.componentDidMount html
        args = Tahi.setupSubmitOnChange.calls.mostRecent().args
        expect(args[0][0]).toEqual $(html)[0]
        expect(args[1][0]).toEqual $('input[type="checkbox"]', html)[0]
        expect(args[2]).toEqual success: @successCallback

  describe "OverlayHeader", ->
    describe "#render", ->
      it "includes the paper title which is a link to the paper", ->
        component = Tahi.overlays.components.OverlayHeader
          paperTitle: 'A title'
          paperPath: '/path/to/paper'

        link = component.render().props.children[0].props.children
        expect(link.props.href).toEqual '/path/to/paper'
        expect(link.props.children).toEqual 'A title'

      # it "includes the paper title which is a link to the paper", (done) ->
      #   component = Tahi.overlays.components.OverlayHeader
      #     paperTitle: 'A title'
      #     paperPath: '/path/to/paper'

      #   React.renderComponentToString component, (markup) ->
      #     link = $('h2 a', markup)
      #     expect(link.attr 'href').toEqual '/path/to/paper'
      #     expect(link.text()).toEqual 'A title'
      #     done()

      it "passes an on click callback to the close button", ->
        callback = ->
        component = Tahi.overlays.components.OverlayHeader
          closeCallback: callback

        button  = component.render().props.children[1]
        expect(button.props.onClick).toEqual callback

  describe "OverlayFooter", ->
    describe "#render", ->
      it "passes an on click callback to the close button", ->
        callback = jasmine.createSpy 'closeCallback'
        component = Tahi.overlays.components.OverlayFooter
          closeCallback: callback

        button  = component.render().props.children[1]
        expect(button.props.onClick).toEqual callback

      it "passes onCompletedChanged as an onSuccess callback to CompletedCheckbox", ->
        callback = jasmine.createSpy 'onCompletedChanged'
        component = Tahi.overlays.components.OverlayFooter
          onCompletedChanged: callback

        checkbox  = component.render().props.children[0].props.children
        expect(checkbox.props.onSuccess).toEqual callback

  describe "RailsFormHiddenDiv", ->
    describe "#render", ->
      it "contains a hidden field containing the specified method", ->
        component = Tahi.overlays.components.RailsFormHiddenDiv method: 'foo'
        methodField  = component.render().props.children[1]
        expect(methodField.props.value).toEqual 'foo'

      # it "contains a hidden field containing the specified method", (done) ->
      #   component = Tahi.overlays.components.RailsFormHiddenDiv method: 'foo'
      #   React.renderComponentToString component, (markup) ->
      #     field = $('input[name="_method"]', markup)
      #     expect(field.val()).toEqual 'foo'
      #     done()