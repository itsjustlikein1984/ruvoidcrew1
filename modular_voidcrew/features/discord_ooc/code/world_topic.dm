// VOIDCREW modular feature: discord_ooc
// Приём OOC-сообщений из Discord через world/Topic.

/datum/world_topic/discord_ooc
	keyword = "ooc"

/datum/world_topic/discord_ooc/Run(list/input)
	var/sender = input["sender"] || "Discord"
	var/msg = html_decode(input["msg"] || input["message"])
	if(!msg)
		return "No message"
	to_chat(world, "<span class='oocplain'><font color='#002eb8'><b>\[Discord] <EM>[sender]:</EM> <span class='message linkify'>[msg]</span></b></font></span>")
	return "OK"
