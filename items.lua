-- used to craft Asptooth Sword
minetest.register_craftitem("shadowrealm:asp_tooth", {
	description = "Asp Tooth",
	inventory_image = "shadowrealm_asp_tooth.png",
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
minetest.register_craftitem("shadowrealm:carmelized_apple", {
	description = "Carmelized Apple",
	inventory_image = "shadowrealm_carmelized_apple.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	output = "shadowrealm:carmelized_apple",
	recipe = "default:apple",
	cooktime = 4,
})

minetest.register_tool("shadowrealm:asptooth_sword", {
	description = "Asptooth Sword",
	inventory_image = "shadowrealm_asptooth_sword.png",
})
