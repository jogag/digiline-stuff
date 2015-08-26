
-- Created by jogag
-- Part of the Digiline Stuff pack
-- Mod: crafting recipes for all devices
-- Also adds recipes for RTC and Lightsensor

------------------------------
-- DIGILINE BUILTIN DEVICES --
------------------------------

-- RTC
minetest.register_craft({
	output = "digilines_rtc:rtc 2",
	recipe = {
		{ "default:steel_ingot" },
		{ "mesecons_materials:silicon" },
		{ "digilines:wire_std_00000000" },
	},
})

-- Light sensor
minetest.register_craft({
	output = "digilines_lightsensor:lightsensor 2",
	recipe = {
		{ "homedecor:plastic", "default:glass" },
		{ "", "mesecons_materials:silicon" },
		{ "", "digilines:wire_std_00000000" },
	},
})

-------------------------
-- DIGILINE STUFF PACK --
-------------------------

-- Memory chip (16 spaces)
minetest.register_craft({
	output = "digilines_memory:memory_1",
	recipe = {
		{ "mesecons_materials:silicon", "mesecons_materials:silicon", "mesecons_materials:silicon" },
		{ "group:mesecon_conductor_craftable", "default:mese_crystal_fragment", "group:mesecon_conductor_craftable" },
		{ "mesecons_materials:fiber", "digilines:wire_std_00000000", "mesecons_materials:fiber" },
	},
})

-- Weather sensor
minetest.register_craft({
	output = "digilines_weather_sensor:sensor 2",
	recipe = {
		{ "default:stick" },
		{ "mesecons_materials:silicon" },
		{ "digilines:wire_std_00000000" },
	},
})

-- Digiprinter
minetest.register_craft({
	output = "digiprinter:printer",
	recipe = {
		{ "homedecor:plastic_sheeting", "", "" },
		{ "digilines:wire_std_00000000", "default:mese_crystal", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
	},
})

