//
//  SignUpViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 3/13/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit
import SWRevealViewController

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(for: self.view)
        emailTextFiled.keyboardType = .emailAddress
        emailTextFiled.reloadInputViews()
        
        passwordTextField.keyboardType = .alphabet
        passwordTextField.isSecureTextEntry = true
        passwordTextField.reloadInputViews()
        
        avatarButton.layer.cornerRadius = avatarButton.bounds.size.width / 2;
        avatarButton.clipsToBounds = true
        avatarButton.addTarget(self, action: #selector(handleImageChanging), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func singUpButtonPressed(_ sender: UIButton) {
        let email = emailTextFiled.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        
        if email == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
            
        }
        
        if name == ""{
            let alertController = UIAlertController(title: "Error", message: "Please enter your name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if (password?.characters.count)! <= 8{
            let alertController = UIAlertController(title: "Error", message: "Password must contain at least 8 characters", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
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
        
        
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!) { (user, error) in
            
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            //get user uid
            guard let uid = user?.uid else{
                print("Unable to fetch user uid")
                return
            }
            
            //imageUID is unique name of image inside the Database
            let imageUID = NSUUID().uuidString
            
            //reference to the storage whil will contain image
            let storageReference = FIRStorage.storage().reference().child("Users profile images").child("\(imageUID).png")
            
            if self.avatarButton.backgroundImage(for: .normal)! != #imageLiteral(resourceName: "avatar"){
                if let uploadImage = UIImageJPEGRepresentation(self.avatarButton.backgroundImage(for: .normal)!, 0.1){
                    
                    storageReference.put(uploadImage, metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                            return
                        }
                        
                        //the exact reference where image contains
                        if let imageRef = metadata?.downloadURL()?.absoluteString{
                            let values = ["name" : name, "email" : email, "image" : imageRef]
                            CurrentUser.uid = uid
                            CurrentUser.email = email
                            CurrentUser.name = name
                            CurrentUser.avatarReference = imageRef
                            CurrentUser.profileImage = self.avatarButton.backgroundImage(for: .normal)!
                            self.registerUserIntoDataBase(uid: uid, value: values as [String : AnyObject])
                            activityView.stopAnimating()
                            activityView.removeFromSuperview()
                            self.startApplication()
                        }
                    })
                }
            }
            

            
        }
    }
    
    func registerUserIntoDataBase(uid : String, value : [String : AnyObject]){
        let reference = FIRDatabase.database().reference(fromURL: "https://exchangeapp-7f50f.firebaseio.com/")
        let usersReference = reference.child("users").child(uid)
        
        usersReference.updateChildValues(value) { (error, ref) in
            if error != nil{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }
    
    
    
    func handleImageChanging(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel changing")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var pickedImage : UIImage?
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            pickedImage = originalImage
        } else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
                pickedImage = editedImage
            }
        
        if let avatar = pickedImage{
            avatarButton.setBackgroundImage(avatar, for: .normal)
        }
        print(info)
        dismiss(animated: true, completion: nil)
    }
    
    private func startApplication(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "Initial View Controller") as? SWRevealViewController{
            present(vc, animated: true, completion: nil)
        }
    }
   
    
}
