import RxSwift
import RxCocoa
import Alamofire
import UIKit

protocol APIRequest {
    var path: String { get }
    var parameters: [String : String] { get }
}

enum APIUrl: String {
    case kobis = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    case naver = "https://openapi.naver.com/v1/search/movie.json?"
}

extension APIRequest {
    func request(type: APIUrl) -> URLRequest {
        guard let baseUrl = URL(string: type.rawValue) else { fatalError() }
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if type == .naver {
            let fieldName: String = "NMFClientId"
            let fieldPw: String = "NMFClientToken"
            if let key:String = Bundle.main.infoDictionary?[fieldName] as? String {
                request.addValue(key, forHTTPHeaderField: "WYEHk52XgGzcKcz3tPME")
            }
            if let pw: String = Bundle.main.infoDictionary?[fieldPw] as? String {
                request.addValue(pw, forHTTPHeaderField: "C2asfzQ7jY")
            }
        }
        return request
    }
}

class APIService {
    func loadMovie<T: Codable>(apiRequest: APIRequest, url: APIUrl = .kobis) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(type: url)
            let dataRequest = AF.request(request).responseData{ response in
                switch response.result {
                case .success(let data) :
                    do {
                        let model : T = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(model)
                    } catch let error {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}

//self.searchBar.rx.text.orEmpty
//            .asObservable()
//            .map { $0.lowercased() }
//            .map { SearchMovieRequest(query: $0) }
//            .flatMap { request -> Observable<[SearchMovieInfo]> in
////                return self.apiService.get(apiRequest: request, headers: ["Content-Type" : "application/json","":""], url: url.naver)
//                return self.apiService.loadMovie(apiRequest: request, url: .naver)
//        }
//        .bind(to: tableView.rx.items(cellIdentifier: "searchCell")) { index, model, cell in
//            cell.textLabel?.text = model.title
//        }
//        .disposed(by: disposeBag)
//    }
//}

/*
 class SearchMovieRequest: APIRequest {
     var path = ""
     var parameters = [String : String]()
     
     init(query: String) {
         let newQuery = query.data(using: .utf8)
         parameters["query"] = query
     }
 }
 */
