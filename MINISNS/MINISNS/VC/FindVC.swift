import UIKit
import Alamofire

// MARK: FindVC

class FindVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var findEmailTextField: UITextField!
    @IBOutlet weak var findIdPwBtn: UIButton!
    @IBOutlet weak var setIdPwSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        findEmailTextField.isHidden = true
    }
    
    @IBAction func changeIdPwView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            findEmailTextField.isHidden = true
            let param = ["name":nameTextField!.text, "phone":phoneNumberTextField!.text]
    //        AF.request(netWork, method: <#T##HTTPMethod#>, parameters: <#T##Encodable?#>, encoder: <#T##ParameterEncoder#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
        default:
            findEmailTextField.isHidden = false
            let param = ["email":findEmailTextField!.text, "name":nameTextField!.text, "phone":phoneNumberTextField!.text]
        }
    }
}

extension FindVC {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



