# Скрип для быстрого разворачивания проекта



## Использование

- Загрузить [bootstrap.sh](https://github.com/Heads-and-Hands/architecture-team-a-ios/blob/feature/script/Scripts/bootstrap.sh).
- Выполнить ````. bootstrap.sh [<app_name>] [<repo_path>]````, где **app_name** имя создаваемого приложения (по умолчанию **newappname**), **repo_path** - имя удаленного репозитория создаваемого проекта.

В процессе выполнения скрипт создаст папку с проектом.

## Выполнение

В процессе выполнения скрипт произоводит следующие действия:
1. Проверяет наличие необходимых зависимостей.
2. Загружает шаблон проекта из [репозитория](https://github.com/Heads-and-Hands/template-project-ios.git).
3. При помощи утилит **ack** и **replace**, производит переименования файлов и их содержимого. Шаблоном для переименования служит имя файла **<file_name>.xcodeproj**.
4. Вызывает **bundler update**
5. Устанавливает **swiftlint** (**mint run realm/swiftlint**). Создает **Mintfile**.
6. Производит кофигурацию **fastlane**. Перед выполнением **fastlane produce**, устанавливаются значения переменных средц окружения **PRODUCE_USERNAME="handh.ci@gmail.com"**, **PRODUCE_APP_IDENTIFIRE="ru.handh.<app_name>}"**. Конфигурационные файлы находятся в директории **.fastlane** и наследуются от шаблона проекта.
7. вызываются команды **fastlane match appstore** и **fastlane match develop**.
8. Производится настройка репозитория **git** и **git-flow**. Настраивается удаленный репозиторий, если указано значение **<repo_path>**.
9. Загружаются файлы шаблонов **XCode** из [репозитория](https://github.com/Heads-and-Hands/architecture-team-a-ios.git).
10. Производится установка полученных шаблонов в дирректорию шаблонов XCode. 

## Зависомости

Требуется наличие: **bundler**, **brew**, **subversion**, **ack**, **replace**, **mint**, **carthage**, **swiftgen**, **swiftlint**, **git**, **git-flow**, **fastlane**, **danger**.




