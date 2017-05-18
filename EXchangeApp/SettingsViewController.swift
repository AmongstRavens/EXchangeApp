//
//  SettingsViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/18/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar()
        addButtonGestureRecognizer(for: menuButton)
        avatarButton.layer.cornerRadius = avatarButton.bounds.size.width / 2
        
    }
    
    @IBAction func changeAvatar(_ sender: UIButton) {
    }
    
    @IBAction func applyChanges(_ sender: UIButton) {
    }
    
}
