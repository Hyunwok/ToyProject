import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MainPageVC: UIViewController {
    
    private let key = "430156241533f1d058c603178cc3ca0e"
    let viewModel = MovieViewModel()
    //    let movieArray = [MovieInfoOut]()
    var movieName: String!
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observable = viewModel.loadView(url: "boxoffice/searchDailyBoxOfficeList.json?key=\(self.key)&targetDt=20120101").bind(to)
        observable.bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { _, movie, cell in
            if let cellToUse = cell as? MovieTableCell {
                cellToUse.movieName.text = MovieInfo().ran
            }
        }.disposed(by: disposeBag)
    }
}



