local FontRenderer = {}
FontRenderer.__index = FontRenderer
FontRenderer.ClassName = "FontRenderer"

local function GetCharData(fontData, char)
	for _, charEntry in ipairs(fontData.Characters) do
		if charEntry.Char == char then
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
	local label = Instance.new("ImageLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(0, charData.ImageWidth, 0, charData.ImageHeight)
	label.ImageRectSize = Vector2.new(charData.ImageWidth, charData.ImageHeight)
	label.Image = self.FontData.Image
	label.ImageRectOffset = Vector2.new(charData.ImageX, charData.ImageY)
	
	return label
end

function FontRenderer:RenderString(str)
	local x = 0
	local container = Instance.new("Frame")
	container.BackgroundTransparency = 1
	
	for char in str:gmatch(".") do
		
		local charData = GetCharData(self.FontData, char)
		print(char, charData.Char)
		local label = self:RenderCharacter(char)
		label.Position = UDim2.new(0, x, 1, -charData.ImageHeight)
		label.Parent = container
		label.Name = char
		x = x + charData.AdvanceWidth
	end
	
	return container
end

return FontRenderer