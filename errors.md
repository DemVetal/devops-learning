# Журнал ошибок

## Шаблон
- Ошибка:
- Когда:
- Причина:
- Решение:

---

## git status не видит изменения
- Ошибка: после правки файла git status пишет, что изменений нет
- Когда: Модуль 0, создание конспектов
- Причина: файл не сохранён в VS Code (белая точка ● на вкладке)
- Решение: Ctrl+S, затем снова git status

## Permission denied при ls /root
- Ошибка: `ls: cannot open directory '/root': Permission denied`
- Когда: Занятие 1, задание 5
- Причина: /root — папка администратора, права drwx------ (доступ только у root)
- Решение: `sudo ls -la /root` — выполнить одну команду с правами root

## No such file or directory: /ETC
- Ошибка: `bash: cd: /ETC: No such file or directory`
- Когда: Занятие 1, задание 7
- Причина: в Linux важен регистр букв, /ETC и /etc — разные пути
- Решение: `cd /etc`; использовать Tab для автодополнения

## No such file or directory: /procmeminfo
- Ошибка: `ls: cannot access '/procmeminfo': No such file or directory`
- Когда: Занятие 1, мини-практика /proc
- Причина: опечатка — пропущен `/` между proc и meminfo
- Решение: `ls -l /proc/meminfo`; набирать путь через Tab

## Не ошибка: сообщения snapd при apt upgrade
- Сообщение: `snapd.failure.service is a disabled or a static unit not running, not starting it`
- Когда: Модуль 0, обновление системы
- Причина: apt сообщает, что служба выключена и перезапускать её не нужно
- Вывод: настоящие ошибки содержат `E:`, `Error`, `Failed`; информационные сообщения — нет