



color_keep = {255, 174, 201, 1}


drawBGImage = function(image, conf_window, x, y)

	local x, y = x or 0, y or 0

	love.graphics.setColor(color_keep)
	local quad_bg	= love.graphics.newQuad(0, 0, conf_window.width, conf_window.height,
									image:getWidth(), image:getHeight())

	love.graphics.draw(image, quad_bg, x, y)

end


drawImage = function(image, x, y)

	love.graphics.setColor(color_keep)
	love.graphics.draw(image, x, y)

end


