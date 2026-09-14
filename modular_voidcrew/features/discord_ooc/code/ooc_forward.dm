// VOIDCREW modular feature: discord_ooc
// Форвардинг игрового OOC в Discord через webhook.

/// Отправляет OOC-сообщение в настроенный Discord-webhook.
///
/// Параметры:
/// - raw_msg    — текст сообщения, как его ввёл игрок
/// - sender_key — ckey отправителя (client.key), для отображения в Discord
///
/// Если webhook не настроен через конфиг ooc_webhook_url — тихо выходим.
/proc/forward_ooc_to_discord(raw_msg, sender_key)
	var/ooc_webhook = CONFIG_GET(string/ooc_webhook_url)
	if(!ooc_webhook)
		return

	var/clean_msg = copytext_char(raw_msg, 1, 1900)
	var/list/payload = list(
		"username" = "[sender_key] (OOC)",
		"content" = clean_msg,
		"allowed_mentions" = list("parse" = list())
	)

	var/datum/http_request/request = new()
	request.prepare(
		RUSTG_HTTP_METHOD_POST,
		ooc_webhook,
		json_encode(payload),
		list("Content-Type" = "application/json"),
		""
	)
	request.begin_async()
