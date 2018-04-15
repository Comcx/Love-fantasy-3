
-----========================2D game using LOVE engine=========================-----


require "window"
require "image"



---window configurations---

conf_window = {

	width		= 1000,
	height		= 600,
	minWidth	= 300,
	minHeigth	= 200,

	bgColor		= {255, 255, 255}

}

str_imgBgPath = "kris.jpg"
str_imgDialog = "dialog.jpg"


---Useful Colors---

color = {}
color.keep		= {255,		174,	201}
color.black		= {0,		0,		0}
color.white		= {255,		255,	255}
color.red		= {255,		0,		0}
color.green		= {0,		255,	0}
color.blue		= {0,		0,		255}
color.yellow	= {0,		255,	255}




---=====class Menu=====---

newMenu = function(item, order)

	local fn_back = function() end
	local fn_hide = function() end
	local fn_quit = function() end



	local menu = {

		item = item or {
			"back",
			"hide",
			"quit",
			"full screen"
		},

		txt_item = love.graphics.newText(love.graphics.newFont(15), table.concat(item, "\t")),

		back = order.back or fn_back,
		hide = order.hide or fn_hide,
		quit = order.quit or fn_quit,

		show = function(self, x, y, color)

			love.graphics.setColor(color)
			love.graphics.draw(self.txt_item, x, y)
		end,


	}


	return menu
end







----================Main game callback functions for engine==================----



love.load = function()

	loadWindow(conf_window)

	img_bgI		= love.graphics.newImage(str_imgBgPath)
	img_dialog	= love.graphics.newImage(str_imgDialog)
	img_image	= love.graphics.newImage("golf_small.jpg")
	font		= love.graphics.newFont(20)
	text		= love.graphics.newText(font, "Playing music AyaRuKa.mp3")
	music		= love.audio.newSource("AyaRuKa.mp3", "stream")

	menu = newMenu({"back", "hide", "quit", "full screen"},
					{
						back = function()	return -1 end,
						hide = function() end,
						quit = function() end,

					})

	music:setVolume(0.03)
	music:play()


end


love.draw = function()

	drawBgImage(img_bgI, conf_window, 0, 0)

	drawImage(img_dialog, 5, 400)
	drawImage(img_image, imgx, imgy)

	love.graphics.setColor(color.black)
	love.graphics.draw(text, 20, 450)
	love.graphics.print("game initing...", 10, 10)
	love.graphics.print(love.window.getTitle(), printx, printy)

	menu:show(360, 550, color.black)
end


love.update = function(dt)

	if love.keyboard.isDown("up") then
		num = num + 100 * dt -- this would increment num by 100 per second
	end
end


love.keypressed = function(key)

	if key == 'b' then
		text = "The B key was pressed."
	elseif key == 'a' then
		a_down = true
	end
end


love.mousepressed = function(x, y, button, istouch)

	if button == 1 then

		imgx = x -- move image to where mouse clicked
		imgy = y

	elseif button == 2 then

		printx = x
		printy = y

	end
end


--[[
function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		fireSlingshot(x,y) -- this totally awesome custom function is defined elsewhere
	end
end
]]


love.quit = function()

	love.window.showMessageBox("leaving...", "Thanks for playing! Come back soon!")
end

