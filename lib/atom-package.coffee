AtomPackageView = require './atom-package-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomPackage =
  atomPackageView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomPackageView = new AtomPackageView(state.atomPackageViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomPackageView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-package:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomPackageView.destroy()

  serialize: ->
    atomPackageViewState: @atomPackageView.serialize()

  toggle: ->
    console.log 'AtomPackage was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
