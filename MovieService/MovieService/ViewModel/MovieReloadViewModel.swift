import UIKit
import RxSwift
import RxCocoa
import Alamofire

class LogInViewModel {
    let idObservable = PublishSubject<String>()
    let pwObservable = PublishSubject<String>()
}

