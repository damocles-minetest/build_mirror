minetest.register_on_leaveplayer(function(player)
  local playername = player:get_player_name()
  build_mirror.x[playername] = nil
  build_mirror.y[playername] = nil
  build_mirror.z[playername] = nil
  build_mirror.pos[playername] = nil
end)
