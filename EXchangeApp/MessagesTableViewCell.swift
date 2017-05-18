//
//  MessagesTableViewCell.swift
//  EXchangeApp
//
//  Created by Sergey on 5/17/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        personImageView.layer.cornerRadius = personImageView.bounds.size.width / 2
        personImageView.clipsToBounds = true
    }
}
