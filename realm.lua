-- Shadow Realm Mod

-- Depth allowed before being injured due to dark magic
-- prior to defeating the boss
local DEPTH_ALLOWED = -200

local modstorage = minetest.get_mod_storage()

-- If player has defeated the boss (0 = false, 1 = true)
local defeated = modstorage:get_int("defeated") == 1

realm = {
	mobs = {}, -- Mobs are spawned when the player enters the realm
	players = {}, -- Players which are in the realm; list of playernames
	-- ^ As particlespawners have to be created per-player
	indices = {}, -- Indices of particlespawners for the shadow effect.
	-- ^ Key is player name, value is list of particlespawner indices.
}

-- reset
minetest.register_on_leaveplayer(function(player)
	players[player:get_player_name()] = nil
end)

-- Entity which will carry the sparkle particlespawner
-- This will be invisible, but the particlespawners for
-- each mob will be attached to it.
-- Upon the mob being summoned to the real world, the sparkler
-- will be destroyed.
minetest.register_entity("shadowrealm:sparkler",
{
	initial_properties = {
		visual = "sprite",
		is_visible = false,
	},
})

-- Returns the particlespawner definition, attached to a provided
-- object, for use with minetest.add_particlespawner
realm.get_spawner_definition = function(object, playername)
	return {
		amount = 10,
		time = 0,
		attached = object,
		playername = playername,
		texture = "shadowrealm_sparkle.png",
		minpos = {x=0, y=1, z=0},
		maxpos = {x=0, y=1, z=0},
	}
end

realm.enter_shadow_realm = function(player)
	player:set_properties({
		is_visible = false,
	})
	local name = player:get_player_name()
	realm.indices[name] = {}
	-- Add particlespawners for all mobs in the shadow realm
	for _, object in pairs(realm.mobs) do
		local def = realm.get_spawner_definition(object, name)
		local index = minetest.add_particlespawner(def)
		realm.indices[name][#realm.indices[name]] = index
	end
	for _, playername in pairs(realm.players) do
		local object = minetest.get_player_by_name(playername)
		if not object then return end
		local def = realm.get_spawner_definition(object, name)
		local index = minetest.add_particlespawner(def)
		realm.indices[name][#realm.indices[name]] = index
		-- now show this player to the other shadow realm players
		def = realm.get_spawner_definition(player, playername)
		index = minetest.add_particlespawner(def)
		realm.indices[playername][#realm.indices[playername]] = index
	end
	realm.players[#realm.players] = name
end

realm.exit_shadow_realm = function(object)
	if object:is_player() then
		player:set_properties({
			is_visible = true,
		})
		local name = player:get_player_name()
		if realm.indices[name] then
			for _, index in realm.indices[name] do
				minetest.delete_particlespawner(index)
			end
			-- We don't need those particlespawner indices now
			realm.indices[name] = nil
		end
	end
end

realm.is_in_shadow_realm = function(playername)
	return realm.players[playername]
end

realm.allow_underground = function()
	defeated = true
	modstorage:set_int("defeated", 1)
end

-- Increment variable
local underground_timer = 0
minetest.register_globalstep(function(dtime)
	if not defeated and dtime then
		underground_timer = underground_timer + dtime
		if underground_timer >= 1 then
			for _, player in pairs(minetest.get_connected_players()) do
				-- If player is too deep
				if player:get_pos().y < DEPTH_ALLOWED then
					player:set_hp(player:get_hp()-1)
				end
			end
			underground_timer = 0
		end
	end
end)
