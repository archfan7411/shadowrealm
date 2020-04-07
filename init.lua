-- Shadow Realm Mod

-- Depth allowed before being injured due to dark magic
-- prior to defeating the boss
local DEPTH_ALLOWED = -200

local modstorage = minetest.get_mod_storage()

-- If player has defeated the boss (0 = false, 1 = true)
local defeated = modstorage:get_int("defeated") == 1

realm = {
	-- Both following are lists of ObjectRefs
	mobs = {} -- Mobs are spawned when the player enters the realm
	players = {} -- Players which are in the realm
	-- As particlespawners have to be created per-player
}

-- Entity which will carry the sparkle particlespawner
-- This will be invisible, but the particlespawners for
-- each player will be attached to it.
minetest.register_entity("shadowrealm:sparkle_carrier",
{
	initial_properties = {
		visual = "sprite",
		is_visible = false,
	},
})

-- Returns the particlespawner definition, attached to a provided
-- object, for use with minetest.add_particlespawner
realm.get_spawner_definition = function(object)
	return {
		amount = 10,
		time = 0,
		attached = object,
		texture = "shadowrealm_sparkle.png",
	}
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
