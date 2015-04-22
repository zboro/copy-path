{CompositeDisposable} = require 'atom'

module.exports =

	subscriptions: null

	activate: (state) ->
		@subscriptions = new CompositeDisposable
		@subscriptions.add atom.commands.add 'atom-workspace', 'copy-path:copy': => @copy()

	copy: ->
		path = atom.workspace.getActiveTextEditor().getPath()
		repos = atom.project.getRepositories()
		console.log repos
		dirs = atom.project.getDirectories()
		repo = null
		dir = (dirs.filter (d, idx) =>
			if path.indexOf(d.path) == 0
				repo = repos[idx]
				return true;
		)[0]
		pathToCopy = repo?.relativize(path) || dir?.relativize(path)
		pathToCopy && atom.clipboard.write pathToCopy

	deactivate: ->
		@subscriptions.dispose()
