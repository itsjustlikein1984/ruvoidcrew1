// VOIDCREW modular feature: outpost_elevator_access
// Ограничение доступа к чужим кораблям на лифте аванпостов.

/**
 * Checks whether user is authorized to send the elevator to target floor_id.
 * Floor 0 (Concourse / Trader) is always accessible to everyone.
 * Berth floors (1..OUTPOST_MAX_BERTHS) are only accessible to the crew of the berthed ship.
 * Freight berth on player outposts is accessible to residents / builders.
 */
/obj/machinery/outpost_elevator/proc/can_access_floor(floor_id, mob/user)
	if(floor_id == 0)
		return TRUE
	if(!outpost)
		return FALSE
	if(floor_id >= 1 && floor_id <= OUTPOST_MAX_BERTHS)
		var/datum/outpost_berth/slot = LAZYACCESS(outpost.berths, floor_id)
		if(!slot || !slot.ship)
			return FALSE
		if(slot.ship.ship_team && user?.mind?.ship_teams)
			return (slot.ship.ship_team in user.mind.ship_teams)
		return FALSE
	var/obj/structure/overmap/dynamic/player_outpost/home = astype(outpost)
	if(home?.freight_berth && floor_id == OUTPOST_MAX_BERTHS + 1)
		return home.is_resident(user) || home.can_build(user)
	return FALSE

