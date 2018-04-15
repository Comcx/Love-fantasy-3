






loadWindow = function(conf_window)

	love.window.setMode(conf_window.width, conf_window.height, {resizable = true, vsync = false,
						minwidth = conf_window.minWidth, minheight = conf_window.minHeight})

	love.graphics.setBackgroundColor(conf_window.bgColor)

end





