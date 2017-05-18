//
//  OfferInfoViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/15/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class OfferInfoViewController: UIViewController {
    
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    var data : (title: String, image: UIImage?, description: String, time: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSubViews()
    }
    
    
    @IBAction func contactButtonPressed(_ sender: UIButton) {
    }
    
    private func imageHeight(image : UIImage?) -> CGFloat{
        if image != nil{
            let boundingRect = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRatio: image!.size, insideRect: boundingRect)
            return rect.size.height
        } else {
            return 0
        }
    }
    
    private func prepareSubViews(){
        titleLabel.text = data.title
        offerDescriptionLabel.text = data.description
        avatarImageView.image = #imageLiteral(resourceName: "avatar")
        offerImageView.image = data.image ?? UIImage()
        //set person profile here
        titleLabel.sizeToFit()
        offerDescriptionLabel.sizeToFit()
        imageHeightConstraint.constant = imageHeight(image : data.image)
    }
}
