
-- Created by jogag
-- Part of the Digiline Stuff pack
-- Mod: digiline memory chip
-- A memory chip you can use to store several strings
-- "SET <address> <string>" to write
-- "GET <address>" to read
-- "ERASE" to delete all!!! xD

local GET_CMD = "GET"
local SET_CMD = "SET"
local DEL_CMD = "ERASE"

local OK_MSG = "OK"

-- list with the various chip sizes
-- (put two equal chips in crafting grid to upgrade)
local MEMORY_CHIPS = { 16, 32, 64, 128, 256, 512, 1024 }

-- all taken from digiline RTC mod
local chip_nodebox =
{
	type = "fixed",
	fixed = {
		{ -8/16, -8/16, -8/16, 8/16, -7/16, 8/16 }, -- bottom slab

		{ -7/16, -7/16, -7/16, 7/16, -5/16,  7/16 },
	}
}

local chip_selbox =
{
	type = "fixed",
	fixed = {{ -8/16, -8/16, -8/16, 8/16, -3/16, 8/16 }}
}

local get_chip_size = function(pos)
	return MEMORY_CHIPS[tonumber(minetest.get_node(pos).name:split("_")[3])]
end

local on_digiline_receive = function(pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local data = minetest.deserialize(meta:get_string("data"))
	--     ^^  xDDDDD
	if channel == meta:get_string("channel") then
		if msg == DEL_CMD then
			meta:set_string("data", "return {}")
			digiline:receptor_send(pos, digilines.rules.default, channel, OK_MSG)
			return
		end

		if msg:split(" ")[2] == nil then return end -- no arguments :/

		cmd = msg:split(" ")[2]
		addr = tonumber(msg:split(" ")[2])
		if addr == nil or addr < 1 or addr > get_chip_size(pos) then return end -- invalid address

		if cmd == GET_CMD then digiline:receptor_send(pos, digiline.rules.default, channel, data[addr])
		elseif cmd == SET_CMD and msg:split(" ")[3] ~= nil then
			data[addr] = msg:sub(cmd:len() + tostring(addr):len() + 2, -1) -- its too complicated...
			meta:set_string("data", minetest.serialize(data))
			digiline:receptor_send(pos, digilines.rules.default, channel, OK_MSG)
		end
	end
end

for i, s in ipairs(MEMORY_CHIPS) do
	minetest.register_node("digilines_memory:memory_"..i, {
		description = "Digiline Memory Chip ("..s.." addresses)",
		drawtype = "nodebox",
		tiles = {"digilines_memory.png"},

		paramtype = "light",
		paramtype2 = "facedir",
		groups = {dig_immediate=2},
		selection_box = chip_selbox,
		node_box = chip_nodebox,
		digiline = {
			receptor = {},
			effector = { action = on_digiline_receive },
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "field[channel;Channel;${channel}]")
			meta:set_string("infotext", "Memory Chip ("..get_chip_size(pos).." addresses)")
			meta:set_string("channel", "")
			meta:set_string("data", "return {}") -- xD
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.channel then minetest.get_meta(pos):set_string("channel", fields.channel) end
		end,
	})
	
	if i ~= 1 then
		minetest.register_craft({
			type = "shapeless",
			output = "digilines_memory:memory_"..i,
			recipe = {
				"digilines_memory:memory_"..(i - 1),
				"digilines_memory:memory_"..(i - 1),
			},
		})
	end
end
