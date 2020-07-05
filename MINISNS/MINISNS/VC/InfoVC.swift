import UIKit
import Alamofire

// MARK: InfoVC

class InfoVC: UIViewController {
    
    var indexInt: Int!
    
    @IBOutlet weak var goToMain: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AF.request("", method: .post, parameters: ["index":indexInt]).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200:
                let object = response.value as? [String:Any]
                let imageValue = object?[""] as? UIImage
                let titleValue = object?[""] as? String
                let textValue = object?[""] as? String
                self.imageView.image = imageValue
                self.textView.text = textValue
                self.titleLbl.text = titleValue
            case 403:
                self.presentAlert(title: "실패", message: "토큰 에러")
                DispatchQueue.global().async {
                    self.presentVC(identifier: "MainVC")
                }
            case 500:
                self.presentAlert(title: "에러", message: "에러 발생")
                DispatchQueue.global().async {
                    self.presentVC(identifier: "MainVC")
                }
            default:
                return
            }
        }
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        self.presentVC(identifier: "MainVC")
    }
}
