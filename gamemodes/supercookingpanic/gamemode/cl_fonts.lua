--[[---------------------------------------------------------
		Super Cooking Panic for Garry's Mod
				by Xperidia (2020)
-----------------------------------------------------------]]

local fonts = {
	clock = {
		size = 60,
	},
	big_text = {
		size = 40,
		antialias = true,
		shadow = true,
	},
	text = {
		size = 24,
		antialias = true,
		shadow = true,
	},
	min = {
		size = 18,
		antialias = true,
	},
}

GM.CreatedFonts = GM.CreatedFonts or {}

local function scaled_font_name(name)
	return "scookp_" .. name .. "_" .. ScrH()
end

--[[----------------------------------------------------------------------------
	Name: GM:CreateScaledFont(fname, fsize, foptions)
	Desc: Create a scaled font from the given base name, size and option table.
------------------------------------------------------------------------------]]
function GM:CreateScaledFont(fname)

	local aname = scaled_font_name(fname)

	if self.CreatedFonts[aname] then
		self:DebugLog("The " .. aname .. " font is already created.")
		return aname
	end

	local font = fonts[fname]
	local fsize = font and font.size or 18

	local	sfont = {}
			sfont.font		= font and font.font or "Roboto"
			sfont.size		= self:ScreenScaleMin(fsize)

	for k, v in pairs(font) do
		sfont[k] = v
	end

	surface.CreateFont(aname, sfont)

	self.CreatedFonts[aname] = true

	self:DebugLog("Created scaled font " .. aname .. " from " .. fsize)

	return aname

end

--[[----------------------------------------------------------------------------
	Name: GM:GetScaledFont(fname)
	Desc:	Attempt to get a scaled font name from base font name.
			If the scaled font doesn't exist it will create it.
			If the base font is not registered in the fonts table, it will
			return fname.
------------------------------------------------------------------------------]]
function GM:GetScaledFont(fname)

	if self.CreatedFonts[scaled_font_name(fname)] then

		return scaled_font_name(fname)

	elseif not self.CreatedFonts[scaled_font_name(fname)] and fonts[fname] then

		return self:CreateScaledFont(fname, fonts[fname][1], fonts[fname][2])

	end

	return fname

end

--[[----------------------------------------------------------------------------
	Name: GM:CreateScaledFonts()
	Desc:	Will generate scaled fonts from the fonts table.
------------------------------------------------------------------------------]]
function GM:CreateScaledFonts()

	self:Log("Generating scaled fonts...")

	for k, v in pairs(fonts) do

		self:CreateScaledFont(k, v[1], v[2])

	end

	self:Log("Scaled fonts created.")

end

function GM:OnScreenSizeChanged(oldWidth, oldHeight)

	self:CreateScaledFonts()

end