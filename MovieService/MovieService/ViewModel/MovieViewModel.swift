import Foundation
import RxSwift
import RxCocoa
import Alamofire

class MovieViewModel {
    func loadView() -> Observable<Any> {
        let key = "c16f104dccf7480daa4204c8f921d8b6"
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(Date())"
        return Observable<Any>.create( { observer in
            AF.request(url, method: .get).responseJSON { response in
                switch response.response?.statusCode {
                case 200: return observer.onNext(1)
                case 400, 500: return observer.onError(response.error as! Error)
                default: return observer.onError(response.error as! Error)
                }
                observer.onCompleted()
                } as! Disposable
        })
    }
}

class LogInViewModel {
    let idObservable = PublishSubject<String>()
    let pwObservable = PublishSubject<String>()
    
    
}
