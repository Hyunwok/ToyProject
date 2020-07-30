import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MovieReloadViewModel {
    
    private let disposeBag = DisposeBag()
    private let key = "c16f104dccf7480daa4204c8f921d8b6"
    
    func loadView(url: String) -> Observable<Result> {
        
        return Observable<Result>.create { observer in
            let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=430156241533f1d058c603178cc3ca0e&targetDt=20120101")!
              //  http://www.kobis.or.kr/kobisopenapi/webservice/rest/" + newUrl)!
            AF.request(url, method: .get)
                .responseData { response in
                print(response.result)
                switch response.result {
                case .success(let json):
                    print(json)
                    do {
                        let model = try? JSONDecoder().decode(Result.self, from: json)
                        observer.
                        single(.success(model!))
                        print(model)
                    } catch let error {
                        print(error.localizedDescription)
                        single(.error(let error))
                    }
                case .failure(let error) :
                    print(error.localizedDescription)
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                AF.cancelAllRequests()
            }
        }
    }
}

class LogInViewModel {
    let idObservable = PublishSubject<String>()
    let pwObservable = PublishSubject<String>()
}

