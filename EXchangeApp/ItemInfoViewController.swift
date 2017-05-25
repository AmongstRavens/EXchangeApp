//
//  ItemInfoViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/21/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import AVFoundation

class ItemInfoViewController: UIViewController{

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageViewButton: UIButton!
    var data : (title: String, image: UIImage?, description: String, time: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar()
        navigationItem.title = "Item"
        titleTextField.text = data.title
        descriptionTextField.text = data.description
        imageViewButton.setBackgroundImage(data.image, for: .normal)
        dateLabel.text = data.time
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func applyChanges(_ sender: UIButton) {
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageViewHeightConstraint.constant = imageHeight(image: imageViewButton.backgroundImage(for: .normal))
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
    
  
}
