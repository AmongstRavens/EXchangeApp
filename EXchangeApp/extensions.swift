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
    
    func setCustomNavigationBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "SanFranciscoText-Medium", size: 19)!, NSForegroundColorAttributeName : UIColor.black]
    }
    
    func addButtonGestureRecognizer(for item: UIBarButtonItem){
        if revealViewController() != nil {
            item.target = revealViewController()
            item.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}

