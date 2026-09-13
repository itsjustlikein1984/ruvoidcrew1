# Tiny5 Font

Пиксельный шрифт с поддержкой кириллицы (U+0400–U+04FF).

## Зачем

Grand9K Pixel не содержит кириллицы — русские буквы в `.maptext` уходили
в системный fallback и выглядели размыто.

## Файлы

- `code/tiny5.dm` — `/datum/font/tiny5`
- `fonts/Tiny5.ttf` — сам шрифт

## Изменения в оригинальных файлах

- `interface/skin.dmf` — `.maptext { font-family: 'Tiny5' }` вместо `'Grand9K Pixel'`
