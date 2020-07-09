import UIKit
import WebKit

//MARK: WebVC

class WebVC: UIViewController  {
    
    @IBOutlet weak var web: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.youtube.com/") else { return }
        let request = URLRequest(url: url)
        web.load(request)
    }

}

