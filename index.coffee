#copyPaste = require 'copy-paste'
{CompositeDisposable} = require 'atom'

module.exports =

	subscriptions: null

	activate: (state) ->
		@subscriptions = new CompositeDisposable
		@subscriptions.add atom.commands.add 'atom-text-editor', 'copy-path:copy': => @copy()

	copy: ->
		path = atom.workspace.getActiveTextEditor().getPath()
		repos = atom.project.getRepositories()
		dirs = atom.project.getDirectories()
		dir = (dirs.filter (d, idx) =>
			if path.indexOf(d.path) == 0
				repo = repos[idx]
				return true;
		)[0]
		console.log repo?.relativize(path)
		#copyPaste.copy repo?.relativize(path)

	deactivate: ->
		@subscriptions.dispose()
