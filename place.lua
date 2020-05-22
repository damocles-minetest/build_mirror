
local function place_mirrored(pos, node, mirror_pos, mirrors)
  local mirrored_pos = { x = pos.x, y = pos.y, z = pos.z }

  local node_def = minetest.registered_items[node.name]
  if node_def.paramtype2 == "facedir" then
    -- change param2
    local dir = minetest.facedir_to_dir(node.param2)

    if mirrors.x then
      dir.x = dir.x * -1
    end
    if mirrors.y then
      dir.y = dir.y * -1
    end
    if mirrors.z then
      dir.z = dir.z * -1
    end

    node.param2 = minetest.dir_to_facedir(dir)
  end

  -- mirror positions
  if mirrors.x then
    mirrored_pos.x = mirror_pos.x - (pos.x - mirror_pos.x)
  end
  if mirrors.y then
    mirrored_pos.y = mirror_pos.y - (pos.y - mirror_pos.y)
  end
  if mirrors.z then
    mirrored_pos.z = mirror_pos.z - (pos.z - mirror_pos.z)
  end

  minetest.log("action",
    "[mirror] placing " .. node.name ..
    " with param2 " .. node.param2 ..
    " at " .. minetest.pos_to_string(mirrored_pos)
  )
  minetest.set_node(mirrored_pos, node)
end

minetest.register_on_placenode(function(pos, newnode, placer)
  if not placer then
    return
  end

  local playername = placer:get_player_name()
  local mirror_pos = build_mirror.pos[playername]

  if not mirror_pos then
    return
  end

  local ppos = placer:get_pos()
  if vector.distance(ppos, pos) > build_mirror.max_range then
    minetest.chat_send_player(playername, "[Build mirror] out of range!")
  end

  if build_mirror.x[playername] then
    place_mirrored(pos, newnode, mirror_pos, { x=true })
  end

  if build_mirror.y[playername] then
    place_mirrored(pos, newnode, mirror_pos, { y=true })
  end

  if build_mirror.z[playername] then
    place_mirrored(pos, newnode, mirror_pos, { z=true })
  end

  if build_mirror.x[playername] and build_mirror.z[playername] then
    place_mirrored(pos, newnode, mirror_pos, { x=true, z=true })
  end

  if build_mirror.y[playername] and build_mirror.x[playername] then
    place_mirrored(pos, newnode, mirror_pos, { y=true, x=true })
  end

  if build_mirror.y[playername] and build_mirror.z[playername] then
    place_mirrored(pos, newnode, mirror_pos, { y=true, z=true })
  end

  if build_mirror.x[playername] and build_mirror.y[playername] and build_mirror.z[playername] then
    place_mirrored(pos, newnode, mirror_pos, { x=true, y=true, z=true })
  end
end)
