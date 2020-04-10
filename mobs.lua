-- Using Termos' MobKit
-- Shadow Realm Mobs

local old_lq_jumpattack = mobkit.lq_jumpattack

-- utilizing examples from Lone_Wolf's Voxel Knights

--[[function mobkit.hq_attack(self,prty,tgtobj)
	mobkit.lq_turn2pos(self, tgtobj:get_pos())

	if self.attack_ok then
		self.attack_ok = false

		mobkit.animate(self, "leap")
		tgtobj:punch(
			self.object,
			self.attack.interval,
			self.attack,
			vector.direction(self.object:get_pos(), tgtobj:get_pos())
		)

		minetest.after(self.attack.interval, function() self.attack_ok = true end)
	end
end]]--

function mobkit.on_punch(self, puncher, time_from_last_punch, toolcaps, dir)
	if puncher:is_player() then
		self.puncher = puncher:get_player_name()
	end

	if toolcaps.damage_groups then
		self.hp = self.hp - toolcaps.damage_groups.fleshy or 0
	end
end
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

			if prty < 20 then
				local target = mobkit.get_nearby_player(self)
				if target then
					mobkit.hq_hunt(self, prty, target)
				end
			elseif mobkit.is_queue_empty_high(self) then
				mobkit.hq_roam(self, prty)
			end
		end
	end,
	animation = {
		walk = {range={x=1, y=10}, speed=24, loop=true},
		leap = {range={x=11, y=31}, speed=24, loop=false},
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
