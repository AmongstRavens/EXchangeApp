//
//  MenuViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 4/6/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import SWRevealViewController

class MenuViewController: UIViewController {
    
    private let veilView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setVeilView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.revealViewController() != nil{
            self.revealViewController().frontViewController.view.addSubview(veilView)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        veilView.removeFromSuperview()
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    private func setVeilView(){
        veilView.frame = CGRect(x: 0, y: 0, width: self.revealViewController().rearViewController.view.bounds.size.width, height: self.revealViewController().rearViewController.view.bounds.size.height)
        veilView.layer.isOpaque = true
        veilView.backgroundColor = UIColor.black.withAlphaComponent(0)
        veilView.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        veilView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
