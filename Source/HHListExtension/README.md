# Расширения для работы с UITableView/UICollectionView

1. Добавлена поддержка авторендеринга в ARCHTableViewController/ARCHCollectionViewController
2. Автоанимируемые списки с использованием стороней  библиотеки **DeepDiff**, для рассчета разницы коллекций 

## Установка

### Требования

- iOS 10.0+
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

1. Создай модель данных. В ней реализуй ``protocol Hashable``
2. Создай ячейку и вьюмодель для неё
3. Создай контроллер

```
let listController = ARCHDiffTableViewController<Data, CellViewModel, Cell>()

// Опционально
//listController.delegate = self
//listController.dataSource = self
```

4. Добавь UITableView/UICollectionView на экран:

```
let tableView = listController.tableView
tableView.frame = view.bounds
tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.addSubview(tableView)
```
5. Поддерживается авторендеринг, для ручного обновления используй:

```
listController.data = ...
```
