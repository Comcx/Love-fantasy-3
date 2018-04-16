
-----========================2D game using LOVE engine=========================-----


require "window"
require "image"



---window configurations---

local conf_window = {

	width		= 1280,
	height		= 720,
	minWidth	= 300,
	minHeigth	= 200,

	bgColor		= {255, 255, 255}

}

local str_imgBgPath = "409.png"
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
	dialog		= {x = 150, y = conf_window.height - 190},

}



---=====class Button====---


local Button = function(size, text, func, mode)

	local this = {}
	this.size = size
	this.name = text
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

	this.isTouched = function(self, x, y)

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

		show = function(self, x, y, interval, order)

			interval = interval or 50
			local counter = 0

			if not order then
				for k, button in pairs(self.buttons) do

					button:show(x + counter*interval, y)
					counter = counter + 1
				end
			else
				for _, k in pairs(order) do

					self.buttons[k]:show(x + counter*interval, y)
					counter = counter + 1
				end
			end
		end,


		hide = function(self)

			self.showState = false
		end


	}


	return menu
end



local DialogBox = function(img_dialog)

	local this = {}

	this.x = -1
	this.y = -1
	this.menu = menu
	this.showState = true

	this.show = function(self, x, y)

		self.x = x
		self.y = y

		drawImage(img_dialog, x, y)
	end

	this.print = function(self, str_text)

		love.graphics.draw(love.graphics.newText(love.graphics.newFont(20), str_text),
							coord["dialog"].x + 50, coord["dialog"].y + 50)

	end

	return this
end


img_bgI		= love.graphics.newImage(str_imgBgPath)
img_dialog	= love.graphics.newImage(str_imgDialog)
--img_image	= love.graphics.newImage("golf_small.jpg")



local buttons_main = {

	["back"] = Button({30, 15}, "back"),
	["hide"] = Button({30, 15}, "hide", function(self, dialog)

		dialog.showState = false
		coord["dialog"].y = coord["dialog"].y + 200
	end),
	["exit"] = Button({30, 15}, "exit", function(self) love.event.quit(0) end),
	["full"] = Button({70, 15}, "full screen",
					function(self) love.window.showMessageBox("Sorry","This function is under construction") end),
}

local buttons_dialog = {

	["next"] = Button({30, 15}, "next"),
	["auto"] = Button({30, 15}, "auto")

}



local menu_main = Menu(buttons_main)
local menu_dialog = Menu(buttons_dialog)

local dialogBox = DialogBox(img_dialog)






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
	menu_main:show(500, coord["dialog"].y + 150, 50, {"back", "hide", "exit", "full"})
	menu_dialog:show(1000, coord["dialog"].y + 150, 50, {"next", "auto"})

	dialogBox:print("What are you doing?!")

	--drawImage(img_image, imgx, imgy)


	love.graphics.setColor(color.black)
	love.graphics.draw(text, 20, 50)
	love.graphics.print("game initing...", 10, 10)



end




love.update = function(dt)

	x = love.mouse.getX()
	y = love.mouse.getY()

	for _, button in pairs(menu_main.buttons) do

		if button:isTouched(x, y) then
			button.color_text = color.yellow
		else
			button.color_text = color.black
		end
	end

	for _, button in pairs(menu_dialog.buttons) do

		if button:isTouched(x, y) then
			button.color_text = color.yellow
		else
			button.color_text = color.black
		end
	end


	if love.keyboard.isDown("down") then

		coord["dialog"].y = coord["dialog"].y + 1
		color_menu = color.black
	elseif love.keyboard.isDown("up") then

		coord["dialog"].y = coord["dialog"].y - 1
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

		for	_, button in pairs(menu_main.buttons) do

			if	button:isTouched(x, y) then

				button:work(dialogBox)
			end
		end


	elseif button == 2 then

		if dialogBox.showState == true then

			menu_main.buttons["hide"]:work(dialogBox)
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













