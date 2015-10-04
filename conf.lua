function love.conf(t)
	t.version = "0.9.2"
	t.window = t.window

	t.identity = "Matchmaker"
	t.console = true

	t.window.title = "Matchmaker"
	t.window.icon = nil
	t.window.width = 800
	t.window.height = 600
	t.window.borderless = false
	t.window.resizable = false
	t.window.minwidth = 1
	t.window.minheight = 1
	t.window.fullscreen = false
	t.window.fullscreentype = "desktop"
	t.window.vsync = true
	t.window.fsaa = 0
	t.window.display = 1

	t.modules.audio = false
	t.modules.event = false
	t.modules.graphics = false
	t.modules.image = false
	t.modules.joystick = false
	t.modules.keyboard = false
	t.modules.math = false
	t.modules.mouse = false
	t.modules.physics = false
	t.modules.sound = false
	t.modules.system = false
	t.modules.timer = false
	t.modules.window = false
end