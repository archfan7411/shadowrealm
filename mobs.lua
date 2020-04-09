-- Using Termos' MobKit
-- Shadow Realm Mobs

-- Asp
minetest.register_entity("shadowrealm:asp", {
	initial_properties = {
		physical = true,
		collisionbox = {0.5, 1, 0.5, -0.5, -2, -0.5},
		visual = "mesh",
		mesh = "shadowrealm_asp.b3d",
		textures = {"shadowrealm_asp.png"},
		visual_size = {x=3,y=3,z=3},
	},
	timeout = 100,
	buoyancy = -0.1,
	lung_capacity = 0,
	max_hp = 25,
	on_step = mobkit.stepfunc,
	on_activate = mobkit.actfunc,
	get_staticdata = mobkit.statfunc,
	logic = function(self)
		if not self then return end
		if mobkit.timer(self,1) then
			local prty = mobkit.get_queue_priority(self)

			if prty < 10 then
				local target = mobkit.get_nearby_player()
				if target then
					mobkit.hq_hunt(self, prty, target)
				end
			end

			if mobkit.is_queue_empty_high(self) then
				mobkit.hq_roam(self, prty)
			end
		end
	end,
	animation = {
		walk = {range={x=1, y=10}, speed=24, loop=true},
		leap = {range={x=11, y=31}, speed=24, loop=true},
	},
	sounds = {
		hiss = "shadowrealm_hiss.ogg",
	},
	max_speed = 1,
	jump_height = 1,
	view_range = 10,
	attack = {range = 2, damage_groups = {fleshy = 4}},
	armor_groups = {fleshy = 5},
})
