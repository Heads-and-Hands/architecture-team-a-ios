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

Для интеграции **HHListExtension** пропиши в `Cartfile`:

```
github "Heads-and-Hands/architecture-team-a-ios"
```

Запусти команду `carthage update --platform ios`. Добавь в проект:

- `HHListExtension.framework`
- `HHList.framework`
- `DeepDiff.framework`

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
