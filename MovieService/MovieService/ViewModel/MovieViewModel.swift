import Foundation
import RxSwift
import RxCocoa
import Alamofire

struct MovieInfoOut: Codable {
    let dailyBoxOfficeList: MovieInfoIn
}

struct MovieInfoIn: Codable {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
}

class MovieViewModel {
    
    private let key = "c16f104dccf7480daa4204c8f921d8b6"
    
    func loadView(url: String) -> Observable<Any> {
        let url =
        "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/dailyBoxOfficeList/searchDailyBoxOfficeList.json?key=\(key)&targetDt=20200726"
        return Observable<Any>.create( { observer in
            AF.request(url, method: .get).responseJSON { response in
                switch response.result {
                case .success(let json):
                    do {
                        let model = try JSONDecoder().decode(MovieInfoOut.self, from: json as! Data)
                        print(model)
                        observer.onNext(model)
                    } catch let error {
                        observer.onError(error)
                    }
                case .failure(let error): observer.onError(error) } } as! Disposable
        })
    }
}

class LogInViewModel {
    let idObservable = PublishSubject<String>()
    let pwObservable = PublishSubject<String>()
}
