import UIKit
import Alamofire

// MARK: RegisterVC

class RegisterVC: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newWork = Network(baseUrl: "10.156.145.141:3000")
        newWork.post(endPoint: "/register")
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        
        let url = "10.156.145.141:3000"
        let param : Parameters = ["id":nameTextField.text!,
                                 "num":phoneNumberTextField.text!,
                                 "email":emailTextField.text!,
                                 "pw":pwTextField.text!
                                ]
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON {(response) in
            if let error = response.value.
            if let status = response.response?.statusCode {
//                switch status {
//                case <#pattern#>:
//                    <#code#>
//                default:
//                    <#code#>
//                }
            }
        }
    }
}
