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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        
        if nameTextField.text!.isEmpty ||
            phoneNumberTextField.text!.isEmpty ||
            emailTextField.text!.isEmpty ||
            pwTextField.text!.isEmpty {
            self.presentAlert(title: "에러", message: "채우지 않은 공간이 있습니다.")
            return
        }
        
         let param : Parameters = [
             "name":nameTextField!.text!,
             "email":emailTextField!.text!,
             "password":pwTextField!.text!,
             "phone":phoneNumberTextField!.text!
        ]
        
        let url = "http://10.156.145.141:3000/register"
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            if let error = response.error { print(error); return }
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    self.presentAlert(title: "회원가입 성공", message: "회원가입에 성공하셨습니다.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                case 409: self.presentAlert(title: "회원가입 실패", message: "아이디가 있거나 형식에 맞지 않습니다")
                default: return 
                }
            }
        }
    }
}

//MARK: extension

extension RegisterVC: UITextFieldDelegate {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillDisa(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
