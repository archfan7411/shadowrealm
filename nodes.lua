-- Bait box

realm.baits = {
	["shadowrealm:asp_meat"] = {"shadowrealm:gargantuan", "Gargantuan"},
	["shadowrealm:caramelized_apple"] = {"shadowrealm:asp", "Asp"},
}

minetest.register_node("shadowrealm:bait_trap", {
	description = "Bait Box\nSummon a creature from the Shadow Realm!",
	tiles = {"shadowrealm_bait_trap.png"},
	groups = {cracky=2},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local name = itemstack:get_name()
		if realm.baits[name] then
			local timer = minetest.get_node_timer(pos)
			if timer:is_started() then return end
			local bait = realm.baits[name]
			itemstack:take_item()
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", "Baited for "..bait[2])
			meta:set_string("bait", bait[1])
			timer:start(10)
		end
		return itemstack
	end,
	on_timer = function(pos, elapsed)
		local timer = minetest.get_node_timer(pos)
		timer:stop()
		local meta = minetest.get_meta(pos)
		local ent = meta:get_string("bait")
		meta:set_string("infotext", "")
		pos = {x=pos.x, y=pos.y + 2, z=pos.z}
		minetest.add_entity(pos, ent)
	end
})

minetest.register_craft({
	type = "shaped",
	recipe = {
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"group:tree", "group:wood", "group:tree"},
	},
	output = "shadowrealm:bait_trap",
})
