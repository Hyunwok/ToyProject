//
//  SearchVC.swift
//  MovieService
//
//  Created by 이현욱 on 2020/07/21.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class SearchPageVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    AF.request(url, method: .get).responseJSON { response in
//            switch response.response?.statusCode {
//            case 200: return observer.onNext(1)
//            case 400, 500: return observer.onError(response.error as! Error)
//            default: return observer.onError(response.error as! Error)
//            }
//            observer.onCompleted()
//            } as! Disposable
//    })
}
