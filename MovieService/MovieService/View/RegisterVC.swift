import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getRegister(_ sender: Any) {
        Auth.auth().createUser(withEmail: idTextField.text!,
                               password: pwTextField.text!) { authResult, error in
                                guard let _ = authResult?.user, error == nil else {
                                    self.presentAlert(title: "회원가입 실패", message: "에러가 있습니다.")
                                    return
                                }
                                self.presentVC(identifier: "")
        }
    }
}
