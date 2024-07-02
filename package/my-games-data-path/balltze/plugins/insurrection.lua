local components = require "insurrection.components"
local balltze = Balltze
local engine = Engine
local luna = require "luna"
local chimera = require "insurrection.mods.chimera"
local interface = require "insurrection.interface"

---@type Logger
logger = nil
DebugMode = false
IsDebugCustomization = false
inspect = require "inspect"
constants = require "insurrection.constants"
api = require "insurrection.api"
discord = require "insurrection.discord"
store = require "insurrection.redux.store"

---@type uiWidgetDefinition?
local editableWidget
---@type tag?
local editableWidgetTagEntry
---@type tag
local lastOpenWidgetTag
---@type tag
local lastClosedWidgetTag
---@type tag
local lastListFocusedWidgetTag
---@type tag?
local lastFocusedWidgetTagEntry
-- Multithread lanes
Lanes = {}
-- Stores values that are masked in the UI
VirtualInputValue = {}

local customBipedPaths = {
    bleed_it_out = {[[keymind\the_flood\characters\unsc\gridharvolur\gridharvolur_mk_ii_[b]_mp]]},
    b30_coop_evolved = {
        [[[shm]\halo_1\characters\mjolnir_gen_1\mjolnir_gen_1_mp]],
        [[[shm]\halo_1\characters\marine\marine_mp]],
        [[[shm]\halo_1\characters\elite\elite_mp]],
        [[[shm]\halo_1\characters\grunt\grunt_mp]]
    }
    -- forge_island_dev = {[[[shm]\halo_4\characters\mjolnir_gen2\mjolnir_gen2_mp]]}
}

---@type BalltzeMapLoadEventCallback
local function onMapLoad(event)
    -- logger:info("map loaded: {}", event.args.mapName) 
    if event.args.mapName == "levels\\ui\\ui" then
        for mapName, bipeds in pairs(customBipedPaths) do
            for _, bipedPath in pairs(bipeds) do
                local _ = pcall(balltze.features.importTagFromMap, mapName, bipedPath, "biped")
            end
        end
    else
        balltze.features.clearTagImports()
    end
end

function PluginMetadata()
    return {
        name = "Insurrection",
        author = "Shadowmods Team",
        version = "2.6.0",
        targetApi = "1.0.0-rc.1",
        reloadable = true
    }
end

local commands = {
    debug = {
        description = "Enable Insurrection debug mode",
        help = "<boolean>",
        execute = function(enable)
            DebugMode = luna.bool(enable)
        end
    },
    setup_fonts = {
        description = "Setup Insurrection fonts as default game fonts",
        help = "<boolean>",
        minArgs = 1,
        maxArgs = 1,
        execute = function(enable)
            local revert = not luna.bool(enable)
            chimera.setupFonts(revert)
            if not revert then
                interface.dialog("SUCCESS", "Fonts have been setup",
                                 "Please restart the game to see changes.")
                return
            end
            interface.dialog("SUCCESS", "Fonts have been reverted",
                             "Please restart the game to see changes.")
        end
    },
    debug_customization = {
        description = "Enable Insurrection customization debug mode",
        execute = function()
            IsDebugCustomization = true
            interface.blur(false)
            --interface.close(true)
            execute_script("set_customization_background 1")
            execute_script("object_create customization_biped")
        end
    },
    test = {
        description = "Test command",
        execute = function()
            interface.dialog("SUCCESS", "Test command", "This is a test command")
        end
    }
}

function PluginInit()
    balltze.event.mapLoad.subscribe(onMapLoad, "lowest")
    balltze.event.tick.subscribe(function(event)
        -- Multithread callback resolve
        for laneIndex, lane in ipairs(Lanes) do
            if lane.thread.status == "done" then
                --harmony.menu.block_input(false)
                table.remove(Lanes, laneIndex)
                lane.callback(lane.thread)
                logger:debug("Async task finished!")
            elseif lane.thread.status == "error" then
                --harmony.menu.block_input(false)
                logger:error(lane.thread[1])
                table.remove(Lanes, laneIndex)
            else
                logger:warning(lane.thread.status)
            end
        end
    end)
    logger = balltze.logger.createLogger("insurrection")
    for command, data in pairs(commands) do
        balltze.command.registerCommand(command, command, data.description, data.help, false,
                                        data.minArgs or 0, data.maxArgs or 0, false, true,
                                        function(...)
            local success, result = pcall(data.execute, ...)
            if not success then
                logger:error("Error executing command '{}': {}", command, result)
                return false
            end
            return true
        end)
    end
    return true
end

function execute_script(script)
    logger:debug("Should execute script: {}", script)
    engine.hsc.executeScript(script)
end

function PluginLoad()
    for k, v in pairs(balltze.chimera) do
        _G[k] = v
    end
    logger:debug("Loading Insurrection plugin")
    constants.get()
    components.callbacks()
    interface.changeAspectRatio()
    interface.load()
    api.loadUrl()
end
