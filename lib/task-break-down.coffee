TaskBreakDownView = require './task-break-down-view'
{CompositeDisposable} = require 'atom'

module.exports = TaskBreakDown =
  taskBreakDownView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @taskBreakDownView = new TaskBreakDownView(state.taskBreakDownViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @taskBreakDownView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'task-break-down:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @taskBreakDownView.destroy()

  serialize: ->
    taskBreakDownViewState: @taskBreakDownView.serialize()

  toggle: ->
    console.log 'TaskBreakDown was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
