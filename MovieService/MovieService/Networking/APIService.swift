import UIKit

import RxSwift
import RxCocoa
import Alamofire
import Security

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
        let str: [String] = parameters.map {
            return $0 + $1
        }
        guard let baseUrl = URL(string: type.rawValue + path + str.first!) else { fatalError() }
        guard let components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
//        components.queryItems = parameters.map {
//            URLQueryItem(name: $0, value: $1)
        
//          이거 오류에 대한 해결책 알아보기
//        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        let request = URLRequest(url: url)
        
        return request
    }
}

class APIService {
    static let shared = APIService()
    
    func loadMovie<T: Codable>(apiRequest: APIRequest, url: APIUrl = .kobis) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(type: url)

            let dataRequest = AF.request(request).responseData{ response in
                switch response.result {
                case .success(let data) :
                    debugPrint(response)
                    do {
                        let model: T = try JSONDecoder().decode(T.self, from: data) 
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

enum Header {
    case naver, kobis
    func getHeader() -> [String : String]? {
        switch self {
        case .naver:
            return ["NMFClientId" : "WYEHk52XgGzcKcz3tPME",
                    "X-Naver-Client-Secret": "C2asfzQ7jY",
                    "Content-Type" : "application/json"]
        case .kobis :
            return ["Content-Type" : "application/json"]
        }
    }
}
