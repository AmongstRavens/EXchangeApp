//
//  extensions.swift
//  EXchangeApp
//
//  Created by Sergey on 3/13/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import Foundation
import UIKit
import SWRevealViewController

extension UIViewController{
    
    func hideKeyboardWhenTappedAround(for view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createGradientLayer(for view: UIView) {
        var gradientLayer : CAGradientLayer!
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        gradientLayer.zPosition = -1
        view.layer.addSublayer(gradientLayer)
    }
    
    func addButtonGestureRecognizer(for item: UIBarButtonItem){
        if revealViewController() != nil {
            item.target = revealViewController()
            item.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
