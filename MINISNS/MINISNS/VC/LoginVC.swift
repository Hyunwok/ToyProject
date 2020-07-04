import UIKit
import Alamofire

// MARK: LoginVC

class LoginVC: WriteVC {
    
    private let ud = UserDefaults.standard
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var findIdBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let url = "http://10.156.145.141:3000/user/login"
            let param = ["email":userNameTextField!.text!, "password":pwTextField!.text!]
            let header : HTTPHeaders = ["Content-Type":"application/json"]
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                guard let value = response.value as? [String:Any] else { return }
                guard let token = value["access_token"] as? String else { return }
                self.ud.set(token, forKey: "token")
                let status = response.response?.statusCode
                switch status {
                case 200 :self.presentVC(identifier: "MainVC")
                case 404 : self.presentAlert(title: "실패", message: "존재하지 않는 유저")
                case 500 : self.presentAlert(title: "에러", message: "에러 발생")
                default : return
                }
            }
        }
    }
}
