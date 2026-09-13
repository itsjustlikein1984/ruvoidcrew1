# Modular Voidcrew

Модульные изменения относительно upstream `voidcrew/Voidcrew`.

## Правила

- Новые фичи — в `features/<module_id>/`
- Оверрайды существующих объектов/функций — `master_*.dm` с `. = ..()`
- Если модульно нельзя — прямая правка с пометкой `// VOIDCREW EDIT`
- Каждый модуль содержит `readme.md`

## Модули

| ID | Описание |
|---|---|
| `tiny5_font` | Пиксельный шрифт с кириллицей |
| `discord_ooc` | Мост OOC ↔ Discord webhook |
| `character_db_backup` | Зеркалирование слотов персонажа в MariaDB |
| `hub_status` | Кастомный статус в TG-hub |
