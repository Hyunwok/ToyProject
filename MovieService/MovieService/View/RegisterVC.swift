import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var getBackToLoginVC: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getBackToLoginVC(_ sender: Any) {
        self.presentVC(identifier: "LoginVC")
    }
    
    @IBAction func getRegister(_ sender: Any) {
        Auth.auth().createUser(withEmail: idTextField.text!,
                               password: pwTextField.text!) { authResult, error in
                                guard let _ = authResult?.user, error == nil else {
                                    self.presentAlert(title: "회원가입 실패", message: "에러가 있습니다.")
                                    return
                                }
                                self.presentAlert(title: "회원가입 성공", message: "축하합니다!")
                                DispatchQueue.global().async {
                                    self.presentVC(identifier: "LoginVC")
                                }
        }
    }
}
