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
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        
        let url = "https://jsonplaceholder.typicode.com/todosx"
//
//        "email":emailTextField.text!,
//          "phone":phoneNumberTextField.text!,
//          "password":pwTextField.text!
        
        let param : Parameters = [
                                    "userId":nameTextField.text!,
                                    "id":emailTextField.text!,
                                    "title":pwTextField.text!,
                                    "completed":true
            
        ]
        
//        if nameTextField.text!.isEmpty ||
//            phoneNumberTextField.text!.isEmpty ||
//            emailTextField.text!.isEmpty ||
//            pwTextField.text!.isEmpty {
//            self.presentAlert(title: "에러", message: "채우지 않은 공간이 있습니다.")
//            return
//        }
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in 
            if let value = response.value as? [String:Any] {
                print(value)
            } else {
                print("실패")
            }
            if let status = response.response?.statusCode {
                switch status {
                case 201:
                    self.presentAlert(title: "회원가입 성공", message: "회원가입에 성공하셨습니다.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popViewController(animated: true)
                    }
                case 204: self.presentAlert(title: "회원가입 실패", message: "아이디가 있거나 형식에 맞지 않습니다")
                case 205: self.presentAlert(title: "회원가입 실패", message: "아이디가 있거나 형식에 맞지 않습니다")
                default:
                    print(1)
                    return
                }
            }
        }
    }
}

extension RegisterVC {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert,animated: true)
    }
}
