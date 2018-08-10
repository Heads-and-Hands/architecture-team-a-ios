# Контроллер для работы со списками

Упрощает работу над списками состоящими из одной секции и одного типа ячейки.
Изменения данных вычисляется через сторонюю библиотеку **DeepDiff**

### Готовые реализации

- **ARCHTableViewController**
- **ARCHCollectionViewController**

## Установка

### Требования

- iOS 11.0+
- Swift 4.1
- Xcode 9

### [Carthage](https://github.com/Carthage/Carthage)

Чтобы интегрировать HHKit пропишите в `Cartfile`:

```
github "Heads-and-Hands/architecture-team-a-ios"
```

Запусить команду `carthage update --platform ios` и перетащите
`HHListExtension.framework` и `DeepDiff.framework`  в Xcode проект.

## Использование

1. Создай объект

```
let listController = ARCHTableViewController<Data, CellViewModel, Cell>()

// Опционально
//listController.delegate = self
//listController.dataSource = self
```

2. Добавь объект на экран:

```
addChildViewController(listController)
listController.view.frame = view.bounds
listController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.addSubview(listController.view)
listController.didMove(toParentViewController: self)
```
3. Обновление данных:

```
listController.data = ...
```
