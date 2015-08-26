
-- Created by jogag
-- Part of the Digiline Stuff pack
-- Mod: Plastic from homedecor, if homedecor is not installed :)
-- + Also checks for pipeworks!

-- Texture license: from VanessaE, WTFPL

if not minetest.get_modpath("homedecor") and not minetest.get_modpath("pipeworks") then

	minetest.register_craftitem(":homedecor:oil_extract", {
		description = "Oil extract",
		inventory_image = "homedecor_oil_extract.png",
	})

	minetest.register_craftitem(":homedecor:paraffin", {
		description = "Unprocessed paraffin",
		inventory_image = "homedecor_paraffin.png",
	})

	minetest.register_alias("homedecor:plastic_base", "homedecor:paraffin")

	minetest.register_craftitem(":homedecor:plastic_sheeting", {
		description = "Plastic sheet",
		inventory_image = "homedecor_plastic_sheeting.png",
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:oil_extract 6",
		recipe = { "default:junglegrass",
		   "default:junglegrass",
		   "default:junglegrass"
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:oil_extract 3",
		recipe = { "default:dry_shrub",
		   "default:dry_shrub",
		   "default:dry_shrub"
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:oil_extract 4",
		recipe = { "default:leaves",
			   "default:leaves",
			   "default:leaves",
			   "default:leaves",
			   "default:leaves",
			   "default:leaves"
		}
	})

	minetest.register_craft({
		type = "cooking",
		output = "homedecor:paraffin",
		recipe = "homedecor:oil_extract",
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "homedecor:paraffin",
		burntime = 30,
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "homedecor:plastic_sheeting",
		burntime = 30,
	})

	minetest.register_alias("pipeworks:oil_extract", "homedecor:oil_extract")
	minetest.register_alias("pipeworks:paraffin", "homedecor:paraffin")
	minetest.register_alias("pipeworks:plastic_sheeting", "homedecor:plastic_sheeting")
end
