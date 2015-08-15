local FontRenderer = {}
FontRenderer.__index = FontRenderer
FontRenderer.ClassName = "FontRenderer"

local function GetCharData(fontData, char)
	for _, charEntry in ipairs(fontData.chars) do
		if charEntry.char == char then
			return charEntry
		end
	end
end

function FontRenderer.new(fontData)
	local self = setmetatable({}, FontRenderer)
	self.FontData = fontData
	
	return self
end

function FontRenderer:RenderCharacter(char)
	assert(char:len() == 1, "FontRenderer::RenderCharacter cannot render strings, use FontRenderer::RenderString!")
	
	local charData = GetCharData(self.FontData, char)
	assert(charData, "no char data for "..char.." in font")
	for i,v in pairs(charData) do print(i,v) end
	local label = Instance.new("ImageLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(0, charData.w, 0, self.FontData.texture.height)
	label.ImageRectSize = Vector2.new(charData.w, self.FontData.texture.height)
	label.Image = self.FontData.file
	label.ImageRectOffset = Vector2.new(charData.x, 0)
	
	return label
end

function FontRenderer:RenderString(str)
	local x = 0
	local container = Instance.new("Frame")
	container.BackgroundTransparency = 1
	
	for char in str:gmatch(".") do
		local charData = GetCharData(self.FontData, char)
		local label = self:RenderCharacter(char)
		label.Position = UDim2.new(0, x + math.floor(charData.ox / 2 + 0.5), 0, 0)
		label.Parent = container
		label.Name = char
		x = x + charData.width
	end
	
	return container
end

return FontRenderer