import UIKit
import RxSwift
import RxCocoa
import Alamofire

//MARK: MainPageVC
class MainPageVC: UIViewController {
    
    lazy var dateString = getDateString(format: "yyyyMMdd", date: Date(timeIntervalSinceNow: -86400))
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 120
        
        let a: Observable<MovieModel> = APIService.shared.loadMovie(apiRequest: ChartMovieRequest(date: self.dateString))
        a.map { $0.boxOfficeResult.dailyBoxOfficeList }
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.xibName, cellType: MovieCell.self)) { index, movie, cell in
                cell.movie = movie
            }.disposed(by: disposeBag)
        
        Observable.zip(self.tableView.rx.itemSelected, self.tableView.rx.modelSelected(List.self))
            .bind { [unowned self] _, model in
                guard let vc:DetailVC = self.controller(storyBoardName: "MainPage", name: .detail) else { return }
                vc.item = model
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

//MARK: ChartMovieRequest
struct ChartMovieRequest: APIRequest {
    var path = "key=430156241533f1d058c603178cc3ca0e&"
    var parameters = [String : String]()
    
    init(date: String) {
        parameters["targetDt="] = date
    }
}
