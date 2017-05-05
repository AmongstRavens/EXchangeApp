//
//  OfferCollectionViewCell.swift
//  EXchangeApp
//
//  Created by Sergey on 5/1/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var offerLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? OffersLayoutAttributes{
            offerImageViewHeightConstraint.constant = attributes.imageHeight
            offerLabelHeightConstraint.constant = attributes.topLabelheight
        }
    }
}
