-- Shadow Realm Items

minetest.register_craftitem("shadowrealm:shadow_elixir", {
	description = "Shadow Elixir",
	inventory_image = "shadowrealm_shadow_elixir.png",
	stack_max = 1,
	on_use = function(itemstack, user)
		if user and user:is_player() then
			realm.enter_shadow_realm(user)
			return "shadowrealm:escape_elixir"
		end
	end,
})

minetest.register_craftitem("shadowrealm:escape_elixir", {
	description = "Escape Elixir",
	inventory_image = "shadowrealm_escape_elixir.png",
	stack_max = 1,
	on_use = function(itemstack, user)
		if user and user:is_player() and realm.is_in_shadow_realm(user:get_player_name()) then
			realm.exit_shadow_realm(user)
		end
		return ""
	end,
	on_drop = function() return end,
})

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
