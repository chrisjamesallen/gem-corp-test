Backbone.Marionette.Renderer.render = (template, data) ->
	path = JST["backbone/apps/templates/" + template]

	unless path
		throw "Template #{template} not found!"
	path(data)