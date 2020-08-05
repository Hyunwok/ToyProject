import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MainPageVC: UIViewController {
    
    private let key = "430156241533f1d058c603178cc3ca0e"
    let viewModel = MovieReloadViewModel()
    let disposeBag = DisposeBag()
    let apiService = APIService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        viewModel.loadView(url: "")
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.xibName, cellType: MovieCell.self)) { index, movie, cell in
                cell.movie = movie
        }.disposed(by: disposeBag)
        
        tableView.rowHeight = 120
        
        Observable.zip(self.tableView.rx.itemSelected, self.tableView.rx.modelSelected(List.self))
            .bind { [unowned self] indexPath, model in
//                let storyboard = UIStoryboard(name: "MainPage", bundle: nil)
//
//                guard let vc:DetailVC = storyboard.instantiateViewController(identifier: "DetailVC") as? DetailVC else { return }
                
                guard let vc1:DetailVC = self.controller(name: .detail) else { return }
//                guard let vc:DetailVC = self.pushVC(identifier: "DetailVC") as? DetailVC else { return }
                vc1.item = model
                
                self.navigationController?.pushViewController(vc1, animated: true)
        }.disposed(by: self.disposeBag)
        
//        self.tableView.rx.modelSelected(List.self)
//            .subscribe(onNext: { [weak self] indexPath -> List in
//                return [List].indexpath
//            }).disposed(by: disposeBag)
        
//        self.tableView.rx.itemSelected.subscribe(onNext: { indexPath in
//
//            }).disposed(by: disposeBag)
    }
}

struct ViewModel {
    var items: Observable<[Result]>
}
