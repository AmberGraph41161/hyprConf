local mon1 = "eDP-1"
local mon2 = "HDMI-A-1"

hl.monitor({
	output = mon1,
	mode = "preferred",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = mon2,
	mode = "preferred",
	position = "auto",
	scale = "1"
})
