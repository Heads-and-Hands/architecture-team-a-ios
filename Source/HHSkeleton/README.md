# [Скелетная загрузка](https://github.com/gonzalonunez/Skeleton)

## Состав фреймворка

### ARCHSkeletonView

Протокол описывающий поведение вьюхи при скелетной загрузки

### ARCHSkeletonViewProvider

Класс ответствененный за формирование вьюхи для скелетной загрузки.
Объекту передаются скелетные вьюхи, из которых извлекаются контуры подвьюх.
Которые склеиваются в маску.

### ARCHSkeletonTableViewController / ARCHSkeletonCollectionViewController

Прослойка для поддержки скелетона в списках

## Установка

### Требования

- iOS 10.0+
- Swift 4.1
- Xcode 9

### [Carthage](https://github.com/Carthage/Carthage)

Для интеграции **HHSkeleton** пропиши в `Cartfile`:

```
github "Heads-and-Hands/architecture-team-a-ios"
```

Запусти команду `carthage update --platform ios`.  Добавь в проект:
- `HHModule.framework` 
- `HHIndication.framework`
- `Skeleton.framework`

## Использование

1. *[Один раз]* Реализуй протокол ``ARCHSkeletonView`` для вьюх:

- UILabel 
- UIImageView и т.д.

Настрой вьюхи под свой проект - данные, скругления и т.д. 
Если не сделать просто будет браться контур по фрейму, если он не нулевой

````
extension UILabel: ARCHSkeletonView {

    public func set(isEnableSkeleton: Bool) {
        if isEnableSkeleton {
            text = "ARCHSkeletonView ARCHSkeletonView ARCHSkeletonView"
        }
    }

    public func contours(on rootView: UIView) -> [UIBezierPath] {
        let frame = rootView.convert(bounds, from: self)
        let cornerRadius: CGFloat = 3.0
        let path = UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius)
        return [path]
    }
}
````

2. Для кастомных вьюх так же реализуй протокол ``ARCHSkeletonView``:

````
var skeletonSubviews: [UIView]? {
    return [imageView, titleLabel, detailLabel]
}
````

3. Для конкретного экрана настрой ``ARCHSkeletonViewProvider``:

- передай все скелетные вьюхи
- укажи цвет градиента
- укажи направление анимации

4. Передай экземляр ``ARCHSkeletonViewProvider`` в ``IndicationHelper``
