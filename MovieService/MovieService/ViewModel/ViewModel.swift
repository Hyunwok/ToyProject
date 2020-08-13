import UIKit
import RxSwift
import RxCocoa

class RegisterViewModel {
    let emailObservable = PublishSubject<String>()
    let pwObservable = PublishSubject<String>()
}

