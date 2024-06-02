# Symfony Project Boilerplate

## Обзор
Этот шаблон для Symfony разработан с двумя основными целями:

1. **Создание базовой среды для разработки на Symfony:** Шаблон не является универсальным решением, и предполагает,
что разработчик может самостоятельно добавлять, удалять или настраивать сервисы по мере необходимости, 
то есть требует базового понимания Docker.
2. **Упрощение работы с командами:** Шаблон включает Makefile для быстрого доступа к наиболее часто используемым командам 
разработки Symfony, позволяя выполнять их без предварительного входа в PHP контейнер. Эти алиасы могут быть легко
адаптированы или расширены в соответствии с особенностями конкретного проекта.

## Системные требования
Шаблон предназначен для использования на системах Linux или WSL (Windows Subsystem for Linux). 
Для работы необходим установленный пакет make. Команда для установки на Ubuntu:
```
sudo apt install make
```

Также необходим установленный git с заданным именем пользователя и email, они используются Symfony при создании
нового проекта.

## Состав шаблона
- PHP: версия 8.3
- Symfony: текушая версия
- MySQL: версия 8.3
- PostgreSQL: версия 16.2

## Инициализация нового проекта
* Клонируйте репозиторий в новую директорию с помощью команды:
```
git clone https://github.com/A-Nikolaefff/symfony-project-boilerplate.git YOUR_PROJECT_NAME
```
* В директории проекта выполните команду для инициализации нового Symfony проекта:
Для инициалиации базового Symfony приложения (API, микросервиса или CLI) выполните:
```
make init
```
Для инициалиации веб Symfony приложения выполните:
```
make init-web
```

## Make команды
Полный список команд доступен с помощью команды ```make help``` или в самом Makefile в корне проекта. Примеры команд:

* ```make init``` - инициализация нового проекта Symfony
* ```make up``` - запуск контейнеров
* ```make php``` - зайти в контейнер php (запустить bash терминал)
* ```make debug``` - отладка консольной команды
* ```make migrate``` - запуск миграций базы данных
* ```make entity``` - создать новую сущность Doctrine ORM

## Настройка Xdebug в PHPStorm

* **Имя сервера:** localhost
* **Хост**: localhost
* **Порт**: 80
* **Path Mapping:** настроить сопоставление корневой директории проекта с путем /var/www/.
