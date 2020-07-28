

--[[
/mirror y
/mirror x
/mirror z
/mirror set
/mirror off
--]]

minetest.register_chatcommand("mirror", {
  params = "[set|x|y|z|off]",
  privs = { server = true },
  description = "",
  func = function(name, param)
    local player = minetest.get_player_by_name(name)
    if not player then
      return false, "Player not online!"
    end

    if param == "off" then
      build_mirror.x[name] = nil
      build_mirror.y[name] = nil
      build_mirror.z[name] = nil
      build_mirror.update_hud(player)
      return true, "Mirror disabled"

    -- TODO: set by punching a node
    elseif param == "set" then
      local ppos = player:get_pos()
      build_mirror.pos[name] = vector.round(ppos)
      build_mirror.update_hud(player)
      return true, "Set mirror-position to " .. minetest.pos_to_string(build_mirror.pos[name])

    elseif param == "x" then
      build_mirror.x[name] = not build_mirror.x[name]
      build_mirror.update_hud(player)
      if build_mirror.x[name] then
        return true, "X-Axis mirror: enabled"
      else
        return true, "X-Axis mirror: disabled"
      end

    elseif param == "y" then
      build_mirror.y[name] = not build_mirror.y[name]
      build_mirror.update_hud(player)
      if build_mirror.y[name] then
        return true, "Y-Axis mirror: enabled"
      else
        return true, "Y-Axis mirror: disabled"
      end

    elseif param == "z" then
      build_mirror.z[name] = not build_mirror.z[name]
      build_mirror.update_hud(player)
      if build_mirror.z[name] then
        return true, "Z-Axis mirror: enabled"
      else
        return true, "Z-Axis mirror: disabled"
      end
    end

    return false, "Invalid command!"
  end
})
