import RxSwift
import RxCocoa
import Alamofire
import UIKit

protocol APIRequest {
    var path: String { get }
    var parameters: [String : String] { get }
}

enum APIUrl: String {
    case kobis = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=asdasdasd"
    case naver = " "
}

extension APIRequest {
    func request(with baseURL: URL, type: APIUrl) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
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

class ChartMovieRequest: APIRequest {
    var path = ""
    var parameters = [String : String]()
    
    init(date: String) {
        parameters["targetDt"] = date
    }
}

class SearchMovieRequest: APIRequest {
    var path = "String"
    var parameters = [String : String]()
    
    init(query: String) {
        parameters["query"] = query
    }
}


class ApiService {
    func get<T: Codable>(apiRequest: APIRequest, url: APIUrl = .kobis) -> Observable<T> {
        //url 수정 
        return Observable<T>.create { observer in
            let baseURL = URL(string: url.rawValue)!
            let request = apiRequest.request(with: baseURL, type: url)
            
            let dataRequest = AF.request(request).responseData{
                response in
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

