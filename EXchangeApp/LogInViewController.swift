//
//  LogInViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 3/13/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SWRevealViewController

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
            }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        let password = passwordTextField.text
        let email = emailTextField.text
        
        if (password == "" || password == nil){
            let passwordAlert = UIAlertController(title: "Error", message: "Enter password", preferredStyle: .alert)
            let passwordAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            passwordAlert.addAction(passwordAlertAction)
            self.present(passwordAlert, animated: true, completion: nil)
            return
        }
        
        if (email == nil || email == ""){
            let emailAlert = UIAlertController(title: "Error", message: "Enter email", preferredStyle: .alert)
            let emailAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            emailAlert.addAction(emailAlertAction)
            self.present(emailAlert, animated: true, completion: nil)
            return
        }
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        let veilView = UIView(frame: view.frame)
        veilView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        let width : CGFloat =  100.0
        let height : CGFloat = 100.0
        let xPoint : CGFloat = (veilView.bounds.size.width - width) / 2
        let yPoint : CGFloat = (veilView.bounds.size.height - height) / 2
        activityView.frame = CGRect(x: xPoint, y: yPoint, width: width, height: height)
        activityView.layer.zPosition = 2
        veilView.addSubview(activityView)
        view.addSubview(veilView)
        activityView.startAnimating()
        
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
            if error != nil{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alerAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alerAction)
                self.present(alertController, animated: true, completion: nil)
                activityView.stopAnimating()
                activityView.removeFromSuperview()
                return
            }
            
            let currentUserUid = user?.uid
            let userReference = FIRDatabase.database().reference(fromURL: "https://exchangeapp-7f50f.firebaseio.com/").child("users").child(currentUserUid!)
            userReference.observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject]{
                    CurrentUser.avatarReference = dictionary["image"] as! String
                    CurrentUser.email = dictionary["email"] as! String
                    CurrentUser.name = dictionary["name"] as! String
                    CurrentUser.uid = currentUserUid!
                }
            }, withCancel: nil)
            
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            self.startApplication()
        })
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    private func startApplication(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "Initial View Controller") as? SWRevealViewController{
            present(vc, animated: true, completion: nil)
        }
    }
}
