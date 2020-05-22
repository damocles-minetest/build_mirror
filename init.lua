
build_mirror = {

  -- max radius around mirror
  max_range = 100,

  -- playername => pos
  pos = {},

  -- playername => true
  x = {},
  y = {},
  z = {}
}


local MP = minetest.get_modpath(minetest.get_current_modname())
dofile(MP .. "/common.lua")
dofile(MP .. "/chatcommands.lua")
dofile(MP .. "/hud.lua")
dofile(MP .. "/place.lua")
dofile(MP .. "/dig.lua")
dofile(MP .. "/cleanup.lua")
