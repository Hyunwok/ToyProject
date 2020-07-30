import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MainPageVC: UIViewController {
    
    private let key = "430156241533f1d058c603178cc3ca0e"
    let viewModel = MovieReloadViewModel()
    
    var movieName: String!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        viewModel.loadView(url: "").subscribe(onNext: { emitter in
            tableView.rx.items(cellIdentifier: "MyCell", cellType: MovieTableCell.self) { index, movie, cell in
                if let cellToUse = cell { cellToUse.  }
                cellToUse.text
            }
        })
    }
}



