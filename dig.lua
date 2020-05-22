

local function dig_mirrored(pos, mirror_pos, mirrors)
  local mirrored_pos = { x = pos.x, y = pos.y, z = pos.z }

  if mirrors.x then
    mirrored_pos.x = mirror_pos.x - (pos.x - mirror_pos.x)
  end
  if mirrors.y then
    mirrored_pos.y = mirror_pos.y - (pos.y - mirror_pos.y)
  end
  if mirrors.z then
    mirrored_pos.z = mirror_pos.z - (pos.z - mirror_pos.z)
  end

  minetest.log("action", "[mirror] digging at " .. minetest.pos_to_string(mirrored_pos))
  minetest.set_node(mirrored_pos, { name = "air" })
end

minetest.register_on_dignode(function(pos, _, digger)
  if not digger then
    return
  end

  local playername = digger:get_player_name()
  local mirror_pos = build_mirror.pos[playername]

  if not mirror_pos then
    return
  end

  local ppos = digger:get_pos()
  if vector.distance(ppos, pos) > build_mirror.max_range then
    minetest.chat_send_player(playername, "[Build mirror] out of range!")
  end

  if build_mirror.x[playername] then
    dig_mirrored(pos, mirror_pos, { x=true })
  end

  if build_mirror.y[playername] then
    dig_mirrored(pos, mirror_pos, { y=true })
  end

  if build_mirror.z[playername] then
    dig_mirrored(pos, mirror_pos, { z=true })
  end

  if build_mirror.x[playername] and build_mirror.z[playername] then
    dig_mirrored(pos, mirror_pos, { x=true, z=true })
  end

  if build_mirror.y[playername] and build_mirror.x[playername] then
    dig_mirrored(pos, mirror_pos, { y=true, x=true })
  end

  if build_mirror.y[playername] and build_mirror.z[playername] then
    dig_mirrored(pos, mirror_pos, { y=true, z=true })
  end

  if build_mirror.x[playername] and build_mirror.y[playername] and build_mirror.z[playername] then
    dig_mirrored(pos, mirror_pos, { x=true, y=true, z=true })
  end
end)
