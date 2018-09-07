# Препроцессинг состояния модуля

Мы хотим при редактировании одного свойства, сразу обновлять другие свойства.
Например, пришли данные от сервера, нужно сбросить данные индикации.

По дефолту, обновление нескольких свойств нужно оборачивать в клажуру, чтобы во вью ушло одной транзакцией:

````
updateState {
    state.indication = nil
    state.list = newData
}
````

Хотим:

````
state.list = newData
````

Для реализации нужно сформировать правила предобработки стейта перед отправкой на отрисовку. Для этого у ``ARCHEventHandler`` есть свойство ``var stateHandler: ARCHStateHandler<State>?``

## Пример:

Когда мы обновляем поле **list** сбрасывается поле **indication**, и наоборот.

````
ARCHStateHandler<IndicationDemoState>(block: { old, new -> IndicationDemoState? in
    var buffer = new

    if old.list?.isEmpty ?? true && !(new.list?.isEmpty ?? true) {
        buffer.indication = nil
    }

    if old.indication == nil && new.indication != nil {
        buffer.list = nil
    }

    return buffer
})
````

## Преимущества:

- уменьшить кол-во кода
- убирается дублирование кода
- *[Опционально]* данные хендлеры можно покрывать тестами
