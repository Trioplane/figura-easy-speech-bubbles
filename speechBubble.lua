-- SpeechBubble.lua by Trplnr
-- Adds an easy to use and configurable speech bubble to your avatar!
-- Credits:
-- trplnr - Main Developer
--
-- Additional Help:
-- manuel_2867 - Config Help, letting me know that chat_send_message doesn't work
-- grandpa_scout - Minor error help
-- pencilvoid - Letting me know about TextTasks

local chatMessage = ""
local speechBubbleMessage = ""
local rawMessage = ""
local stringIndex = 1
local isDoneDisplaying = true
local newMessage = false
local speechBubbleClearWaitCount = 0
local tick = 0
SpeechBubble = {}
SpeechBubble.clearWaitTime = 100
SpeechBubble.textCharacterDisplayTime = 1
SpeechBubble.textWidth = 100
SpeechBubble.textAlign = "CENTER"
SpeechBubble.textScale = 0.5
SpeechBubble.style = {
    color = "white",
    bold = false,
    italic = false,
    underlined = false,
    strikethrough = false,
    obfuscated = false,
}
SpeechBubble.pivot = nil

local speechBubble

--- Runs when the speech bubble is displaying
function SpeechBubble.displaying() end

--- Runs when a character gets added to the speech bubble
--- @param character string
function SpeechBubble.characterAdded(character) end

--- Runs once when the speech bubble started displaying
function SpeechBubble.started_display() end

--- Runs once when the speech bubble ended displaying
function SpeechBubble.ended_display() end

function pings.SpeechBubble_updateMessage(message)
    if not player:isLoaded() then return end
    isDoneDisplaying = false
    rawMessage = ""
    chatMessage = message
    stringIndex = 1
    newMessage = true
    SpeechBubble.started_display()
end

function events.chat_send_message(message)
    pings.SpeechBubble_updateMessage(message)
    return message
end

local function get_text_position(text_message, text_width, text_scale)
    local textDimension = client.getTextDimensions(toJson(text_message), text_width, true)

    local center_y = textDimension.y / 2
    local adjustment = (text_scale - 0.5) * textDimension.y
    local final_y = center_y + adjustment

    return final_y
end

function pings.SpeechBubble_updateSpeechBubble()
    if tick % SpeechBubble.textCharacterDisplayTime == 0 then
        tick = 0
        if not isDoneDisplaying then
            rawMessage = rawMessage .. chatMessage:sub(stringIndex, stringIndex)
            speechBubbleMessage = {
                "",
                {
                    color = SpeechBubble.style.color,
                    bold = SpeechBubble.style.bold,
                    italic = SpeechBubble.style.italic,
                    underlined = SpeechBubble.style.underline,
                    strikethrough = SpeechBubble.style.strikethrough,
                    obfuscated = SpeechBubble.style.obfuscated,
                    text = rawMessage,
                },
            }
            SpeechBubble.characterAdded(chatMessage:sub(stringIndex, stringIndex))
            stringIndex = stringIndex + 1
            if stringIndex > #chatMessage then
                isDoneDisplaying = true
            end
        end
        if isDoneDisplaying then
            speechBubbleClearWaitCount = speechBubbleClearWaitCount + 1
            if speechBubbleClearWaitCount == SpeechBubble.clearWaitTime then
                speechBubbleMessage = ""
                speechBubbleClearWaitCount = 0
                newMessage = false
                SpeechBubble.ended_display()
            end
        end
    end
    SpeechBubble.displaying()
    speechBubble:setPos(0,
        get_text_position(speechBubbleMessage, SpeechBubble.textWidth, SpeechBubble.textScale), 0)
    speechBubble:setText(toJson(speechBubbleMessage))
end

function SpeechBubble:run()
    speechBubble = SpeechBubble.pivot:newText("SpeechBubble")
        :setAlignment(SpeechBubble.textAlign)
        :setScale(SpeechBubble.textScale)
        :setWidth(SpeechBubble.textWidth)

    function events.tick()
        tick = tick + 1
        if not newMessage then return end
        pings.SpeechBubble_updateSpeechBubble()
    end
end

return SpeechBubble
