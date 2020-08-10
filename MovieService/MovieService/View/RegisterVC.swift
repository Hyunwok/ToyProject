import UIKit
import FirebaseAuth
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func getRegister(_ sender: Any) {
        Auth.auth().createUser(withEmail: idTextField.text!,
                               password: pwTextField.text!) { authResult, error in
                                guard let _ = authResult?.user, error == nil else {
                                    self.presentAlert(title: "회원가입 실패", message: "에러가 있습니다.")
                                    return
                                }
                                self.presentAlert(title: "회원가입 성공", message: "축하합니다!")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.navigationController?.popViewController(animated: true)
                                }
        }
    }
}
