import UIKit
import Alamofire

// MARK: LoginVC

class LoginVC: UIViewController {

    let ud = UserDefaults.standard

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var findIdBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func findIdOrPw(_ sender: UIButton) {
        self.presentVC(identifier: "FindVC")
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        self.presentVC(identifier: "RegisterVC")
    }
    
    @IBAction func autoLogin(_ sender: UIButton) { // textField 값 없으면 체크 안되게
        if sender.isSelected == true {
            ud.set(userNameTextField.text, forKey: "id")
            ud.set(pwTextField.text, forKey: "pw")
        } else {
            ud.removeObject(forKey: "id")
            ud.removeObject(forKey: "pw")
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        if userNameTextField.text!.isEmpty || pwTextField.text!.isEmpty {
            presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비었습니다.")
            return
        } else {
            let url = "http://10.156.145.141:3000/login"
            let param = ["email":userNameTextField!.text!, "password":pwTextField!.text!]
            let header : HTTPHeaders = ["Content-Type":"application/json"]
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                guard let value = response.value as? [String:Any] else { return }
                guard let token = value["access_token"] as? String else { return }
                self.ud.set(token, forKey: "token")
                let status = response.response?.statusCode
                switch status {
                case 200 : self.presentAlert(title: "성공!", message: "로그인 성공!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.presentVC(identifier:"MainVC")
                    }
                case 404 : self.presentAlert(title: "실패", message: "존재하지 않는 유저")
                case 500 : self.presentAlert(title: "에러", message: "에러 발생")
                default : return
                }
            }
        }
    }
}


// MARK: Extension

extension LoginVC : UITextFieldDelegate {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func presentVC(identifier:String) {
        guard let vc = storyboard?.instantiateViewController(identifier: "\(identifier)") else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
