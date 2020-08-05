//
//  MoiveCell.swift
//  MovieService
//
//  Created by 이현욱 on 2020/08/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    static let xibName = "MyCell"

    @IBOutlet weak var cumulativeAudience: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var movieOpenDate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
