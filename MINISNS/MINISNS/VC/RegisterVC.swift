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
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        
        var param = ["id":nameTextField.text!,
                     "num":phoneNumberTextField.text!,
                     "email":emailTextField.text!,
                     "pw":pwTextField.text!
        ]
        
        var url = "10.156.145.141:3000/register"
        
        AF.request(url, method: .post, parameters: param as! Parameters, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON {(response) in
            
                switch response. {
                case <#pattern#>:
                    <#code#>
                default:
                    <#code#>
                }
            }
        }
    }
    
    
}
