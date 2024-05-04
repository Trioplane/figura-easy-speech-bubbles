# Easy Speech Bubbles
- Lets you add easy to use, and configurable speech bubble to your avatar!
- Just chat things and it will appear!

# This doesn't work on multiplayer and is basically useless, working on fixing it

## Usage:
- Setting up the speech bubble:
```lua
local SpeechBubble = require("speechBubble.lua") -- or whatever file path you chose

SpeechBubble.sender = "YOUR_NAME" 
-- or use player:getName() in events.entity_init
-- make sure to put SpeechBubble:run() inside events.entity_init too if you do this.

SpeechBubble.pivot = models.YourModelPart -- Sets where the speech bubble will appear
SpeechBubble.style = { -- What the text will look like
  color = "valid hex code or vanilla color",
  bold = false, -- All of these are self-explanatory
  italic = false,
  underlined = false,
  strikethrough = false,
  obfuscated = false -- why would you make this true
}
SpeechBubble.textWidth = 100 -- Sets the width of the speech bubble, making it wrap
SpeechBubble.textAlign = "CENTER" -- "CENTER" | "LEFT" | "RIGHT"
SpeechBubble.textScale = 0.5 -- The size of the text, note: this is the best scale for word wrap, will fix this tomorrow
SpeechBubble.clearWaitTime = 100 -- When the speech bubble will clear when it is done displaying the text, This is dependent on SpeechBubble.textCharacterDisplayTime
SpeechBubble.textCharacterDisplayTime = 1 -- How fast each character will display on the text bubble, in ticks

SpeechBubble:run() -- Will run the speech bubble making it work!
```
- Speech Bubble events
```lua
local SpeechBubble = require("speechBubble.lua") -- or whatever file path you chose

-- Runs when the speech bubble is displaying text
function SpeechBubble.displaying() 
  -- code
end

-- Runs when a character gets added to the speech bubble
-- Parameter character is the character that got added.
function SpeechBubble.characterAdded(character) 
  -- code
end
```

### Credits:
- trplnr - Main Developer
### Additional Help:
- manuel_2867 - Config Help, letting me know that chat_send_message doesn't work
- grandpa_scout - Minor error help
- pencilvoid - Letting me know about TextTasks