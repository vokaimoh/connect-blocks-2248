local M = {}

M.hexagon_colors = {
	vmath.vector4(1, 0.45, 0.45, 1),           -- 2
	vmath.vector4(1, 1, 0.35, 1),              -- 4
	vmath.vector4(0.58, 1, 0.36, 1),           -- 8
	vmath.vector4(0.42, 0.71, 1, 1),           -- 16
	vmath.vector4(0.5294118, 0.9441384, 1, 1), -- 32
	vmath.vector4(1, 0.7713224, 0.3194118, 1), -- 64
	vmath.vector4(0.56, 0.53, 1, 1),           -- 128
	vmath.vector4(0.7542225, 0.4794118, 1, 1), -- 256
	vmath.vector4(0.98, 0.43, 1, 1)            -- 512
}

M.duration_pong = 1.85
M.duration_over = 1.1
M.duration_step = 0.85
M.duration_remove = 0.65
M.duration_fade = 0.5
M.duration_fall = 0.4
M.duration_preview = 0.325
M.duration_create = 0.25
M.duration_switch = 0.13

M.save_file = "hexagon2248_main_saveload"

M.clear_color = hash("clear_color")
M.window_resized = hash("window_resized")
M.fade_in = hash("fade_in")
M.fade_out = hash("fade_out")
M.scale_in = hash("scale_in")
M.scale_out = hash("scale_out")
M.touch = hash("touch")
M.start = hash("start")
M.game = hash("game")
M.over = hash("over")
M.help = hash("help")
M.settings = hash("settings")
M.cells_clear = hash("cells_clear")
M.delete = hash("delete")
M.hide = hash("hide")
M.level_up = hash("level_up")
M.set_score = hash("set_score")
M.set_preview = hash("set_preview")

function M.load_level()
	return (sys.load(sys.get_save_file(M.save_file, "level"))).level or 2
end

function M.load_score()
	return (sys.load(sys.get_save_file(M.save_file, "score"))).score or 0
end

function M.load_cells()
	return (sys.load(sys.get_save_file(M.save_file, "cells"))).cells or nil
end

function M.load_volume()
	return (sys.load(sys.get_save_file(M.save_file, "volume"))).volume or 1
end

function M.load_best()
	return (sys.load(sys.get_save_file(M.save_file, "best"))).best or 0
end

M.proj = vmath.matrix4()
M.width = tonumber(sys.get_config("display.width")) or 540
M.height = tonumber(sys.get_config("display.height")) or 960

M.cell_size = 90
M.cell_offset_x = ((M.width - M.cell_size * 5) / 2) + M.cell_size / 2
M.cell_offset_y = ((M.height - M.cell_size * 7.5) / 2) + M.cell_size / 2
M.radius_select = 40
M.radius_connect = 110
M.last = 0
M.best = M.load_best()
M.volume = M.load_volume()
M.volume_max = 0.7
M.level = 2
M.log2 = math.log(2)
M.quat1 = vmath.quat_rotation_z(1.57)
M.quat2 = vmath.quat_rotation_z(0.52)
M.quat3 = vmath.quat_rotation_z(-0.52)
M.vector3_zero = vmath.vector3()
M.vector3_unit = vmath.vector3(1, 1, 1)
M.vector3_scale = vmath.vector3(0.85, 0.85, 1)
M.vector4_unit = vmath.vector4(1, 1, 1, 1)
M.vector4_pressed = vmath.vector4(0.85, 0.85, 0.85, 1)
M.matrix4_zero = vmath.matrix4()

function M.random_init()
	math.randomseed(100000 * (socket.gettime() % 1))
	math.random()
	math.random()
	math.random()
end

function M.input_focus_waiting(duration)
	timer.delay(duration, false, function()
		msg.post(".", "acquire_input_focus")
	end)
end

function M.gui_switch(name)
	msg.post(".", "release_input_focus")
	msg.post(".", "fade_out", { duration = M.duration_fade })
	timer.delay(M.duration_fade, false, function()
		msg.post("/main#main", name)
	end)
end

function M.gui_message(box, message_id, message)
	if message_id == M.fade_in then
		gui.set_alpha(box, 0)
		gui.animate(box, "color.w", 1, gui.EASING_LINEAR, message.duration)
	elseif message_id == M.fade_out then
		gui.animate(box, "color.w", 0, gui.EASING_LINEAR, message.duration)
	end
end

function M.gui_init()
	M.input_focus_waiting(M.duration_create)
	msg.post(".", "fade_in", { duration = M.duration_fade })
end

function M.screen_to_world(screen)
	local inv = vmath.inv(M.proj)
	screen.x = (2 * screen.x / M.width) - 1
	screen.y = (2 * screen.y / M.height) - 1
	screen.z = (2 * screen.z) - 1
	local x = screen.x * inv.m00 + screen.y * inv.m01 + screen.z * inv.m02 + inv.m03
	local y = screen.x * inv.m10 + screen.y * inv.m11 + screen.z * inv.m12 + inv.m13
	local z = screen.x * inv.m20 + screen.y * inv.m21 + screen.z * inv.m22 + inv.m23
	screen.x = x
	screen.y = y
	screen.z = z
	return screen
end


function M.save_level(current_level)
	sys.save(sys.get_save_file(M.save_file, "level"), { level = current_level })
end

function M.save_score(current_score)
	sys.save(sys.get_save_file(M.save_file, "score"), { score = current_score })
end

function M.save_cells(current_cells)
	sys.save(sys.get_save_file(M.save_file, "cells"), { cells = current_cells })
end

function M.save_volume()
	sys.save(sys.get_save_file(M.save_file, "volume"), { volume = M.volume })
end

function M.save_best(current)
	sys.save(sys.get_save_file(M.save_file, "best"), { best = current })
end

return M
