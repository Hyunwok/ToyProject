//
//  APIService.swift
//  MovieService
//
//  Created by 이현욱 on 2020/07/31.
//  Copyright © 2020 이현욱. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire

protocol APIRequest {
    var method: String { get }
    var path: String { get }
    var parameter: [String:Any] { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        var request : URLRequest = {
            var request = URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.get.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            return request
        }()
        return request
    }
}

class APIService {
    func loadView<T: Codable>(url: String) -> Observable<T> {
        let baseURL:URL = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice")!
        
        return Observable<T>.create { observer in
            let url = URL(string: "/rest/boxoffice/searchDailyBoxOfficeList.json?key=430156241533f1d058c603178cc3ca0e&targetDt=20120101")!
           // let newUrl = URL(string: url)
             AF.request(url, method: .get).responseData { response in
                switch response.result {
                case .success(let json):
                    do {
                        let model = try? JSONDecoder().decode(T.self, from: json)
                        observer.onNext(model!)
                    } catch let error {
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
