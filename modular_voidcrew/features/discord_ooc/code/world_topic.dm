// VOIDCREW modular feature: discord_ooc
// Приём OOC-сообщений из Discord через world/Topic.

/datum/world_topic/discord_ooc
	keyword = "ooc"
	require_comms_key = TRUE

/datum/world_topic/discord_ooc/Run(list/input)
	var/sender = input["sender"]
	var/msg = html_decode(input["msg"])
	to_chat(world, "<span class='oocplain'><font color='#002eb8'><b>\[Discord] <EM>[sender]:</EM> <span class='message linkify'>[msg]</span></b></font></span>")
	return 1

/datum/world_topic/ooc
	keyword = "ooc"

/datum/world_topic/ooc/Run(list/input)
	var/sender = input["sender"] || "Central Command"
	var/msg = input["msg"] || input["message"]
	if(!msg)
		return "No message"
	to_chat(world, "<span class='ooc'><span class='prefix'>OOC:</span> <span class='bold'>[sender]:</span> <span class='message'>[msg]</span></span>")
	return "OK"
