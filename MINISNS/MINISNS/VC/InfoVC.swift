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
        AF.download("", method: .get, headers: ["":""]).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200: print(1)
            case 300: print(2)
                case 500: print(2)
            default: return
            }
            let json = response[""] as? UIImage
            
            imageView.image =
            textView.text =
            titleLbl.text =
        }
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "MainVC") else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
