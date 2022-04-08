local widget = require "lua.scripts.widget"
local glue = require "lua.lua_modules.glue"

local normalButton = require "lua.scripts.ui.components.normalButton"
local labelButton = require "lua.scripts.ui.components.labelButton"
local largeButton = require "lua.scripts.ui.components.largeButton"
local colorDescription = require "lua.scripts.ui.components.colorDescription"

local containerPath =
    [[insurrection\ui\menus\settings_menu\color_edit\color_select_screen.ui_widget_definition]]
local headerPath = widget.get(containerPath, "child_widgets[0].widget_tag")
local optionsPath = widget.get(containerPath, "child_widgets[1].widget_tag")

-- Edit container
widget.edit(containerPath, {
    bounds = "0 0 480 856",
    background_bitmap = [[.bitmap]],
    -- Header, options, current profile
    child_widgets = {
        {vertical_offset = 20, horizontal_offset = 40},
        nil,
        {
            vertical_offset = 20,
            horizontal_offset = 624,
            widget_tag = [[insurrection\ui\shared\current_profile.ui_widget_definition]]
        }
    }
})

-- Edit header
if widget.count(headerPath, "child_widgets") < 2 then
    widget.insert(headerPath, "child_widgets", 2)
end
widget.edit(headerPath, {
    background_bitmap = ".bitmap",
    bounds = "0 0 40 450",
    child_widgets = {
        {
            widget_tag = [[insurrection\ui\menus\settings_menu\titles\header_title.ui_widget_definition]],
            vertical_offset = 0,
            horizontal_offset = 0
        },
        {
            widget_tag = [[insurrection\ui\menus\settings_menu\titles\header_subtitle.ui_widget_definition]],
            vertical_offset = 15,
            horizontal_offset = 0
        }
    }
})

-- Edit options list
local optionsCount = widget.count(optionsPath, "child_widgets")
local options = {bounds = "0 0 480 856", child_widgets = {}}
options.child_widgets[optionsCount] = {horizontal_offset = 0, vertical_offset = 414}
-- widget.edit(optionsPath, options)

-- Edit options, stop before button bar
-- for buttonIndex = 0, optionsCount - 2 do
--    local buttonPath = widget.get(optionsPath, ("child_widgets[%s].widget_tag"):format(buttonIndex))
--    local buttonInstance = glue.deepcopy(largeButton("left_justify"))
--    buttonInstance.child_widgets = {nil, {horizontal_offset = 150}}
--    widget.edit(buttonPath, buttonInstance)
--
--    local labelPath = widget.get(buttonPath, "child_widgets[0].widget_tag")
--    widget.edit(labelPath, labelButton("left_justify"))
--
--    local valuePath = widget.get(buttonPath, "child_widgets[1].widget_tag")
--    widget.edit(valuePath, labelButton("center_justify", 0))
-- end

-- Edit buttons bar
local buttonBarPath = widget.get(optionsPath,
                                 ("child_widgets[%s].widget_tag"):format(optionsCount - 1))
widget.edit(buttonBarPath, {
    bounds = "0 0 24 856",
    child_widgets = {{horizontal_offset = 444}, {horizontal_offset = 630}}
})

for buttonIndex = 0, 1 do
    local buttonPath = widget.get(buttonBarPath,
                                  ("child_widgets[%s].widget_tag"):format(buttonIndex))
    widget.edit(buttonPath, normalButton())
end

-- Edit description
local descriptionPath = widget.get(optionsPath, "extended_description_widget")
widget.edit(descriptionPath, colorDescription())
