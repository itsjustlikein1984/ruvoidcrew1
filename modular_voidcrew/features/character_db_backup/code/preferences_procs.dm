// VOIDCREW modular feature: character_db_backup
// Зеркалирование JSON слотов персонажа в MariaDB (таблица preferences_backup).

/// Зеркалит JSON слота персонажа в MariaDB.
/// Игра продолжает работать и без БД — при отсутствии соединения просто тихо выходим.
/datum/preferences/proc/backup_character_to_sql(list/save_data)
	set waitfor = FALSE
	if(!load_and_save || !parent?.ckey || !save_data)
		return
	if(!SSdbcore.IsConnected())
		return
	var/datum/db_query/Q = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("preferences_backup")] (ckey, slot, json_data) \
		VALUES (:ckey, :slot, :json) \
		ON DUPLICATE KEY UPDATE json_data = VALUES(json_data), backed_up_at = NOW()",
		list(
			"ckey" = parent.ckey,
			"slot" = default_slot,
			"json" = json_encode(save_data),
		)
	)
	Q.Execute(async = TRUE, log_error = TRUE)
	qdel(Q)

/// Пытается вытащить JSON слота из MariaDB, если локальный файл пуст.
/// Возвращает list или null.
/datum/preferences/proc/load_character_from_sql(slot)
	set waitfor = FALSE
	if(!load_and_save || !parent?.ckey)
		return null
	if(!SSdbcore.IsConnected())
		return null
	var/datum/db_query/Q = SSdbcore.NewQuery(
		"SELECT json_data FROM [format_table_name("preferences_backup")] \
		WHERE ckey = :ckey AND slot = :slot",
		list("ckey" = parent.ckey, "slot" = slot)
	)
	if(!Q.Execute(async = TRUE, log_error = TRUE))
		qdel(Q)
		return null
	var/result = null
	if(Q.NextRow())
		var/raw = Q.item[1]
		if(raw)
			result = json_decode(raw)
	qdel(Q)
	return result
