# ROBLOX Font Renderer
This is a simple (ish) font renderer for ROBLOX that I made in response to the tragic lack of font support.

# Usage
To require the font renderer, insert it into your game and require it.  Due to the fact that it will likely be used on the client you *cannot* require it using its asset ID.

```lua
local FontRenderer = require(game:GetService("ReplicatedStorage"):WaitForChild("FontRenderer"))
```

Next you need to load a font module, which is a module that contains data about a specific font in a specific size.  After that you want to create a font renderer instance using that font module.

```lua
local Roboto12 = require(game:GetService("ReplicatedStorage"):WaitForChild("Roboto12"))
local Roboto12Renderer = FontRenderer.new(Roboto12)
```

Now that you've got that, you can start to use the font renderer to create strings.

```lua
local textview = Roboto12Renderer:RenderString("Hello, world!")
```

`textview` is a Frame object that contains a series of ImageLabels.  Parent this somewhere and position it wherever you want it!

# FontRenderer class
## FontRenderer.new(table fontModule)
Creates a new FontRenderer instance, using `fontModule` as its font.

## FontRenderer::RenderString(string str)
Returns a [Frame](http://wiki.roblox.com/index.php?title=API:Class/Frame) instance that contains a series of [ImageLabels](http://wiki.roblox.com/index.php?title=API:Class/ImageLabel), each of which displays a single character in the FontRenderer's font.

## FontRenderer::RenderCharacter(string char)
Returns an ImageLabel that displays `char` in the FontRenderer's font.