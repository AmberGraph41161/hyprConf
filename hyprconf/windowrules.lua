hl.window_rule({
	name = "fuzzel focus",
	match = {
		class = "^(fuzzel)$"
	},
	stay_focused = true
})

hl.window_rule({
	name = "fullscreen idle inhibit",
	match = {
		class = ".*"
	},
	idle_inhibit = "fullscreen"
})
