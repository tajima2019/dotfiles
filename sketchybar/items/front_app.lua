local sbar = require("sketchybar")
local colors = require("colors")
local settings = require("settings")

local bg_color_active = 0xff1e1e2e
local is_menu_open = false

local front_app = sbar.add("item", "front_app", {
  display = "active",
  icon = { drawing = false },
  width = 160,
  label = {
    font = {
      style = settings.font.style_map["Black"],
      size = 14.0,
    },
    color = colors.red_bright,
    width = 160,
    align = "center",
    max_chars = 20,
    scroll_duration = 0,
  },
  background = {
    color = colors.transparent,
    corner_radius = 5,
    height = 24,
  },
  updates = true,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")

  is_menu_open = not is_menu_open

  sbar.animate("tanh", 1, function()
    front_app:set({
      background = {
        color = is_menu_open and bg_color_active or colors.transparent
      }
    })
  end)
end)

front_app:subscribe("swap_menus_and_spaces", function(env)
end)
