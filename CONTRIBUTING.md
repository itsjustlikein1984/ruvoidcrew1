# Как добавить свой код

Привет. Тут не сложно, но есть несколько правил, чтобы мы потом не разгребали конфликты. Прочитай — это займёт пару минут, зато потом не придётся переделывать.

---

## Зачем нужна модульность

Мы форк `voidcrew/Voidcrew`, который сам форк /tg/. Иногда мы подтягиваем обновления из оригинала — `git fetch upstream && git merge`. И если твои правки раскиданы по десяткам чужих файлов без пометок, каждый такой синк превращается в кашу из конфликтов.

Поэтому три простые вещи:

- **Новое** — в свою папку
- **Чужое правишь** — помечай маркером, чтобы легко найти
- **Хочешь дополнить функцию** — через `. = ..()`, не копируй оригинал

---

## Куда что кладём

Всё новое — в `modular_voidcrew/features/<твой_id>/`:

```
modular_voidcrew/features/my_thing/
├── code/           .dm файлы
├── icon/           .dmi/.png (если надо)
├── sound/          .ogg/.wav (если надо)
├── includes.dm     список твоих code/*.dm
└── readme.md       что это, зачем, что тронул
```

### includes.dm

```dm
#include "code\my_file.dm"
```

### Подключение модуля

В `modular_voidcrew/modular_voidcrew.dme` добавь одну строчку:

```dm
#include "features\my_thing\includes.dm"
```

`tgstation.dme` **не трогай**. Там уже подключён сам `modular_voidcrew.dme`, а через него — всё остальное.

### readme.md

Обязателен. Не надо расписывать на три страницы, достаточно так:

```markdown
# My Thing

Что делает и зачем.

## Файлы
- `code/my_file.dm`

## Что тронул в оригинале
- `code/game/world.dm` — добавил X
```

---

## Правишь чужой файл — помечай

Если не пометишь, твои правки потеряются при следующем синке. Так что оборачивай — это не сложно.

### Добавил

```dm
// VOIDCREW EDIT ADDITION BEGIN - MY_THING
var/new_var = TRUE
// VOIDCREW EDIT ADDITION END
```

### Изменил

```dm
// VOIDCREW EDIT CHANGE BEGIN - MY_THING
/* ORIGINAL
var/something = 1
*/
var/something = 2
// VOIDCREW EDIT CHANGE END
```

### Удалил

```dm
// VOIDCREW EDIT REMOVAL BEGIN - MY_THING
// var/old_thing = 1
// VOIDCREW EDIT REMOVAL END
```

**ID пиши заглавными.** Как удобно — через подчёркивание или дефис. Примеры:

- `- HUB_STATUS`
- `- DISCORD_OOC`
- `- CHARACTER_DB_BACKUP`

---

## Хочешь дополнить чужую функцию

Не копируй её целиком к себе. Сделай так:

```dm
//ORIGINAL: code/modules/что-то/там.dm
/obj/item/gun/proc/shoot_live_shot(...)
    . = ..()                    // сначала оригинал
    // потом уже твоё
    if(muzzle_flash)
        spawn_sparks(src)
```

Путь к оригиналу укажи в `//ORIGINAL:`. Если функция полностью переписывается — тогда выноси её целиком в свой модуль и напиши в `readme.md` строчку `Moved to: modular_voidcrew/features/...`.

---

## Нестандартные случаи

**`interface/skin.dmf`** — там комментарии внутри строк не работают. Просто правь и напиши в `readme.md`, что менял.

**SQL** — маркеры те же, что в DM:

```sql
-- VOIDCREW EDIT ADDITION BEGIN - MY_THING
INSERT INTO ...
-- VOIDCREW EDIT ADDITION END
```

**TGUI (js/tsx)** — по месту:

```jsx
<Button icon="rat" // VOIDCREW EDIT ADDITION - MY_THING
/>
```

Или блоком:

```jsx
{/* VOIDCREW EDIT ADDITION BEGIN - MY_THING */}
<Something />
{/* VOIDCREW EDIT ADDITION END */}
```

**Новый TGUI-файл** — первой строкой:

```
// THIS IS A VOIDCREW UI FILE
```

---

## Чего делать не надо

- ❌ `git push --force` в `master` — сломаешь синк всем
- ❌ Трогать чужое без маркеров — потеряем при merge
- ❌ Пихать новые фичи прямо в `code/` — только в модуль
- ❌ Коммитить секреты (токены, пароли, `.env`)
- ❌ Лезть в чужой модуль — сделай свой с префиксом `master_`
- ❌ Пушить в `voidcrew/Voidcrew` — только PR в наш форк

---

## Как сделать PR

```bash
# 1. Форк и клон
git clone https://github.com/<твой-ник>/ruvoidcrew.git
cd ruvoidcrew
git remote add upstream https://github.com/lecarp/ruvoidcrew.git

# 2. Синк перед работой
git fetch upstream
git checkout master
git merge upstream/master

# 3. Ветка под задачу
git checkout -b feature/my_thing

# 4. Пишешь код, коммитишь
git add .
git commit -m "add my_thing"
git push -u origin feature/my_thing
```

Потом на GitHub — **Contribute → Open pull request** в `lecarp/ruvoidcrew`, базовая ветка `master`.

---

## Что примем, что нет

**Примем:**

- Фичу в модуле с `readme.md`
- Правки с маркерами
- Дополнение через `. = ..()`

**Попросим переделать:**

- Нет `readme.md`
- Нет маркеров там, где надо
- Модуль не подключён в `modular_voidcrew.dme`

**Не примем:**

- Force-push в `master`
- Правки `tgstation.dme` вне блока `// VOIDCREW EDIT ADDITION BEGIN - MODULAR`
- Изменения чужих модулей без обоснования

---

## Есть вопросы?

Создай issue, открой draft PR, или напиши напрямую. Лучше спросить заранее, чем потом переделывать.

# **Спасибо Artemchik542 за гайд на постмете, принцип был взят со здравым смыслом оттуда**

