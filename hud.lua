
-- playername => id
local waypoint = {}

function build_mirror.update_hud(player)
  local playername = player:get_player_name()
  local mirror_enabled = build_mirror.x[playername] or
    build_mirror.y[playername] or
    build_mirror.z[playername]

  if waypoint[playername] then
    -- update
    if mirror_enabled then
      -- update position
      player:hud_change(waypoint[playername], "world_pos", build_mirror.pos[playername])
    else
      -- remove hud element
      player:hud_remove(waypoint[playername])
      waypoint[playername] = nil
    end
  else
    if build_mirror.pos[playername] then
      -- create new id
      local id = player:hud_add({
        hud_elem_type = "waypoint",
        name = "Build mirror",
        text = "m",
        number = 0xFF0000,
        world_pos = build_mirror.pos[playername]
      })
      waypoint[playername] = id
    end
  end
end
