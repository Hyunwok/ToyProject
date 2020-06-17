import UIKit
import Alamofire

class Network {

    fileprivate var baseUrl = ""
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func post(endPoint: String) {
        AF.request(baseUrl + endPoint, method: .post).validate()
    }
   
}

