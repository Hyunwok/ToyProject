import UIKit
import Alamofire

// MARK: FindVC

class FindVC: UIViewController {
    
    let netWork = Network()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var findEmailTextField: UITextField!
    @IBOutlet weak var findIdPwBtn: UIButton!
    @IBOutlet weak var setIdPwSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findEmailTextField.isHidden = true
    }
    
    @IBAction func changeIdPwView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            findEmailTextField.isHidden = true
            let param = ["name":nameTextField!.text, "phone":phoneNumberTextField!.text]
        //    netWork.post(endPoint: "/find", param: param)
        default:
            findEmailTextField.isHidden = false
            let param = ["email":findEmailTextField!.text, "name":nameTextField!.text, "phone":phoneNumberTextField!.text]
      //      let status = netWork.post(endPoint: "/find", param: param)
            
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



