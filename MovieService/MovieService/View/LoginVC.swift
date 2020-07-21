import UIKit
import Firebase
import RxSwift
import RxAlamofire

class LoginVC: UIViewController {
    
    let viewModel = LogInViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var logInIdTextField: UITextField!
    @IBOutlet weak var logInPwTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInIdTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.idObservable).disposed(by: disposeBag)
        logInPwTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.idObservable).disposed(by: disposeBag)
        
    }
    
    
    @IBAction func getLogin(_ sender: UIButton) {
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
