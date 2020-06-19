import UIKit
import Alamofire

class Network {

    fileprivate var baseUrl = "10.156.145.141:3000"
    
    func post(endPoint: String, param: [String:String?]) {
        let header: HTTPHeaders = ["Content-Type":"application/json"]
        AF.request(self.baseUrl + endPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print(response)
            print(1)
        }
    }
    
    func get(endPont: String) {
        AF.request(endPont, method: .get,encoding: URLEncoding.default).response { (data) in
            guard let cleanData = data.data else { return }
            do {
                let json = try JSONDecoder().decode([FindIdModel].self, from: cleanData)
                print(json)
            } catch {
                print(error)
    
            }
        }
    }
}

