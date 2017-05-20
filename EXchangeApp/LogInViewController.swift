//
//  LogInViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 3/13/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(for: self.view)
        emailTextField.keyboardType = .emailAddress
        emailTextField.reloadInputViews()
        
        passwordTextField.keyboardType = .alphabet
        passwordTextField.isSecureTextEntry = true
        passwordTextField.reloadInputViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        let password = passwordTextField.text
        let email = emailTextField.text
        
        if (password == "" || password == nil){
            let passwordAlert = UIAlertController(title: "Error", message: "Enter password", preferredStyle: .alert)
            let passwordAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            passwordAlert.addAction(passwordAlertAction)
            self.present(passwordAlert, animated: true, completion: nil)
        }
        
        if (email == nil || email == ""){
            let emailAlert = UIAlertController(title: "Error", message: "Enter email", preferredStyle: .alert)
            let emailAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            emailAlert.addAction(emailAlertAction)
            self.present(emailAlert, animated: true, completion: nil)
        }
        
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
            if error != nil{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alerAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alerAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            self.performSegue(withIdentifier: "Show_App_From_Log_In", sender: self)
        })
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
