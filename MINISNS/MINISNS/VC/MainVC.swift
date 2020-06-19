import UIKit

// MARK: MainVC

class MainVC: UIViewController {

    let netWork = Network()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkToken()
        netWork.get(endPont: "https://jsonplaceholder.typicode.com/posts/1")
    }

    func checkToken() {
        
    }
    

}

