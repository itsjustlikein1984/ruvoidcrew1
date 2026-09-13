# Discord OOC

Мост OOC ↔ Discord через webhook.

## Модульные файлы

- `code/world_topic.dm` — датумы world_topic
- `code/config_entry.dm` — конфиг `ooc_webhook_url`
- `code/ooc_forward.dm` — `/proc/forward_ooc_to_discord()`

## Изменения в оригинальных файлах

- `code/modules/client/verbs/ooc.dm` — вызов `forward_ooc_to_discord()` с маркером
