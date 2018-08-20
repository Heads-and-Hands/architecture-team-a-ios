# Мультиделегирование

Паттерн **Делегат** подразумевает связь 1 к 1, но иногда требуется подключить несколько объектов. Например, менеджер для пагинаци и обработка прокрутки для хедера.

Для решения используйте цепочку делегатов. Каждое звено цепи реализует нужные ему методы протокола, и вызывает аналогичный метод у следующего звена. 

````
weak var delegate: UITableViewDelegate?

func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // Some logic
    delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
}
````

Для нереализованных методов используйте возможности ``NSObject``, а именно пересылка вызова в нужный объект:

````
override open func responds(to aSelector: Selector!) -> Bool {
    if super.responds(to: aSelector) {
        return true
    }

    return delegate?.responds(to: aSelector) ?? false
}

override open func forwardingTarget(for aSelector: Selector!) -> Any? {
    if let delegate = delegate, delegate.responds(to: aSelector) {
        return delegate
        }

    return super.forwardingTarget(for: aSelector)
    }
}
````

## Внимание

Стандартные вьюхи в момент установки делегата, проверяют какие методы протокола были реализованны. Поэтому сначала настройте всю цепочку делегатов, только после этого устанавливайте её во вью.

Если вам нужно в рантайме отредактировать цепочку (добавить/удалить звено), используйте подобный код:

````
<Some View>.delegate = nil
// Код редактирования цепочку
<Some View>.delegate = <first item>
````
