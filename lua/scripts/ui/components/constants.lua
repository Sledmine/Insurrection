local width = 854
local height = 480

return {
    color = {
        text = "1, 1, 1, 1",
        title = "1, 1, 1, 1",
        subtitle = "1, 0.301961, 0.454902, 0.623529",
        selected = "1, 0.5, 0.5, 0.5",
        nameplate = "1, 0.8, 0.8, 0.8",
        palette = {
            primary = "#3d6cc1",
            secondary = "#6d90cd",
            phighlight = "#97b2e0",
            shighlight = "#2996ff"
        }
    },
    opacity = {primary = 12.5, secondary = 34.5},
    fonts = {
        title = [[ui/ticker.font]],
        subtitle = [[ui/gamespy.font]],
        text = [[ui/large_ui.font]],
        button = [[ui/large_ui.font]]
    },
    screen = {width = width, height = height},
    getScreenBounds = function()
        return "0, 0, " .. height .. ", " .. width
    end,
    position = {
        header = {x = 40, y = 20},
        options = {x = 40, y = 60},
        back = {x = 630, y = 415},
        action = {x = 444, y = 415},
        footer = {x = 40, y = 330},
        logo = {x = 202, y = 105}
    },
    components = {
        button = {
            normal = {
                width = 184,
                height = 24,
                bitmap = [[insurrection\ui\bitmaps\normal_button.bitmap]]
            },
            large = {
                width = 389,
                height = 24,
                bitmap = [[insurrection\ui\bitmaps\large_button.bitmap]]
            }
        },
        arrow = {
            left = {width = 16, height = 16, bitmap = [[insurrection\ui\bitmaps\arrow_left.bitmap]]},
            right = {
                width = 16,
                height = 16,
                bitmap = [[insurrection\ui\bitmaps\arrow_right.bitmap]]
            },
            up = {width = 10, height = 8, bitmap = [[insurrection\ui\bitmaps\arrow_up.bitmap]]},
            down = {width = 10, height = 8, bitmap = [[insurrection\ui\bitmaps\arrow_down.bitmap]]}
        },
        complexButton = {
            normal = {
                width = 120,
                height = 110,
                bitmap = [[insurrection\ui\bitmaps\complex_button.bitmap]]
            },
            vertical = {
                width = 144,
                height = 158,
                bitmap = [[insurrection\ui\bitmaps\vertical_complex_button.bitmap]]
            },
            horizontal = {
                width = 149,
                height = 36,
                bitmap = [[insurrection\ui\bitmaps\horizontal_complex_button.bitmap]]
            }
        },
        input = {
            small = {
                width = 184,
                height = 23,
                bitmap = [[insurrection\ui\bitmaps\input_small.bitmap]]
            },
            normal = {
                width = 187,
                height = 34,
                bitmap = [[insurrection\ui\bitmaps\input.bitmap]]
            }
        }
    }
}
