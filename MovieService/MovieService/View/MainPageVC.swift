import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MainPageVC: UIViewController, UITableViewDelegate {
    
    private let key = "430156241533f1d058c603178cc3ca0e"
    let viewModel = MovieReloadViewModel()
    let disposeBag = DisposeBag()
    let apiService = APIService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "MoiveTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        //        tableView.rx.setDataSource(self).dispose
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        let nibName = UINib(nibName: MoiveTableViewCell.xibName, bundle: nil)
        
//        viewModel.loadView(url: "").map { [$0] }
//            .bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { index, movie, cell in
//                if let cellToUse = cell as? MoiveTableViewCell {
//                    let movieIndex = movie.boxOfficeResult.dailyBoxOfficeList[index]
//                    cellToUse.movieName.text = movieIndex.movieNm
//                    cellToUse.movieOpenDate.text = movieIndex.openDt
//                    cellToUse.cumulativeAudience.text = movieIndex.audiAcc
//                    cellToUse.rank.text = movieIndex.rank
//                }
//        }.disposed(by: disposeBag)
        
        viewModel.loadView(url: "").map { [$0] }
            .bind(to: tableView.rx.items(cellIdentifier: "MyCell", cellType: MoiveTableViewCell.self)) { index, movie, cell in
                    let movieIndex = movie.boxOfficeResult.dailyBoxOfficeList[index]
                    cell.movieName.text = movieIndex.movieNm
                    cell.movieOpenDate.text = movieIndex.openDt
                    cell.cumulativeAudience.text = movieIndex.audiAcc
                    cell.rank.text = movieIndex.rank
        }.disposed(by: disposeBag)
    }
}



