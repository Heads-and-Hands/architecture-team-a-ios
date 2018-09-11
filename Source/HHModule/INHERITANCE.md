# Наследование модуля

Выделение общей логики модулей приложения может быть реализовано на основе наследования. При этом родительский модуль объявляется в виду универсального шаблона, а наследование состояния может осуществляеться на уровне протокола состояния родительского модуля **ParentModuleStateProtocol**.

````
protocol ParentModuleStateProtocol: ARCHState {
var parentPrimitiveState: ParentViewState { get set }
}
````

В объявлении классов **ParentModuleEventHandler** и **ParentModuleViewController** указывается универсальный тип **S** ограниченный протоколом состояния родительского модуля **ParentModuleStateProtocol** 

````
class ParentModuleEventHandler<S: ParentModuleStateProtocol>: ARCHEventHandler<S>, ParentModuleViewOutput, ParentModuleInput {
}
````

````
class ParentModuleViewController<Out: ParentModuleViewOutput, S: ParentModuleStateProtocol>: ARCHViewController<S, Out> {
}
````

Так невозможно переопределить свойство **moduleOutput** родительского класса **ParentModuleEventHandler**, в объявлении класса предлагается описать данное свойство как вычисляемое открытое и в определении дочернего класса производит переопределение с приведением к нужному типу. 

````
private weak var internalModuleOutput: ParentModuleOutput?
open var moduleOutput: AnyObject? {
set {
internalModuleOutput = newValue as? ParentModuleOutput
}
get {
return internalModuleOutput
}
}
````

Компоненты дочернего модуля **ChildModuleEventHandler**, **ChildModuleViewController** наследуются от соответствующих компонентов родительского модуля.

````
final class ChildModuleViewController: ParentModuleViewController<ChildModuleEventHandler, ChildModuleState> {    
}
````

````
final class ChildModuleEventHandler: ParentModuleEventHandler<ChildModuleState>, ChildModuleViewOutput, ChildModuleInput {
}
````

**ChildModuleState** дочернего модуль реализует протокол состояния родительского модуля.

````
struct ChildModuleState: ParentModuleStateProtocol {

var parentPrimitiveState: ParentViewState = ParentViewState(text: "")
var childPrimitiveState: ChildViewState = ChildViewState(text: "")
}
````

Протоколы **ChildModuleViewOutput**, **ChildModuleViewInput**, **ChildModuleInput**, **ChildModuleOutput** наследуются от протоколов родительского модуля.

````
protocol ChildModuleViewOutput: ParentModuleViewOutput {
}

protocol ChildModuleInput: ParentModuleInput {
}

protocol ChildModuleOutput: ParentModuleOutput {
}
````
