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
			return nil
		end
	end,
})
