hl.config({
	--"https://wiki.hyprland.org/Configuring/Variables/"
	general = {
		border_size = 2, --size of the border around windows
		gaps_in = 3, --gaps between windows, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)
		gaps_out = 5, --gaps between windows and monitor edges, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)
		float_gaps = 0, --gaps between windows and monitor edges for floating windows, also supports css style gaps (top, right, bottom, left -> 5 10 15 20). -1 means default
		gaps_workspaces = 0, --gaps between workspaces. Stacks with gaps_out.
		col = {
			inactive_border = { colors = { "rgba(595959aa)" }, angle = 0 }, --595959
			active_border = { colors = { "rgba(00ff99ee)", "rgba(33ccffee)", "rgba(ff00ffee)" }, angle = 45 },--00ff99 --33ccff --ff00ff
			--col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg -- --33ccff --00ff99
			--col.active_border = rgba(ffadadee) rgba(ffd6a5ee) rgba(fdffb6ee) rgba(caffbfee) rgba(9bf6ffee) rgba(a0c4ffee) rgba(bdb2ffee) rgba(ffc6ffee)
				--ffadad
				--ffd6a5
				--fdffb6
				--caffbf
				--9bf6ff
				--a0c4ff
				--bdb2ff
				--ffc6ff
			--col.active_border = rgb(FBF8CC) rgb(FDE4CF) rgb(FFCFD2) rgb(F1C0E8) rgb(CFBAF0) rgb(A3C4F3) rgb(90DBF4) rgb(8EECF5) rgb(98F5E1) rgb(B9FBC0)
				--FBF8CC
				--FDE4CF
				--FFCFD2
				--F1C0E8
				--CFBAF0
				--A3C4F3
				--90DBF4
				--8EECF5
				--98F5E1
				--B9FBC0
			--col.active_border = rgb(F2002B) rgb(F64021) rgb(F98016) rgb(FCC00B) rgb(FFFF00) rgb(00CC66) rgb(496DDB) rgb(7209B7) rgb(A01A7D)
				--F2002B
				--F64021
				--F98016
				--FCC00B
				--FFFF00
				--00CC66
				--496DDB
				--7209B7
				--A01A7D
			nogroup_border = { colors = { "rgba(ffffaaff)" }, angle = 0 }, --inactive border color for window that cannot be added to a group (see denywindowfromgroup dispatcher)
			nogroup_border_active = { colors = { "rgba(ffff00ff)" }, angle = 0 }, --active border color for window that cannot be added to a group
		},
		layout = "dwindle", --which layout to use. [dwindle/master]
		no_focus_fallback = false, --if true, will not fall back to the next available window when moving focus in a direction where no window was found
		resize_on_border = false, --enables resizing windows by clicking and dragging on borders and gaps
		extend_border_grab_area = 15, --extends the area around the border where you can click and drag on, only used when general:resize_on_border is on.
		hover_icon_on_border = true, --show a cursor icon when hovering over borders, only used when general:resize_on_border is on.
		allow_tearing = false, --master switch for allowing tearing to occur. See the Tearing page.
		resize_corner = 0, --force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)

		snap = {
			enabled = false, --enable snapping for floating windows
			window_gap = 10, --minimum gap in pixels between windows before snapping
			monitor_gap = 10, --minimum gap in pixels between window and monitor edges before snapping
			border_overlap = false, --if true, windows snap such that only one border’s worth of space is between them
			respect_gaps = false, --if true, snapping will respect gaps between windows(set in general:gaps_in)
		}
	},

	dwindle = {
		force_split = 0, --0 -> split follows mouse, 1 -> always split to the left (new = left or top) 2 -> always split to the right (new = right or bottom)
		preserve_split = true, --if enabled, the split (side/top) will not change regardless of what happens to the container.
		smart_split = false, --if enabled, allows a more precise control over the window split direction based on the cursor’s position. The window is conceptually divided into four triangles, and cursor’s triangle determines the split direction. This feature also turns on preserve_split.
		smart_resizing = true, --if enabled, resizing direction will be determined by the mouse’s position on the window (nearest to which corner). Else, it is based on the window’s tiling position.
		permanent_direction_override = false, --if enabled, makes the preselect direction persist until either this mode is turned off, another direction is specified, or a non-direction is specified (anything other than l,r,u/t,d/b)
		special_scale_factor = 1, --specifies the scale factor of windows on the special workspace [0 - 1]
		split_width_multiplier = 1.0, --specifies the auto-split width multiplier. Multiplying window size is useful on widescreen monitors where window W > H even after several splits.
		use_active_for_splits = true, --whether to prefer the active window or the mouse position for splits
		default_split_ratio = 1.0, --the default split ratio on window open. 1 means even 50/50 split. [0.1 - 1.9]
		split_bias = 0, --specifies which window will receive the split ratio. 0 -> directional (the top or left window), 1 -> the current window
		precise_mouse_move = false, --bindm movewindow will drop the window more precisely depending on where your mouse is.
	},

	decoration = {
		rounding = 0, --rounded corners’ radius (in layout px)
		rounding_power = 2.0, --adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
		active_opacity = 1.0, --opacity of active windows. [0.0 - 1.0]
		inactive_opacity = 1.0, --opacity of inactive windows. [0.0 - 1.0]
		fullscreen_opacity = 1.0, --opacity of fullscreen windows. [0.0 - 1.0]
		dim_modal = true, --enables dimming of parents of modal windows
		dim_inactive = false, --enables dimming of inactive windows
		dim_strength = 0.5, --how much inactive windows should be dimmed [0.0 - 1.0]
		dim_special = 0.2, --how much to dim the rest of the screen by when a special workspace is open. [0.0 - 1.0]
		dim_around = 0.4, --how much the dimaround window rule should dim by. [0.0 - 1.0]
		screen_shader = "", --a path to a custom shader to be applied at the end of rendering. See examples/screenShader.frag for an example.
		border_part_of_window = true, --whether the window border should be a part of the window

		blur = {
			enabled = false, --enable kawase window background blur
			size = 8, --blur size (distance)
			passes = 1, --the amount of passes to perform
			ignore_opacity = true, --make the blur layer ignore the opacity of the window
			new_optimizations = true, --whether to enable further optimizations to the blur. Recommended to leave on, as it will massively improve performance.
			xray = false, --if enabled, floating windows will ignore tiled windows in their blur. Only available if new_optimizations is true. Will reduce overhead on floating blur significantly.
			noise = 0.0117, --how much noise to apply. [0.0 - 1.0]
			contrast = 0.8916, --contrast modulation for blur. [0.0 - 2.0]
			brightness = 0.8172, --brightness modulation for blur. [0.0 - 2.0]
			vibrancy = 0.1696, --Increase saturation of blurred colors. [0.0 - 1.0]
			vibrancy_darkness = 0.0, --How strong the effect of vibrancy is on dark areas . [0.0 - 1.0]
			special = false, --whether to blur behind the special workspace (note: expensive)
			popups = false, --whether to blur popups (e.g. right-click menus)
			popups_ignorealpha = 0.2, --works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
			input_methods = false, --whether to blur input methods (e.g. fcitx5)
			input_methods_ignorealpha = 0.2, --works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]
		},

		shadow = {
			enabled = true, --enable drop shadows on windows
			range = 4, --Shadow range (“size”) in layout px
			render_power = 3, --in what power to render the falloff (more power, the faster the falloff) [1 - 4]
			sharp = false, --if enabled, will make the shadows sharp, akin to an infinite render power
			color = 0xee1a1a1a, --shadow’s color. Alpha dictates shadow’s opacity.
			color_inactive = 0xee1a1a1a, --inactive shadow color. (if not set, will fall back to color)
			offset = { 0, 0 }, --shadow’s rendering offset.
			scale = 1.0, --shadow’s scale. [0.0 - 1.0]
		}
	},

	animations = {
		--animation = NAME, ONOFF, SPEED, CURVE [,STYLE]
			--ONOFF can be either 0 or 1, 0 to disable, 1 to enable. note: if it’s 0, you can omit further args.
			--SPEED is the amount of ds (1ds = 100ms) the animation will take
			--CURVE is the bezier curve name, see curves.
			--STYLE (optional) is the animation style

		enabled = false,
		workspace_wraparound = false, --enable workspace wraparound, causing directional workspace animations to animate as if the first and last workspaces were adjacent
	},

	input = {
		kb_model = "", --Appropriate XKB keymap parameter. See the note below.
		kb_layout = "us", --Appropriate XKB keymap parameter
		kb_variant = "", --Appropriate XKB keymap parameter
		kb_options = "", --Appropriate XKB keymap parameter
		kb_rules = "", --Appropriate XKB keymap parameter
		kb_file = "", --If you prefer, you can use a path to your custom .xkb file.
		numlock_by_default = false, --Engage numlock by default.
		resolve_binds_by_sym = false, --Determines how keybinds act when multiple layouts are used. If false, keybinds will always act as if the first specified layout is active. If true, keybinds specified by symbols are activated when you type the respective symbol with the current layout.
		repeat_rate = 30, --The repeat rate for held-down keys, in repeats per second.
		repeat_delay = 400, --Delay before a held-down key is repeated, in milliseconds.
		sensitivity = 0.0, --Sets the mouse input sensitivity. Value is clamped to the range -1.0 to 1.0. libinput#pointer-acceleration
		accel_profile = "", --Sets the cursor acceleration profile. Can be one of adaptive, flat. Can also be custom, see below. Leave empty to use libinput’s default mode for your input device. libinput#pointer-acceleration [adaptive/flat/custom]
		force_no_accel = false, --Force no cursor acceleration. This bypasses most of your pointer settings to get as raw of a signal as possible. Enabling this is not recommended due to potential cursor desynchronization.
		left_handed = false, --Switches RMB and LMB
		scroll_points = "", --Sets the scroll acceleration profile, when accel_profile is set to custom. Has to be in the form <step> <points>. Leave empty to have a flat scroll curve.
		scroll_method = "2fg", --Sets the scroll method. Can be one of 2fg (2 fingers), edge, on_button_down, no_scroll. libinput#scrolling [2fg/edge/on_button_down/no_scroll]
		scroll_button = 0, --Sets the scroll button. Has to be an int, cannot be a string. Check wev if you have any doubts regarding the ID. 0 means default.
		scroll_button_lock = false, --If the scroll button lock is enabled, the button does not need to be held down. Pressing and releasing the button toggles the button lock, which logically holds the button down or releases it. While the button is logically held down, motion events are converted to scroll events.
		scroll_factor = 1.0, --Multiplier added to scroll movement for external mice. Note that there is a separate setting for touchpad scroll_factor.
		natural_scroll = false, --Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
		follow_mouse = 1, --Specify if and how cursor movement should affect window focus. See the note below. [0/1/2/3]
			--Follow Mouse Cursor 
			--0 - Cursor movement will not change focus.
			--1 - Cursor movement will always change focus to the window under the cursor.
			--2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
			--3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
		follow_mouse_threshold = 0.0, --The smallest distance in logical pixels the mouse needs to travel for the window under it to get focused. Works only with follow_mouse = 1.
		focus_on_close = 0, --Controls the window focus behavior when a window is closed. When set to 0, focus will shift to the next window candidate. When set to 1, focus will shift to the window under the cursor. [0/1]
		mouse_refocus = true, --If disabled, mouse focus won’t switch to the hovered window unless the mouse crosses a window boundary when follow_mouse=1.
		float_switch_override_focus = 1, --If enabled (1 or 2), focus will change to the window under the cursor when changing from tiled-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches.
		special_fallthrough = false, --if enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace.
		off_window_axis_events = 1, --Handles axis events around (gaps/border for tiled, dragarea/border for floated) a focused window. 0 ignores axis events 1 sends out-of-bound coordinates 2 fakes pointer coordinates to the closest point inside the window 3 warps the cursor to the closest point inside the window
		emulate_discrete_scroll = 1, --Emulates discrete scrolling from high resolution scrolling events. 0 disables it, 1 enables handling of non-standard events only, and 2 force enables all scroll wheel events to be handled

		touchpad = {
			disable_while_typing = true, --Disable the touchpad while typing.
				-- Will break with keyd daemon enabled
				-- https://github.com/rvaiya/keyd/#FAQS
					--This can be achieved by adding the following to /etc/libinput/local-overrides.quirks (which may need to be created):
					--```
					--[Serial Keyboards]
					--
					--MatchUdevType=keyboard
					--MatchName=keyd*keyboard
					--AttrKeyboardIntegration=internal
					--```
			natural_scroll = true, --Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
			scroll_factor = 1.0, --Multiplier applied to the amount of scroll movement.
			middle_button_emulation = false, --Sending LMB and RMB simultaneously will be interpreted as a middle click. This disables any touchpad area that would normally send a middle click based on location. libinput#middle-button-emulation
			tap_button_map = "", --Sets the tap button mapping for touchpad button emulation. Can be one of lrm (default) or lmr (Left, Middle, Right Buttons). [lrm/lmr]
			clickfinger_behavior = false, --Button presses with 1, 2, or 3 fingers will be mapped to LMB, RMB, and MMB respectively. This disables interpretation of clicks based on location on the touchpad. libinput#clickfinger-behavior
			tap_to_click = true, --Tapping on the touchpad with 1, 2, or 3 fingers will send LMB, RMB, and MMB respectively.
			drag_lock = 0, --When enabled, lifting the finger off while dragging will not drop the dragged item. 0 -> disabled, 1 -> enabled with timeout, 2 -> enabled sticky. libinput#tap-and-drag
			tap_and_drag = false, --Sets the tap and drag mode for the touchpad
			flip_x = false, --inverts the horizontal movement of the touchpad
			flip_y = false, --inverts the vertical movement of the touchpad
			drag_3fg = 0, --enables three finger drag, 0 -> disabled, 1 -> 3 fingers, 2 -> 4 fingers libinput#drag-3fg
		},

		touchdevice = {
			transform = 0, --transform the input from touchdevices. The possible transformations are the same as those of the monitors	int	0
			output = "", --the output to bind touch devices. Empty means unset and will use the current / autodetected.	string	[EMPTY]
			enabled = false, --Whether input is enabled for touch devices.
		},

		virtualkeyboard = {
			share_states = 2, --Unify key down states and modifier states with other keyboards. 0 -> no, 1 -> yes, 2 -> yes unless IME client
			release_pressed_on_close = false, --Release all pressed keys by virtual keyboard on close.
		},

		tablet = {
			-- something like a Wacom Graphics Tablet
			-- https://wiki.archlinux.org/title/Graphics_tablet#Wayland_and_libinput
			-- https://wiki.hypr.land/Configuring/Variables/#tablet
			transform = -1, --rotation, same as monitor rotation values
			--output = "eDP-1", --the monitor to bind tablets. Can be current or a monitor name. Leave empty to map across all monitors
			output = "HDMI-A-1",
			region_position = { 0, 0 }, --position of the mapped region in monitor layout relative to the top left corner of the bound monitor or all monitors
			absolute_region_position = false, --whether to treat the region_position as an absolute position in monitor layout. Only applies when output is empty
			region_size = { 0, 0 }, --size of the mapped region. When this variable is set, tablet input will be mapped to the region. [0, 0] or invalid size means unset
			relative_input = false, --whether the input should be relative
			left_handed = false, --if enabled, the tablet will be rotated 180 degrees
			active_area_size = { 0, 0 }, --size of tablet’s active area in mm
			--active_area_size = { 102.4, 43.98 },
			--active_area_size = { 32, 18 }, --OSU settings
			active_area_position = { 0, 0 }, --position of the active area in mm
			--active_area_position = { 25, 25 } --position of the active area in mm
		}
	},

	gestures = {
		workspace_swipe_distance = 300, --in px, the distance of the touchpad gesture
		workspace_swipe_touch = false, --enable workspace swiping from the edge of a touchscreen
		workspace_swipe_invert = true, --invert the direction (touchpad only)
		workspace_swipe_touch_invert = false, --invert the direction (touchscreen only)
		workspace_swipe_min_speed_to_force = 30, --minimum speed in px per timepoint to force the change ignoring cancel_ratio. Setting to 0 will disable this mechanic.
		workspace_swipe_cancel_ratio = 0.5, --how much the swipe has to proceed in order to commence it. (0.7 -> if > 0.7 * distance, switch, if less, revert) [0.0 - 1.0]
		workspace_swipe_create_new = false, --whether a swipe right on the last workspace should create a new one.
		workspace_swipe_direction_lock = true, --if enabled, switching direction will be locked when you swipe past the direction_lock_threshold (touchpad only).
		workspace_swipe_direction_lock_threshold = 10, --in px, the distance to swipe before direction lock activates (touchpad only).
		workspace_swipe_forever = false, --if enabled, swiping will not clamp at the neighboring workspaces but continue to the further ones.
		workspace_swipe_use_r = false, --if enabled, swiping will use the r prefix instead of the m prefix for finding workspaces.
		close_max_timeout = 1000, --the timeout for a window to close when using a 1:1 gesture, in ms
	},

	group = {
		auto_group = false, --whether new windows will be automatically grouped into the focused unlocked group. Note: if you want to disable auto_group only for specific windows, use the “group barred” window rule instead.
		insert_after_current = true, --whether new windows in a group spawn after current or at group tail
		focus_removed_window = true, --whether Hyprland should focus on the window that has just been moved out of the group
		drag_into_group = 1, --whether dragging a window into a unlocked group will merge them. Options: 0 (disabled), 1 (enabled), 2 (only when dragging into the groupbar)
		merge_groups_on_drag = true, --whether window groups can be dragged into other groups
		merge_groups_on_groupbar = true, --whether one group will be merged with another when dragged into its groupbar
		merge_floated_into_tiled_on_groupbar = false, --whether dragging a floating window into a tiled window groupbar will merge them
		group_on_movetoworkspace = false, --whether using movetoworkspace[silent] will merge the window into the workspace’s solitary unlocked group
		col = {
			border_active = "rgb(F2002B)", --active group border color
			border_inactive = "rgb(52002B)", --inactive (out of focus) group border color
			border_locked_active = "rgb(FF00FF)", --active locked group border color
			border_locked_inactive = "rgb(5F005F)", --inactive locked group border color
		},

		groupbar = {
			enabled = false, --enables groupbars
			font_family = "Hack", --font used to display groupbar titles, use misc:font_family if not specified
			font_size = 8, --font size of groupbar title
			font_weight_active = "normal", --font weight of active groupbar title
			font_weight_inactive = "normal", --font weight of inactive groupbar title
			gradients = true, --enables gradients
			height = 10, --height of the groupbar
			indicator_gap = 0, --height of gap between groupbar indicator and title
			indicator_height = 3, --height of the groupbar indicator
			stacked = false, --render the groupbar as a vertical stack
			priority = 3, --sets the decoration priority for groupbars
			render_titles = true, --whether to render titles in the group bar decoration
			text_offset = 0, --adjust vertical position for titles
			scrolling = true, --whether scrolling in the groupbar changes group active window
			rounding = 1, --how much to round the indicator
			rounding_power = 2.0, --adjusts the curve used for rounding broupbar corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
			gradient_rounding = 2, --how much to round the gradients
			gradient_rounding_power = 2.0, --adjusts the curve used for rounding gradient corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
			round_only_edges = true, --round only the indicator edges of the entire groupbar
			gradient_round_only_edges = true, --round only the gradient edges of the entire groupbar
			text_color = "rgba(ffffffff)", --color for window titles in the groupbar
			--text_color_inactive =, --color for inactive windows’ titles in the groupbar (if unset, defaults to text_color)
			--text_color_locked_active =, --color for the active window’s title in a locked group (if unset, defaults to text_color)
			--text_color_locked_inactive =, --color for inactive windows’ titles in locked groups (if unset, defaults to text_color_inactive)
			col = {
				active = 0x66ffff00, --active group bar background color
				inactive = 0x66777700, --inactive (out of focus) group bar background color
				locked_active = 0x66ff5500, --active locked group bar background color
				locked_inactive = 0x66775500, --inactive locked group bar background color
			},
			gaps_in = 2, --gap size between gradients
			gaps_out = 2, --gap size between gradients and window
			keep_upper_gap = true, --add or remove upper gap
		}
	},

	misc = {
		disable_hyprland_logo = true, --disables the random Hyprland logo / anime girl background. :(
		disable_splash_rendering = true, --disables the Hyprland splash rendering. (requires a monitor reload to take effect)
		--disable_scale_notification = false, --disables notification popup when a monitor fails to set a suitable scale
		col = {
			splash = 0xffffffff, --Changes the color of the splash text (requires a monitor reload to take effect).
		},
		font_family = "Sans", --Set the global default font to render the text including debug fps/notification, config error messages and etc., selected from system fonts.
		splash_font_family = "", --Changes the font used to render the splash text, selected from system fonts (requires a monitor reload to take effect).
		force_default_wallpaper = 0, --Enforce any of the 3 default wallpapers. Setting this to 0 or 1 disables the anime background. -1 means “random”. [-1/0/1/2]
		vrr = 0, --controls the VRR (Adaptive Sync) of your monitors. 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with video or game content type [0/1/2/3]
		mouse_move_enables_dpms = false, --If DPMS is set to off, wake up the monitors if the mouse moves.
		key_press_enables_dpms = false, --If DPMS is set to off, wake up the monitors if a key is pressed.
		name_vk_after_proc = true, --Name virtual keyboards after the processes that create them. E.g. /usr/bin/fcitx5 will have hl-virtual-keyboard-fcitx5.
		always_follow_on_dnd = true, --Will make mouse focus follow the mouse when drag and dropping. Recommended to leave it enabled, especially for people using focus follows mouse at 0.
		layers_hog_keyboard_focus = true, --If true, will make keyboard-interactive layers keep their focus on mouse move (e.g. wofi, bemenu)
		animate_manual_resizes = false, --If true, will animate manual window resizes/moves
		animate_mouse_windowdragging = false, --If true, will animate windows being dragged by mouse, note that this can cause weird behavior on some curves
		disable_autoreload = false, --If true, the config will not reload automatically on save, and instead needs to be reloaded with hyprctl reload. Might save on battery.
		enable_swallow = false, --Enable window swallowing
		swallow_regex = "", --The class regex to be used for windows that should be swallowed (usually, a terminal). To know more about the list of regex which can be used use this cheatsheet.
		swallow_exception_regex = "", --The title regex to be used for windows that should not be swallowed by the windows specified in swallow_regex (e.g. wev). The regex is matched against the parent (e.g. Kitty) window’s title on the assumption that it changes to whatever process it’s running.
		focus_on_activate = false, --Whether Hyprland should focus an app that requests to be focused (an activate request)
		mouse_move_focuses_monitor = true, --Whether mouse moving into a different monitor should focus it
		allow_session_lock_restore = false, --if true, will allow you to restart a lockscreen app in case it crashes
		session_lock_xray = false, --if true, keep rendering workspaces below your lockscreen
		background_color = 0x111111, --change the background color. (requires enabled disable_hyprland_logo)
		close_special_on_empty = true, --close the special workspace if the last window is removed
		exit_window_retains_fullscreen = false, --if true, closing a fullscreen window makes the next focused window fullscreen
		initial_workspace_tracking = 1, --if enabled, windows will open on the workspace they were invoked on. 0 - disabled, 1 - single-shot, 2 - persistent (all children too)
		middle_click_paste = true, --whether to enable middle-click-paste (aka primary selection)
		render_unfocused_fps = 15, --the maximum limit for renderunfocused windows’ fps in the background (see also Window-Rules - renderunfocused)
		disable_xdg_env_checks = false, --disable the warning if XDG environment is externally managed
		lockdead_screen_delay = 1000, --delay after which the “lockdead” screen will appear in case a lockscreen app fails to cover all the outputs (5 seconds max)
		enable_anr_dialog = true, --whether to enable the ANR (app not responding) dialog when your apps hang
		anr_missed_pings = 1, --number of missed pings before showing the ANR dialog
	},

	binds = {
		pass_mouse_when_bound = false, --if disabled, will not pass the mouse events to apps / dragging windows around if a keybind has been triggered.
		scroll_event_delay = 300, --in ms, how many ms to wait after a scroll event to allow passing another one for the binds.
		workspace_back_and_forth = false, --If enabled, an attempt to switch to the currently focused workspace will instead switch to the previous workspace. Akin to i3’s auto_back_and_forth.
		hide_special_on_workspace_change = false, --If enabled, changing the active workspace (including to itself) will hide the special workspace on the monitor where the newly active workspace resides.
		allow_workspace_cycles = false, --If enabled, workspaces don’t forget their previous workspace, so cycles can be created by switching to the first workspace in a sequence, then endlessly going to the previous workspace.
		workspace_center_on = 0, --Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)
		focus_preferred_method = 0, --sets the preferred focus finding method when using focuswindow/movewindow/etc with a direction. 0 - history (recent have priority), 1 - length (longer shared edges have priority)
		ignore_group_lock = false, --If enabled, dispatchers like moveintogroup, moveoutofgroup and movewindoworgroup will ignore lock per group.
		movefocus_cycles_fullscreen = false, --If enabled, when on a fullscreen window, movefocus will cycle fullscreen, if not, it will move the focus in a direction.
		movefocus_cycles_groupfirst = false, --If enabled, when in a grouped window, movefocus will cycle windows in the groups first, then at each ends of tabs, it’ll move on to other windows/groups
		disable_keybind_grabbing = false, --If enabled, apps that request keybinds to be disabled (e.g. VMs) will not be able to do so.
		window_direction_monitor_fallback = true, --If enabled, moving a window or focus over the edge of a monitor with a direction will move it to the next monitor in that direction.
		allow_pin_fullscreen = false, --If enabled, Allow fullscreen to pinned windows, and restore their pinned status afterwards
		drag_threshold = 0, --Movement threshold in pixels for window dragging and c/g bind flags. 0 to disable and grab on mousedown.
	},

	xwayland = {
		enabled = true, --allow running applications using X11
		use_nearest_neighbor = true, --uses the nearest neighbor filtering for xwayland apps, making them pixelated rather than blurry
		force_zero_scaling = true, --forces a scale of 1 on xwayland windows on scaled displays.
		create_abstract_socket = false, --Create the abstract Unix domain socket for XWayland connections. (XWayland restart is required for changes to take effect; Linux only)
	},

	opengl = {
		nvidia_anti_flicker = true, --reduces flickering on nvidia at the cost of possible frame drops on lower-end GPUs. On non-nvidia, this is ignored.
	},

	render = {
		direct_scanout = 0, --Enables direct scanout. Direct scanout attempts to reduce lag when there is only one fullscreen application on a screen (e.g. game). It is also recommended to set this to false if the fullscreen application shows graphical glitches. 0 - off, 1 - on, 2 - auto (on with content type ‘game’)
		expand_undersized_textures = true, --Whether to expand undersized textures along the edge, or rather stretch the entire texture.
		xp_mode = false, --Disables back buffer and bottom layer rendering.
		ctm_animation = 2, --Whether to enable a fade animation for CTM changes (hyprsunset). 2 means “auto” which disables them on Nvidia.
		cm_enabled = true, --Whether the color management pipeline should be enabled or not (requires a restart of Hyprland to fully take effect)
		send_content_type = true, --Report content type to allow monitor profile autoswitch (may result in a black screen during the switch)
		cm_auto_hdr = 1, --Auto-switch to HDR in fullscreen when needed. 0 - off, 1 - switch to cm, hdr, 2 - switch to cm, hdredid
		new_render_scheduling = false, --Automatically uses triple buffering when needed, improves FPS on underpowered devices.
	},

	cursor = {
		invisible = false, --don’t render cursors
		sync_gsettings_theme = true, --sync xcursor theme with gsettings, it applies cursor-theme and cursor-size on theme load to gsettings making most CSD gtk based clients use same xcursor theme and size.
		no_hardware_cursors = 2, --disables hardware cursors. 0 - use hw cursors if possible, 1 - don’t use hw cursors, 2 - auto (disable when tearing)
		no_break_fs_vrr = 2, --disables scheduling new frames on cursor movement for fullscreen apps with VRR enabled to avoid framerate spikes (may require no_hardware_cursors = true) 0 - off, 1 - on, 2 - auto (on with content type ‘game’)
		min_refresh_rate = 24, --minimum refresh rate for cursor movement when no_break_fs_vrr is active. Set to minimum supported refresh rate or higher
		hotspot_padding = 0, --the padding, in logical px, between screen edges and the cursor
		inactive_timeout = 0, --in seconds, after how many seconds of cursor’s inactivity to hide it. Set to 0 for never.
		no_warps = false, --if true, will not warp the cursor in many cases (focusing, keybinds, etc)
		persistent_warps = false, --When a window is refocused, the cursor returns to its last position relative to that window, rather than to the centre.
		warp_on_change_workspace = 0, --Move the cursor to the last focused window after changing the workspace. Options: 0 (Disabled), 1 (Enabled), 2 (Force - ignores cursor:no_warps option)
		warp_on_toggle_special = 0, --Move the cursor to the last focused window when toggling a special workspace. Options: 0 (Disabled), 1 (Enabled), 2 (Force - ignores cursor:no_warps option)
		default_monitor = "eDP-1", --the name of a default monitor for the cursor to be set to on startup (see hyprctl monitors for names)
		zoom_factor = 1.0, --the factor to zoom by around the cursor. Like a magnifying glass. Minimum 1.0 (meaning no zoom)
		zoom_rigid = true, --whether the zoom should follow the cursor rigidly (cursor is always centered if it can be) or loosely
		enable_hyprcursor = true, --whether to enable hyprcursor support
		hide_on_key_press = true, --Hides the cursor when you press any key until the mouse is moved.
		hide_on_touch = false, --Hides the cursor when the last input was a touch input until a mouse input is done.
		use_cpu_buffer = 2, --Makes HW cursors use a CPU buffer. Required on Nvidia to have HW cursors. 0 - off, 1 - on, 2 - auto (nvidia only)
		warp_back_after_non_mouse_input = false, --Warp the cursor back to where it was after using a non-mouse input to move it, and then returning back to mouse.
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
		enforce_permissions = false
	}
})

-- CURSOR VARIBALES
	--env = XCURSOR_SIZE,24 --Set cursor size. See here for why you might want this variable set.
	--env = XCURSOR_THEME,breeze_cursors --Set your cursor theme. The theme needs to be installed and readable by your user.
	hl.env("WLR_NO_HARDWARE_CURSORS", "1") --no mouse on mirrored display...?
	hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
	hl.env("HYPRCURSOR_SIZE", "24")

-- INPUT METHOD / FCITX VARIABLES
	hl.env("GTK_IM_MODULE", "fcitx")
	hl.env("QT_IM_MODULE", "fcitx")
		--env = QT_IM_MODULES,wayland;fcitx;ibus --Qt 6.7

	hl.env("SDL_IM_MODULE", "fcitx")
	hl.env("XMODIFIERS", "@im=fcitx")
	hl.env("XIM_SERVERS", "fcitx")

-- TOOLKIT BACKEND VARIABLES
	hl.env("GDK_BACKEND", "wayland,x11,*") --GTK: Use wayland if available. If not: try x11, then any other GDK backend. not.
	hl.env("QT_QPA_PLATFORM", "wayland;xcb") --Qt: Use wayland if available, fall back to x11 if not.
	--env = SDL_VIDEODRIVER,wayland #Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues #breaks brawlhalla as of Thursday, June 06, 2024, 17:44:48 "https://www.reddit.com/r/linux_gaming/comments/19ceum5/eac_error_failed_to_initialize_dependencies_when/" add "env -u SDL_VIDEODRIVER" to launch options for brawlhalla
	hl.env("CLUTTER_BACKEND", "wayland") --Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend

-- XDG SPECIFICATIONS
	hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
	hl.env("XDG_SESSION_TYPE", "wayland")
	hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- QT VARIABLES
	--"https://doc.qt.io/qt-6/qtquickcontrols-universal.html"
	hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1") --(From the Qt documentation) enables automatic scaling, based on the monitor’s pixel density
	hl.env("QT_QPA_PLATFORM", "wayland;xcb") --Tell Qt applications to use the Wayland backend, and fall back to x11 if Wayland is unavailable
	hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1") --Disables window decorations on Qt applications

	hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
	--hl.env("QT_STYLE_OVERRIDE", "kvantum-dark")
		--"https://forum.manjaro.org/t/cant-change-qt-qpa-platformtheme-to-anything-but-qt5ct/27963/4"
		--QT_QPA_PLATFORMTHEME="<value>"
			-- qt5ct: requires qt5ct
			-- gtk2: requires qt5-styleplugins
			-- gnome: requires qgnomeplatform
			-- kde

		-- Only if you want to override what the Platform Theme provides
		--QT_STYLE_OVERRIDE="<value>"
			-- Adwaita / Adwaita-Dark: requires qgnomeplatform
			-- kvantum / kvantum-dark: requires kvantum-qt5
			-- Windows
			-- Fusion

	hl.env("QT_QUICK_CONTROLS_UNIVERSAL_THEME", "Dark") --Light, System
	--env = QT_QUICK_CONTROLS_UNIVERSAL_ACCENT
	--env = QT_QUICK_CONTROLS_UNIVERSAL_FOREGROUND
	--env = QT_QUICK_CONTROLS_UNIVERSAL_BACKGROUND
		--Universal.Lime			#A4C400
		--Universal.Green		#60A917
		--Universal.Emerald		#008A00
		--Universal.Teal			#00ABA9
		--Universal.Cyan			#1BA1E2
		--Universal.Cobalt		#3E65FF (default accent)
		--Universal.Indigo		#6A00FF
		--Universal.Violet		#AA00FF
		--Universal.Pink			#F472D0
		--Universal.Magenta		#D80073
		--Universal.Crimson		#A20025
		--Universal.Red			#E51400
		--Universal.Orange		#FA6800
		--Universal.Amber		#F0A30A
		--Universal.Yellow		#E3C800
		--Universal.Brown		#825A2C
		--Universal.Olive		#6D8764
		--Universal.Steel		#647687
		--Universal.Mauve		#76608A
		--Universal.Taupe		#87794E

-- THEMING
	--env = GTK_THEME,Orchis-Dark #Set a GTK theme manually, for those who want to avoid appearance tools such as lxappearance or nwg-look
