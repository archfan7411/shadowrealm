-- used to craft Aspfang Sword
minetest.register_craftitem("shadowrealm:asp_fang", {
	description = "Asp Fang",
	inventory_image = "shadowrealm_asp_fang.png",
})

-- used to bait Gargantuan
minetest.register_craftitem("shadowrealm:asp_meat", {
	description = "Asp Meat",
	inventory_image = "shadowrealm_asp_meat.png",
})

-- obligatory item, but not usable as bait
minetest.register_craftitem("shadowrealm:asp_meat_cooked", {
	description = "Cooked Asp Meat",
	inventory_image = "shadowrealm_asp_meat_cooked.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "cooking",
	output = "shadowrealm:asp_meat_cooked",
	recipe = "shadowrealm:asp_meat",
	cooktime = 4,
})

-- used to bait Asp
minetest.register_craftitem("shadowrealm:caramelized_apple", {
	description = "Carmelized Apple",
	inventory_image = "shadowrealm_caramelized_apple.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	output = "shadowrealm:caramelized_apple",
	recipe = "default:apple",
	cooktime = 4,
})

minetest.register_tool("shadowrealm:asptooth_sword", {
	description = "Asptooth Sword",
	inventory_image = "shadowrealm_asptooth_sword.png",
})

minetest.register_tool("shadowrealm:aspfang_sword", {
	description = "Aspfang Sword",
	inventory_image = "shadowrealm_aspfang_sword.png",
	wield_scale = {x = 2, y = 2, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level = 1,
		damage_groups = {fleshy=8},
	},
	groups = {sword = 1}
})

minetest.register_craft({
	type = "shaped",
	output = "shadowrealm:aspfang_sword",
	recipe = {
		{"", "shadowrealm:asp_fang", ""},
		{"", "shadowrealm:asp_fang", ""},
		{"", "group:stick", ""},
	},
})
