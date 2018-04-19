
-----========================2D game using LOVE engine=========================-----


require "window"
require "image"
require "conf"
require "gui"
lain = require "lainlib"


paneSelect = selectPane["dialog"]
----====================global components===================----


local buttons_main = {

	["back"] = Button({30, 15, 15}, "back", function(self, BGIBox)
		--BGIBox:setImage("menu.png")
		paneSelect = selectPane["setting"]
	end),
	["hide"] = Button({30, 15, 15}, "hide", function(self, dialog)

		dialog.showState = false
		dialog.y = dialog.y + 1000
		coord["dialog"].y = coord["dialog"].y + 1000
	end),
	["exit"] = Button({30, 15, 15}, "exit", function(self) love.event.quit(0) end),
	["full"] = Button({70, 15, 15}, "full screen",
					function(self) love.window.showMessageBox("Sorry","This function is under construction") end),
}

local buttons_dialog = {

	["next"] = Button({30, 15, 15}, "next", function(self, BGIBox)

		BGIBox:setImage(tostring(lain.strip(BGIBox.str_image) + 1) .. ".png")
	end),
	["auto"] = Button({30, 15, 15}, "auto"),

}



local buttons_menu = {

	["continue"] = Button({140, 30, 30}, "Continue", function(self) paneSelect = selectPane["dialog"] end),
	["settings"] = Button({140, 30, 30}, "Settings"),
	["save"] = Button({70, 30, 30}, "Save"),
	["load"] = Button({70, 30, 30}, "load"),
	["exit"] = Button({70, 30, 30}, "Exit", function(self) love.event.quit(0) end),

}








----================Main game callback functions for engine==================----



love.load = function()

	loadWindow(conf_window)

	font		= love.graphics.newFont(20)
	text		= love.graphics.newText(font, "Playing music AyaRuKa.mp3")
	music		= love.audio.newSource("AyaRuKa.mp3", "stream")


	img_dialog	= love.graphics.newImage(str_imgDialog)
	----=================Dialog Pane=================----
	pane_dialog = {

		---main menu---
		menu_main = Menu(buttons_main),

		---small menu on dialog box---
		menu_dialog = Menu(buttons_dialog),

		---background image box---
		BGImageBox = BGIBox(str_imgBGPath, conf_window),

		---dialog box---
		dialogBox = DialogBox(img_dialog),

		show = function(self)

			--background image--
			self.BGImageBox:show()

			--dialog box--
			self.dialogBox:show(coord["dialog"].x, coord["dialog"].y)
			self.menu_main:show(500, coord["dialog"].y + 150, {50, 0}, {"back", "hide", "exit", "full"})
			self.menu_dialog:show(1000, coord["dialog"].y + 150, {50, 0}, {"next", "auto"})
		end,

	}


	----======================Surface Pane=====================----
	pane_surface = {

		---background image box---
		BGImageBox = BGIBox(str_imgBGPath, conf_window),


	}

	----======================settings Pane=====================----
	pane_menu = {

		menu_menu = Menu(buttons_menu),

		BGImageBox = BGIBox(str_imgSetting, conf_window),

		show = function(self)

			--background image--
			self.BGImageBox:show()

			self.menu_menu:show(100, 300, {0, 60}, {"continue", "settings", "save", "load", "exit"})

		end,

	}



	music:setVolume(0.03)
	music:play()


end


love.draw = function()

	if	paneSelect["surface"] then



	elseif	paneSelect["setting"] then

		pane_menu:show()

	elseif	paneSelect["dialog"] then

		pane_dialog:show()

		test_dailog = love.graphics.newText(love.graphics.newFont(20), "What are you doing?!")
		pane_dialog.dialogBox:print(test_dailog)

	end


	love.graphics.setColor(color.black)
	love.graphics.draw(text, 20, 50)
	love.graphics.print("game initing...", 10, 10)



end




love.update = function(dt)

	x = love.mouse.getX()
	y = love.mouse.getY()

	for _, button in pairs(pane_dialog.menu_main.buttons) do

		if button:isTouched(x, y) then
			button.color_text = color.yellow
		else
			button.color_text = color.black
		end
	end

	for _, button in pairs(pane_dialog.menu_dialog.buttons) do

		if button:isTouched(x, y) then
			button.color_text = color.yellow
		else
			button.color_text = color.black
		end
	end

	for _, button in pairs(pane_menu.menu_menu.buttons) do

		if button:isTouched(x, y) then
			button.color_text = color.yellow
		else
			button.color_text = color.black
		end
	end


	if love.keyboard.isDown("down") then

		coord["dialog"].y = coord["dialog"].y + 2
		color_menu = color.black
	elseif love.keyboard.isDown("up") then

		coord["dialog"].y = coord["dialog"].y - 2
		color_menu = color.green
	end


end


love.keypressed = function(key)


end


love.mousepressed = function(x, y, button, istouch)

	if button == 1 then

		---buttons in main menu---
		if	pane_dialog.menu_main.buttons["hide"]:isTouched(x, y) then

			pane_dialog.menu_main.buttons["hide"]:work(pane_dialog.dialogBox)

		elseif	pane_dialog.menu_main.buttons["exit"]:isTouched(x, y) then

			pane_dialog.menu_main.buttons["exit"]:work()

		elseif	pane_dialog.menu_main.buttons["back"]:isTouched(x, y) then

			pane_dialog.menu_main.buttons["back"]:work(pane_dialog.BGImageBox)

		end


		---buttons in dialog menu---
		if	pane_dialog.menu_dialog.buttons["next"]:isTouched(x, y) then

			pane_dialog.menu_dialog.buttons["next"]:work(pane_dialog.BGImageBox)
		end

		---buttons in setting menu---
		if	pane_menu.menu_menu.buttons["exit"]:isTouched(x, y) then

			pane_menu.menu_menu.buttons["exit"]:work()

		elseif	pane_menu.menu_menu.buttons["continue"]:isTouched(x, y) then

			pane_menu.menu_menu.buttons["continue"]:work()
		end



	elseif button == 2 then

		if pane_dialog.dialogBox.showState == true then

			pane_dialog.menu_main.buttons["hide"]:work(pane_dialog.dialogBox)
		else
			pane_dialog.dialogBox.y = pane_dialog.dialogBox.y - 1000
			coord["dialog"].y = coord["dialog"].y - 1000
			pane_dialog.dialogBox.showState = true
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













