import Foundation
import RxSwift
import RxCocoa
import Alamofire

class MovieReloadViewModel {
    // 랭킹있고 이름있고 등등
    //movie/searchMovieList.json?keay=c16f104dccf7480daa4204c8f921d8b6
    
    private let disposeBag = DisposeBag()
    private let key = "c16f104dccf7480daa4204c8f921d8b6"
    
    func loadView(url: String) -> Observable<Result> {
        return Observable<Result>.create { observer in
            let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/" + url)!
            AF.request(url, method: .get).responseData { response in
                switch response.result {
                case .success(let json):
                    do {
                        let model = try? JSONDecoder().decode(Result.self, from: json)
                        observer.onNext(model!)
                    } catch let error {
                        print(error.localizedDescription)
                        observer.onError(error)
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

