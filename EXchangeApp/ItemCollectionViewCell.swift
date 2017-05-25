//
//  ItemCollectionViewCell.swift
//  EXchangeApp
//
//  Created by Sergey on 5/21/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var postingDateLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let veilView = UIView(frame: CGRect(x: 0, y: 0, width: itemImageView.bounds.size.width, height: itemImageView.bounds.size.height))
        veilView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        itemImageView.addSubview(veilView)
        postingDateLabel.layer.zPosition = 3
        itemLabel.layer.zPosition = 3
    }
}
