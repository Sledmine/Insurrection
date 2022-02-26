--- Widget automated modifier using Invader
--- Sledmine
local glue = require "glue"

local widget = {}

---@class widgetFlags
---@field pass_unhandled_events_to_focused_child boolean
---@field pause_game_time boolean
---@field flash_background_bitmap boolean
---@field dpad_up_down_tabs_thru_children boolean

---@class childWidget
---@field widget_tag string
---@field name string
---@field vertical_offset number
---@field horizontal_offset number

---@class invaderWidget
---@field widget_type '"container"' | '"text_box"' | '"spinner_list"' | '"column_list"'
---@field bounds string
---@field flags widgetFlags
---@field milliseconds_to_auto_close number
---@field milliseconds_to_auto_close_fade_time number
---@field background_bitmap string
---@field extended_description_widget string
---@field justification '"left_justify"' | '"center_justify"' | '"right_justify"'
---@field text_label_unicode_strings_list string
---@field text_font string
---@field string_list_index number
---@field horiz_offset number
---@field vert_offset number
---@field child_widgets childWidget[]

local gamePath = os.getenv("HALO_CE_PATH")
local invaderRunner =
    ([[sudo docker run -it -v /storage/developing/halo-ce/insurrection/data:/invader/data -v /storage/developing/halo-ce/insurrection/tags:/invader/tags -v "%s/maps":/invader/maps invader-docker ]]):format(
        gamePath)
if (jit.os == "Windows") then
    invaderRunner = ""
end
local editCmd = invaderRunner .. [[invader-edit "%s"]]
local countCmd = invaderRunner .. [[invader-edit "%s" -C %s]]
local getCmd = invaderRunner .. [[invader-edit "%s" -G %s]]
local insertCmd = invaderRunner .. [[invader-edit "%s" -I %s %s %s]]
local createCmd = invaderRunner .. [[invader-edit "%s" -N]]

--- Build properties assignment type to invader string parameter
local function writeMapFields(key, value)
    local valueType = type(value)
    if (valueType ~= "table") then
        -- print(field .. " = " .. tostring(value))
    end
    -- Text property
    if (valueType == "string") then
        return (" -S %s \"%s\""):format(key, tostring(value))
        -- Boolean property
    elseif (valueType == "boolean") then
        if (value) then
            return (" -S %s %s"):format(key, 1)
        end
        return (" -S %s %s"):format(key, 0)
        -- Number property
    elseif (valueType == "number") then
        return (" -S %s %s"):format(key, tostring(value))
        -- Table
    elseif (valueType == "table") then
        local sentence = ""
        for subField, subValue in pairs(value) do
            if (tonumber(subField)) then
                sentence = sentence ..
                               writeMapFields((key .. "[%s]"):format(subField - 1), subValue)
            else
                sentence = sentence .. writeMapFields(key .. "." .. subField, subValue)
            end
        end
        return sentence
    else
        print(key)
        error("Unknown property type!")
    end
end

local function createKeys(keys, value)
    local valueType = type(value)
    if (valueType ~= "table") then
        -- print("Writting " .. keys .. " = " .. tostring(value))
    end
    -- Text property
    if (valueType == "string") then
        -- FIXME Split button index asignation via keyword without string formatting
        return (" -S %s \"%s\""):format(keys, tostring(value))
        -- Boolean property
    elseif (valueType == "boolean") then
        if (value) then
            return (" -S %s %s"):format(keys, 1)
        end
        return (" -S %s %s"):format(keys, 0)
        -- Number property
    elseif (valueType == "number") then
        return (" -S %s %s"):format(keys, tostring(value))
        -- Table
    elseif (valueType == "table" and #value == 0) then
        local sentence = ""
        for subField, subValue in pairs(value) do
            sentence = sentence .. createKeys(keys .. "." .. subField, subValue)
        end
        return sentence
        -- Array
    elseif (valueType == "table" and #value > 0) then
        -- Reserve elements space
        local sentence = (" -I %s %s end"):format(keys, #value)
        for elementIndex, subValue in ipairs(value) do
            sentence = sentence .. createKeys((keys .. "[%s]"):format(elementIndex - 1), subValue)
        end
        return sentence
    else
        print(keys)
        error("Unknown property type!")
    end
end

--- Set properties to widget
---@param widgetPath string Path to widget tag
---@param keys invaderWidget Properties to set into widget
function widget.edit(widgetPath, keys)
    print("Editing: " .. widgetPath)
    local updateTagCmd = editCmd:format(widgetPath)
    glue.map(keys, function(property, value)
        updateTagCmd = updateTagCmd .. writeMapFields(property, value)
    end)
    os.execute(updateTagCmd)
end

---Get a value from a widget given key
---@param widgetPath string
---@param key string
---@return string | number
function widget.get(widgetPath, key)
    local pipe = io.popen(getCmd:format(widgetPath, key))
    local value = pipe:read("*a")
    -- local value = pipe:read("*a"):gsub("\n", ""):gsub("\r", ""):gsub("/", "\\")
    return glue.string.trim(value)
end

---Count entries from a widget given key
---@param widgetPath any
---@param key any
---@return number
function widget.count(widgetPath, key)
    local pipe = io.popen(countCmd:format(widgetPath, key))
    local value = pipe:read("*a")
    return tonumber(value)
end

---Insert a quantity of structs to specific key
---@param widgetPath string
---@param key string
---@param count number
---@param position number | '"end"'
function widget.insert(widgetPath, key, count, position)
    os.execute(insertCmd:format(widgetPath, key, count, position or 0))
end

function widget.create(widgetPath, keys)
    print("Creating: " .. widgetPath)
    -- Create widget from scratch
    local createTagCmd = createCmd:format(widgetPath)
    glue.map(keys, function(property, value)
        createTagCmd = createTagCmd .. createKeys(property, value)
    end)
    os.execute(createTagCmd)
end

---Merge keys from one widgetion definition to another
---@param keys invaderWidget
---@param newKeys invaderWidget
---@return invaderWidget
function widget.merge(keys, newKeys)
    return glue.merge(keys, newKeys)
end

return widget
