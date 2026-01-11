local sbar = require("sketchybar")
local colors = require("colors")
local settings = require("settings")

local colors_spaces = {
  [1] = colors.cmap_1 or colors.red,
  [2] = colors.cmap_2 or colors.orange,
  [3] = colors.cmap_3 or colors.yellow,
  [4] = colors.cmap_4 or colors.green,
  [5] = colors.cmap_5 or colors.cyan,
  [6] = colors.cmap_6 or colors.blue,
  [7] = colors.cmap_7 or colors.magenta,
  [8] = colors.cmap_8 or colors.white,
  [9] = colors.cmap_9 or colors.gray,
}

local loop_interval = 0

-- イベントの登録
sbar.add("event", "aerospace_workspace_change")

local aerospace_cmd = "/opt/homebrew/bin/aerospace"

sbar.exec(aerospace_cmd .. " list-workspaces --all", function(workspaces)
  local space_names = {}

  for sid in workspaces:gmatch("%S+") do
    local sid_n = tonumber(sid) or 1
    local space_color = colors_spaces[sid_n] or colors.white

    local space = sbar.add("item", "space." .. sid, {
      icon = {
        font = {
          family = settings.font.numbers,
          size = 14,
        },
        string = sid,
        padding_left = 10,
        padding_right = 10,
        color = space_color,
        highlight_color = colors.tn_black3,
      },
      label = { drawing = false },
      background = {
        color = colors.transparent,
        border_color = colors.transparent,
        height = 26,
        border_width = 2,
        corner_radius = 6,
        drawing = true,
      },
      padding_left = 2,
      padding_right = 2,
      click_script = "aerospace workspace " .. sid,
    })

    table.insert(space_names, space.name)

    space:subscribe("aerospace_workspace_change", function(env)
      local selected = (env.FOCUSED_WORKSPACE == sid)

      -- アニメーション設定
      sbar.animate("tanh", 1, function()
        space:set({
          icon = {
            highlight = selected,
            color = selected and colors.tn_black3 or space_color,
          },
          background = {
            color = selected and space_color or colors.transparent,
            border_color = selected and space_color or colors.transparent,
          },
        })
      end)
    end)
  end

  sbar.add("bracket", space_names, {
    background = {
      color = colors.tn_black3 or 0xff1e1e2e,
      border_color = colors.accent1 or 0xff89b4fa,
      border_width = 2,
      corner_radius = 10,
      height = 32,
    }
  })

  sbar.add("item", { width = 10 })
end)
