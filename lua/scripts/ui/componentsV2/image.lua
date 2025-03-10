local widget = require "lua.scripts.widget"
local floor = math.floor

---Image component, displays bitmap image
---@param name string Name of the image component
---@param image string Image to display
---@param width number Width of the image component
---@param height number Height of the image component
---@param scale? number Scale of the image component
---@return string
return function(name, image, width, height, scale)
    local scale = scale or 1
    local originalWidth = width
    local originalHeight = height
    local width = floor(width * scale)
    local height = floor(height * scale)
    local top = -(floor(originalHeight - height))
    local left = -(floor(originalWidth - width))
    if scale >= 1 then
        top = 0
        left = 0
    end
    local widgetPath = widget.path .. name .. "_image.ui_widget_definition"
    ---@type invaderWidget
    local wid = {
        widget_type = "container",
        bounds = top .. ", " .. left .. ", " .. height .. ", " .. width,
        background_bitmap = image
    }
    widget.createV2(widgetPath, wid)
    return widgetPath
end
