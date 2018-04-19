
---window configurations---

conf_window = {

	width		= 1280,
	height		= 720,
	minWidth	= 300,
	minHeigth	= 200,

	bgColor		= {255, 255, 255}

}

function love.conf(t)


	t.title = "Kris~"
	t.window.width = 1280
	t.window.height = 720

end





str_imgBGPath = "0.png"
str_imgDialog = "dialog.jpg"
str_imgSetting = "menu.png"
i_imgDialogSize = {width = 990, height = 184}


---Useful Colors---

color = {}
color.trans		= {0,		0,		0,		0}
color.keep		= {255,		174,	201}
color.black		= {0,		0,		0}
color.white		= {255,		255,	255}
color.red		= {255,		0,		0}
color.green		= {0,		255,	0}
color.blue		= {0,		0,		255}
color.yellow	= {255,		255,	0}



---global coordinate settings---

coord = {

	bgI			= {x = 0, y = 0},
	dialog		= {x = 150, y = conf_window.height - 190},

}


---global pane system control---

selectPane = {

	["surface"] = {surface = true, setting = false, dialog = false},
	["setting"] = {surface = false, setting = true, dialog = false},
	["dialog"] = {surface = false, setting = false, dialog = true},

}






