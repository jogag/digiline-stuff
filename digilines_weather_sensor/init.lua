
-- Created by jogag
-- Part of the Digiline Stuff pack
-- Mod: digiline rain sensor
-- Compatible with Weather mod and my own Weather+ mod
-- Send "GET" to obtain the current weather (none, rain, snow, error)
-- If you get "error" is because the weather mod is not installed

local GET_CMD = "GET"

local ERR_MSG = "none"

-- all taken from digiline lightsensor mod
local wsensor_nodebox =
{
	type = "fixed",
	fixed = {
		{ -8/16, -8/16, -8/16, 8/16, -7/16, 8/16 }, -- bottom slab

		{ -7/16, -7/16, -7/16, -4/16, -5/16,  7/16 }, -- bonds
		{  4/16, -7/16, -7/16,  7/16, -5/16,  7/16 },
		{ -7/16, -7/16, -7/16,  7/16, -5/16, -4/16 },
		{ -7/16, -7/16,  4/16,  7/16, -5/16,  7/16 },

		{ -1/16, -7/16, -1/16, 1/16, -5/16, 1/16 }, -- pin thing in the middle
	}
}

local wsensor_selbox =
{
	type = "fixed",
	fixed = {{ -8/16, -8/16, -8/16, 8/16, -3/16, 8/16 }}
}

local on_digiline_receive = function (pos, node, channel, msg)
	local setchan = minetest.get_meta(pos):get_string("channel")
	if channel == setchan and msg == GET_CMD then
		local value = weather and tostring(weather) or ERR_MSG
		digiline:receptor_send(pos, digiline.rules.default, channel, value)
	end
end

minetest.register_node("digilines_weather_sensor:sensor", {
	description = "Digiline Rain Sensor",
	drawtype = "nodebox",
	tiles = {"digilines_weather_sensor.png"},

	paramtype = "light",
	groups = {dig_immediate=2},
	selection_box = wsensor_selbox,
	node_box = wsensor_nodebox,
	digiline = {
		receptor = {},
		effector = { action = on_digiline_receive },
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.channel then minetest.get_meta(pos):set_string("channel", fields.channel) end
	end,
})

