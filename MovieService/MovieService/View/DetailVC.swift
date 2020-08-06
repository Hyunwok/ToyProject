import UIKit

class DetailVC: UIViewController {

    var item:List?
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var movieNm: UILabel!
    @IBOutlet weak var audiuenceCnt: UILabel!
    @IBOutlet weak var openDt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        audiuenceCnt.text = item?.audiAcc
        rank.text = item?.rank
        openDt.text = item?.openDt
        movieNm.text = item?.movieNm
    }
}
