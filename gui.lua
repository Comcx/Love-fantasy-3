

require "conf"




---=====class Button====---
Button = function(size, text, func, mode)

	local this = {}
	this.size = size
	this.name = text
	this.text = love.graphics.newText(love.graphics.newFont(size[3]), text or "")
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
Menu = function(buttons)


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


---=====class DialogBox=====---
DialogBox = function(img_dialog)

	local this = {}

	this.x = -1
	this.y = -1

	this.menu = menu
	this.image = img_dialog
	this.showState = true

	this.show = function(self, x, y, p_color)

		self.x = x
		self.y = y

		drawImage(self.image, self.x, self.y, p_color)
	end

	this.print = function(self, text, p_color)

		p_color = p_color or color.black

		love.graphics.setColor(p_color)
		love.graphics.draw(text, self.x + 50, self.y + 50 )
		--self.printPosition[1] = self.printPosition[1] + text:getWidth()

	end

	return this
end


---=====class BGIBox(background image box)=====---
BGIBox = function(str_imagePath, conf_window)

	local this = {}
	this.image = love.graphics.newImage(str_imagePath)
	this.str_image = str_imagePath
	this.conf_window = conf_window

	this.setImage = function(self, str_image_newPath)
		self.image = love.graphics.newImage(str_image_newPath)
		self.str_image = str_image_newPath
	end

	this.show = function(self)

		drawBGImage(self.image, self.conf_window, 0, 0)
	end

	return this
end




