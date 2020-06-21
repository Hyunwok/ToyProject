import UIKit
import Alamofire

// MARK: LoginVC

class LoginVC: UIViewController {
    
    var autoLogin : Bool!
    let ud = UserDefaults.standard
    let netWork = Network()

    @IBOutlet weak var idTextField: UITextField!
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
    
    @IBAction func logIn(_ sender: UIButton) {
        if idTextField.text!.isEmpty || pwTextField.text!.isEmpty {
            presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비었습니다.")
            return
        } else {
      //      netWork.post(endPoint: "/logIn", param: ["id":idTextField.text,"passwd":pwTextField.text] )
        }
    }
    
    @IBAction func autoLogin(_ sender: UIButton) { // textField 값 없으면 체크 안되게
        if sender.isSelected == true {
            ud.set(idTextField.text, forKey: "id")
            ud.set(pwTextField.text, forKey: "pw")
        } else {
            ud.removeObject(forKey: "id")
            ud.removeObject(forKey: "pw")
        }
        sender.isSelected = !sender.isSelected
    }
}

// MARK: Extension

extension LoginVC : UITextFieldDelegate {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func presentVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "MainVC") as? MainVC else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
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

