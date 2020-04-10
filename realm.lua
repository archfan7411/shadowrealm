-- some random shadow realm things

realm = {}

local modstorage = minetest.get_mod_storage()

realm.is_gargantuan_defeated = modstorage:get_int("dead") == 1

realm.on_gargantuan_death = function()
	minetest.chat_send_all("A Gargantuan, one of the servants of Cerdon, has been slain!")
	realm.is_gargantuan_defeated = true
	modstorage:set_int("dead", 1)
end

-- as long as gargantuan remains undefeated
local timer = 0
minetest.register_globalstep(function(dtime)
	if not realm.is_gargantuan_defeated and dtime then
		timer = timer + dtime
		if not (timer >= 1) then return end
		timer = 0
		for _, player in pairs(minetest.get_connected_players()) do
			local pos = player:get_pos()
			if pos.y < -200 then
				player:set_hp(player:get_hp()-1)
			end
		end
	end
end)
