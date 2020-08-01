import UIKit
import RxSwift

class SearchPageVC: UIViewController {
    
    let viewModel = MovieReloadViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.rx.text
//        self.searchBar.rx.text.asObservable()
//            .map { ($0 ?? "").lowercased() }
//            .map { UniversityRequest(name: $0) }
//            .flatMap { request -> Observable<[Result]> in
//                return self.apiClient.send(apiRequest: request) }.bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { index, model, cell in
//                    cell.textLabel?.text = model.name
//        }.disposed(by: disposeBag)
//
//        tableView.rx.items(cellIdentifier: "MyCell") { index, movie, cell in
//            if let cellToUse = cell {
//                cellToUse.textLabel.text = mo
//            }
//        }
        
    }
}

//observable.bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { index, movie, cell in
//if let cellToUse = cell as? MovieTableCell {
//    cellToUse.movieName.text =
//}
