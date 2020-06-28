//
//  CollectionViewCell.swift
//  MINISNS
//
//  Created by 이현욱 on 2020/06/24.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        self.imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
