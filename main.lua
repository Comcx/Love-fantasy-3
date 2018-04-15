
-----========================2D game using LOVE engine=========================-----


require "window"
require "image"



---window configurations---

conf_window = {

	width		= 1000,
	height		= 570,
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



---global coordinate settings---

coord = {

	bgI			= {x = 0, y = 0},
	dialog		= {x = 5, y = conf_window.height - 190},

}




---=====class Menu=====---

newMenu = function(item, order)

	local fn_back = function(self) end
	local fn_hide = function(self) end
	local fn_quit = function(self) end


	local menu = {

		item = item or {
			"back",
			"hide",
			"quit",
			"full screen"
		},

		txt_item = love.graphics.newText(love.graphics.newFont(15), table.concat(item, "\t")),
		showState = true,

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

	---menu on dialog box---
	menu = newMenu({"back", "hide", "quit", "full screen"},
					{
						back = function(self)	return -1 end,
						hide = function(self)

							if self.showState == true then
								coord["dialog"].y = coord["dialog"].y + 200
								self.showState = false
							else
								coord["dialog"].y = coord["dialog"].y - 200
								self.showState = true
							end
						end,

						quit = function(self) end,

					})

	music:setVolume(0.03)
	music:play()


end


love.draw = function()

	--background image--
	drawBgImage(img_bgI, conf_window, coord["bgI"].x, coord["bgI"].y)

	--dialog image--
	drawImage(img_dialog, coord["dialog"].x, coord["dialog"].y)
	menu:show(360, coord["dialog"].y + 150, color.black)

	drawImage(img_image, imgx, imgy)

	love.graphics.setColor(color.black)
	love.graphics.draw(text, 20, 450)
	love.graphics.print("game initing...", 10, 10)
	love.graphics.print(love.window.getTitle(), printx, printy)


end




love.update = function(dt)



	if love.keyboard.isDown("down") then

		coord["dialog"].y = coord["dialog"].y + 1
	elseif love.keyboard.isDown("up") then

		coord["dialog"].y = coord["dialog"].y - 1
	end


end


love.keypressed = function(key)

	--[[
	if key == 'b' then
		text = "The B key was pressed."
	elseif key == 'a' then
		a_down = true
	end]]
end


love.mousepressed = function(x, y, button, istouch)

	if button == 1 then

		imgx = x -- move image to where mouse clicked
		imgy = y

	elseif button == 2 then

		menu:hide()

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

