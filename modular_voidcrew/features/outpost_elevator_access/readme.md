# Outpost Elevator Access

Ограничение доступа к чужим кораблям на лифте аванпостов.
Посторонние игроки не могут отправить лифт на чужой причал; отправка разрешена только членам экипажа корабля. Пассажиры в лифте поднимаются вместе с членом экипажа на причал. Этаж торговца (Concourse) открыт для всех.

## Модульные файлы

- `code/outpost_elevator_access.dm` — реализация `/obj/machinery/outpost_elevator/proc/can_access_floor()`

## Изменения в оригинальных файлах

- `voidcrew/modules/trade/outpost_elevator.dm` — проверка прав `can_access_floor()` в `ui_data` и `ui_act`
- `tgui/packages/tgui/interfaces/OutpostElevator.tsx` — отображение статуса доступа, иконка замка и блокировка кнопок чужих причалов

