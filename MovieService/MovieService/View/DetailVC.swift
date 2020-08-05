//
//  DetailVC.swift
//  MovieService
//
//  Created by 이현욱 on 2020/08/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var item:List?

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.item?.movieNm)
    }
}
