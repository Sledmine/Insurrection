local widget = require "lua.scripts.widget"
local container = require "lua.scripts.ui.componentsV2.container"
local header = require "lua.scripts.ui.componentsV2.header"
local options = require "lua.scripts.ui.componentsV2.options"
local button = require "lua.scripts.ui.componentsV2.button"
local constants = require "lua.scripts.ui.components.constants"
local checkbox = require "lua.scripts.ui.componentsV2.checkbox"
local spinner = require "lua.scripts.ui.componentsV3.spinner"
local footer = require "lua.scripts.ui.componentsV2.footer"
local pos = constants.position

widget.init [[insurrection/ui/menus/mods/chimera/]]

local layout = widget.align("vertical", 24, pos.options.x, pos.options.y, 2)
local spinnersLayout = widget.align("vertical", 24,
                                    pos.options.x + constants.components.button.normal.width + 8,
                                    pos.options.y, 2)

return container("chimera_mod_menu", {
    {
        header("chimera_mod", "CHIMERA", "CUSTOMIZE DIFFERENT CHIMERA SETTINGS"),
        pos.header.x,
        pos.header.y
    },
    {
        options("chimera_mod", "vertical", {
            {checkbox("vsync", "USE VSYNC"), layout()},
            {checkbox("fps", "SHOW FPS"), layout()},
            {checkbox("windowed", "WINDOWED MODE"), layout()},
            {checkbox("borderless", "BORDERLESS"), layout()},
            {checkbox("enable_map_memory_buffer", "LOAD MAPS ON RAM"), layout()},
            {checkbox("af", "ANISOTROPIC FILTER"), layout()},
            {checkbox("block_buffering", "BLOCK BUFFERING"), layout()},
            {checkbox("block_hold_f1", "BLOCK HOLD F1 AT START"), layout()},
            {checkbox("block_loading_screen", "BLOCK LOADING SCREEN"), layout()},
            {checkbox("block_zoom_blur", "BLOCK ZOOM BLUR"), layout()},
            -- {checkbox("block_mouse_acceleration", "BLOCK MOUSE ACCELERATION"), layout()},
            {checkbox("devmode", "DEVMODE"), layout()},
            {checkbox("show_budget", "SHOW BUDGET"), layout()},
            {spinner {name = "fov", text = "FOV", value = "000v"}, spinnersLayout()},
            --{spinner {name = "vertical_fov", text = "VERTICAL FOV", value = "000"}, spinnersLayout()},
            -- {spinner("mouse_sensitivity_x", "MOUSE SENSITIVITY X", sensitivities), spinnersLayout()},
            -- {spinner("mouse_sensitivity_y", "MOUSE SENSITIVITY Y", sensitivities), spinnersLayout()},
            -- {button("save_settings", "SAVE SETTINGS", {save = true}), pos.action.x, pos.action.y},
            {button("back", "BACK", {back = true}), pos.back.x, pos.back.y}
        })
    },
    {
        footer("chimera_mod_footer", "DESCRIPTION",
               "Choose which Chimera options you want to enable or disable.\r\nWARNING: Some options may require a game restart to apply changes."),
        layout(8)
    },
    {constants.components.currentProfile.path, 624, 20},
    {constants.components.version.path, 0, 460}
})
