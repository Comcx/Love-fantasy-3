
-----========================2D game using LOVE engine=========================-----


require "window"
require "image"



---window configurations---

local conf_window = {

	width		= 1000,
	height		= 570,
	minWidth	= 300,
	minHeigth	= 200,

	bgColor		= {255, 255, 255}

}

local str_imgBgPath = "kris.jpg"
local str_imgDialog = "dialog.jpg"


---Useful Colors---

local color = {}
color.keep		= {255,		174,	201}
color.black		= {0,		0,		0}
color.white		= {255,		255,	255}
color.red		= {255,		0,		0}
color.green		= {0,		255,	0}
color.blue		= {0,		0,		255}
color.yellow	= {255,		255,	0}



---global coordinate settings---

local coord = {

	bgI			= {x = 0, y = 0},
	dialog		= {x = 5, y = conf_window.height - 190},

}



---=====class Button====---


local Button = function(size, text, func, mode)

	local this = {}
	this.size = size
	this.text = love.graphics.newText(love.graphics.newFont(15), text or "")
	this.color_text = color.black

	this.work = func or function(self) end
	this.mode = mode or 1

	this.x, this.y = -1, -1

	this.show = function(self, x, y)

		if self.mode == 1 then
			love.graphics.setColor(self.color_text)
			love.graphics.draw(self.text, x, y)
		end
		this.x, this.y = x, y
	end

	this.isClicked = function(self, x, y)

		if	x >= self.x and x <= self.x + self.size[1] and
			y >= self.y and y <= self.y + self.size[2] then

			return true
		else

			return false
		end
	end


	return this
end





---=====class Menu=====---

local Menu = function(buttons)


	local menu = {

		buttons = buttons,
		showState = true,

		show = function(self, x, y, interval)

			counter = 0
			for k, button in pairs(self.buttons) do

				button:show(x + counter*interval, y)
				counter = counter + 1
			end
		end,

		hide = function(self)

			self.showState = false
		end


	}


	return menu
end



local DialogBox = function(img_dialog, menu)

	local this = {}
	this.x = x
	this.y = y
	this.menu = menu
	this.showState = true

	this.show = function(self, x, y, interval)

		interval = interval or 50

		drawImage(img_dialog, x, y, interval)
		if menu ~= nil and menu.showState ~= false then
			menu:show(360, y + 150, interval)
		end

	end

	return this
end


img_bgI		= love.graphics.newImage(str_imgBgPath)
img_dialog	= love.graphics.newImage(str_imgDialog)
--img_image	= love.graphics.newImage("golf_small.jpg")



local buttons = {

	back = Button({25, 15}, "back"),
	hide = Button({25, 15}, "hide", function(self, dialog)

		dialog.showState = false
		coord["dialog"].y = coord["dialog"].y + 200
	end),
	quit = Button({25, 15}, "exit"),
	full = Button({70, 15}, "full screen"),
}

local menu = Menu(buttons)

local dialogBox = DialogBox(img_dialog, menu)






----================Main game callback functions for engine==================----



love.load = function()

	loadWindow(conf_window)


	font		= love.graphics.newFont(20)
	text		= love.graphics.newText(font, "Playing music AyaRuKa.mp3")
	music		= love.audio.newSource("AyaRuKa.mp3", "stream")

	---menu on dialog box---


	music:setVolume(0.03)
	music:play()


end


love.draw = function()

	--background image--
	drawBgImage(img_bgI, conf_window, coord["bgI"].x, coord["bgI"].y)

	--dialog box--
	dialogBox:show(coord["dialog"].x, coord["dialog"].y)

	--drawImage(img_image, imgx, imgy)


	love.graphics.setColor(color.black)
	love.graphics.draw(text, 20, 50)
	love.graphics.print("game initing...", 10, 10)
	love.graphics.print(tostring(dialogBox.showState), printx, printy)



end




love.update = function(dt)

	x = love.mouse.getX()
	y = love.mouse.getY()

	for k, v in pairs(menu.buttons) do

		if v:isClicked(x, y) then
			v.color_text = color.yellow
		else
			v.color_text = color.black
		end
	end


	if love.keyboard.isDown("down") then

		coord["dialog"].y = coord["dialog"].y + 1
		color_menu = color.black
	elseif love.keyboard.isDown("up") then

		coord["dialog"].y = coord["dialog"].y - 1
		test_color = color.red
		color_menu = color.green
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

		if dialogBox.showState == true then

			dialogBox.menu.buttons["hide"]:work(dialogBox)
		else
			coord["dialog"].y = coord["dialog"].y - 200
			dialogBox.showState = true
		end

	end

end


--[[
function love.mousereleased(x, y, button)
   if button == 1 then
      printx = x
      printy = y
   end
end
]]

love.quit = function()

	love.window.showMessageBox("leaving...", "Thanks for playing! Come back soon!")
end













