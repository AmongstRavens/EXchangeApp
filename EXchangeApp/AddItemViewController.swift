//
//  AddItemViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/23/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var addImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar()
        navigationItem.title = "Add Item"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    @IBAction func addItem(_ sender: UIButton) {
        if titleTextField.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Enter title", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if  descriptionTextField.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Enter description", preferredStyle: .alert)
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
        
        let itemTitle = titleTextField.text
        let itemDescription = descriptionTextField.text
        let image = addImageButton.backgroundImage(for: .normal) ?? #imageLiteral(resourceName: "avatar")
        let itemImage = UIImageJPEGRepresentation(image, 0.4)
        
        
        
       
        let storageReference = FIRStorage.storage().reference().child("Items images").child(CurrentUser.uid)
        storageReference.put(itemImage!, metadata: nil) { (metadata, error) in
            if error != nil{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            let imageReference = metadata?.downloadURL()?.absoluteString
            let itemData : [String : AnyObject] = [
                "title" : itemTitle! as AnyObject,
                "description" : itemDescription! as AnyObject,
                "image" : imageReference as AnyObject
            ]
            
            
            self.addItemIntoDataBase(uid: CurrentUser.uid, value: itemData)
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
    }
    
    func addItemIntoDataBase(uid : String, value : [String : AnyObject]){
        let reference = FIRDatabase.database().reference(fromURL: "https://exchangeapp-7f50f.firebaseio.com/")
        let usersReference = reference.child("Items").child(uid)
        
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
}
