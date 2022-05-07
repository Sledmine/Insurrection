local harmony = require "mods.harmony"
local bezierCurve = harmony.math.get_bezier_curve_point

local openWidget = harmony.menu.open_widget
local reloadWidget = harmony.menu.reload_widget
local findWidgets = harmony.menu.find_widgets
local blam = require "blam"
local findTag = blam.findTag
local actions = require "insurrection.redux.actions"
local core = require "insurrection.core"
local getWidgetString = core.getStringFromWidget
local setWidgetString = core.setStringToWidget
local glue = require "glue"
local split = glue.string.split
local ends = glue.string.ends
local append = glue.append
local unicodeStringTag = blam.unicodeStringList
local uiWidgetTag = blam.uiWidgetDefinition

local function findWidgetTag(partialName)
    return findTag(partialName, blam.tagClasses.uiWidgetDefinition)
end

local interface = {}
local dialogWidgetTag = findWidgetTag("dialog_menu")
local lobbyWidgetTag = findWidgetTag("lobby_menu")

function interface.dialog(titleText, subtitleText, bodyText)
    local dialog = uiWidgetTag(dialogWidgetTag.id)
    local header = uiWidgetTag(dialog.childWidgets[1].widgetTag)
    local title = uiWidgetTag(header.childWidgets[1].widgetTag)
    local headerStrings = blam.unicodeStringList(title.unicodeStringListTag)
    local strings = headerStrings.stringList
    strings[1] = titleText
    strings[2] = subtitleText
    headerStrings.stringList = strings
    local body = uiWidgetTag(dialog.childWidgets[3].widgetTag)
    local bodyStrings = unicodeStringTag(body.unicodeStringListTag)
    local strings = bodyStrings.stringList
    strings[1] = bodyText
    bodyStrings.stringList = strings

    openWidget(dialogWidgetTag.id, true)
end

function interface.lobby(force)
    openWidget(lobbyWidgetTag.id, true)
end

local lobbyDefinitions = {
    template = "lobby_definition_button_1",
    map = "lobby_definition_button_2",
    gametype = "lobby_definition_button_3"
}

--- Map selected button from the UI
---@param widgetTagId number
function interface.onButton(widgetTagId)
    local buttonPath = blam.getTag(widgetTagId).path
    if ends(buttonPath, "login_button") then
        local username = getWidgetString(findWidgetTag("username_input").id)
        local password = getWidgetString(findWidgetTag("password_input").id)
        api.login(username, password)
    elseif ends(buttonPath, "register_button") then
        interface.dialog("INFORMATION", "UNDER CONSTRUCTION", "Coming soon...")
    elseif ends(buttonPath, "create_lobby_button") then
        api.lobby()
    elseif ends(buttonPath, "lobby_key_input") then
        api.lobby(getWidgetString(findWidgetTag("lobby_key_input").id))
    elseif ends(buttonPath, "lobby_definition_button_1") then
        store:dispatch(actions.setLobbyDefinition("template"))
    elseif ends(buttonPath, "lobby_definition_button_2") then
        store:dispatch(actions.setLobbyDefinition("map"))
    elseif ends(buttonPath, "lobby_definition_button_3") then
        store:dispatch(actions.setLobbyDefinition("gametype"))
    elseif ends(buttonPath, "lobby_definition_button_4") then
        local template = getWidgetString(findWidgetTag("lobby_definition_button_1").id)
        local map = getWidgetString(findWidgetTag("lobby_definition_button_2").id)
        local gametype = getWidgetString(findWidgetTag("lobby_definition_button_3").id)
        api.borrow(template:lower(), map:lower(), gametype:lower())
    elseif string.find(buttonPath, "lobby_element_button_") then
        local buttonIndex = tonumber(split(core.getTagName(buttonPath), "_")[4])
        if buttonIndex == 1 then
            store:dispatch(actions.scroll(true))
            return
        elseif buttonIndex == 6 then
            store:dispatch(actions.scroll())
            return
        end
        local value = getWidgetString(findWidgetTag("lobby_element_button_" .. buttonIndex).id)
        store:dispatch(actions.setSelected(value))
    end
end

function interface.update()
    ---@type interfaceState
    local state = store:getState()
    local widget = uiWidgetTag(lobbyWidgetTag.id)
    local optionsWidget = uiWidgetTag(widget.childWidgets[2].widgetTag)
    local definitionsWidget = uiWidgetTag(optionsWidget.childWidgets[1].widgetTag)
    local elementsWidget = uiWidgetTag(optionsWidget.childWidgets[2].widgetTag)

    -- TODO Fix this, we need the current profile name, player does not exist yet
    -- Update players in lobby
    local currentPlayerName = blam.player(get_player()).name:lower()
    for playerIndex, playerName in pairs(state.lobby.members) do
        if playerName ~= currentPlayerName then
            setWidgetString(playerName, widget.childWidgets[playerIndex + 2].widgetTag)
        end
    end

    setWidgetString(state.selected.template:upper(), definitionsWidget.childWidgets[1].widgetTag)
    setWidgetString(state.selected.map:upper(), definitionsWidget.childWidgets[2].widgetTag)
    setWidgetString(state.selected.gametype:upper(), definitionsWidget.childWidgets[3].widgetTag)

    -- Restore normal list widget state
    local newChilds = elementsWidget.childWidgets
    newChilds[2].widgetTag = findWidgetTag("lobby_element_button_2").id
    newChilds[3].widgetTag = findWidgetTag("lobby_element_button_3").id
    newChilds[4].widgetTag = findWidgetTag("lobby_element_button_4").id
    newChilds[5].widgetTag = findWidgetTag("lobby_element_button_5").id
    elementsWidget.childWidgets = newChilds
    
    -- Apply modifications based on lua state
    local elements = state.displayed
    for childIndex = 2, 5 do
        childWidget = elementsWidget.childWidgets[childIndex]
        local elementIndex = childIndex - 1
        if elements[elementIndex] then
            setWidgetString(elements[elementIndex]:upper(), childWidget.widgetTag)
        else
            newChilds[childIndex].widgetTag = 0xFFFFFFFF
        end
    end
    elementsWidget.childWidgets = newChilds

    -- Reload dynamically changed widgets from tags, effectively redrawing the UI
    local foundWidgets = findWidgets(optionsWidget.childWidgets[2].widgetTag, true)
    local widgetInstanceIndex = foundWidgets[1]
    if widgetInstanceIndex then
        reloadWidget(widgetInstanceIndex)
    end
end

function interface.setWidgetValues(widgetTagId, values)
    local widgetInstanceId = harmony.menu.find_widgets(widgetTagId)
    if (widgetInstanceId) then
        harmony.menu.set_widget_values(widgetInstanceId, values);
    end
end

function interface.animation(targetWidgetTagId,
                             widgetContainerTagId,
                             duration,
                             property,
                             originalOffset,
                             offset)
    local animationId = targetWidgetTagId .. widgetContainerTagId .. property
    WidgetAnimations[animationId] = {
        finished = false,
        widgetContainerTagId = widgetContainerTagId,
        animate = function()
            local originalOffset = originalOffset
            if not WidgetAnimations[animationId].elapsed then
                harmony.time.set_timestamp(animationId)
            end
            local elapsed = harmony.time.get_elapsed_milliseconds(animationId) / 1000
            WidgetAnimations[animationId].elapsed = elapsed
            -- console_out(elapsed)
            -- console_out(duration)
            if elapsed >= (duration) then

                if property == "horizontal" then
                    interface.setWidgetValues(targetWidgetTagId, {left_bound = offset})
                elseif property == "vertical" then
                    interface.setWidgetValues(targetWidgetTagId, {top_bound = offset})
                else
                    interface.setWidgetValues(targetWidgetTagId, {opacity = offset})
                end

                WidgetAnimations[animationId].elapsed = nil
                WidgetAnimations[animationId].finished = true
                return
            end

            local widgetTag = blam.uiWidgetDefinition(widgetContainerTagId)
            if not originalOffset then
                for _, childWidget in pairs(widgetTag.childWidgets) do
                    if childWidget.widgetTag == targetWidgetTagId then
                        if property == "horizontal" then
                            originalOffset = childWidget.horizontalOffset
                        elseif property == "vertical" then
                            originalOffset = childWidget.verticalOffset
                        end
                    end
                end
            end
            local t = (elapsed / duration)
            local newPosition = bezierCurve("buttons", originalOffset, offset, t)
            -- local newOpacity = bezierCurve("opacity", 0, 1, t)

            if property == "horizontal" then
                interface.setWidgetValues(targetWidgetTagId, {left_bound = math.floor(newPosition)})
            elseif property == "vertical" then
                interface.setWidgetValues(targetWidgetTagId, {top_bound = math.floor(newPosition)})
            else
                interface.setWidgetValues(targetWidgetTagId, {opacity = newPosition})
            end

        end
    }
end

function interface.dashboard()
    openWidget(findWidgetTag("dashboard_menu").id, true)
end

return interface
