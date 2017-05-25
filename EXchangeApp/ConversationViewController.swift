//
//  ConversationViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/18/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Firebase

class ConversationViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var conversationCollectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    private var messageYOffset : CGFloat = 10
    var personData : (image: UIImage, name: String, lastMessage: String)!
    var user : User!
    var receiver : User!
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiver = User()
        receiver.uid = "0ZwVga6ZH9SnJZaYxsgMuNBYZKO2"
        view.backgroundColor = UIColor.white
        setNavigationbar()
        messageTextField.delegate = self
        messageTextField.keyboardType = .alphabet
        sendButton.addTarget(self, action: #selector(sendButtonAction(_:)), for: UIControlEvents.touchUpInside)
        conversationCollectionView.delegate = self
        conversationCollectionView.dataSource = self
    }
    
    private func setNavigationbar(){
        navigationItem.title = personData.name
        let barImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        barImage.image = #imageLiteral(resourceName: "avatar").withRenderingMode(.alwaysTemplate)
        barImage.tintColor = UIColor.black
        barImage.layer.cornerRadius = barImage.bounds.size.width / 2
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setBackgroundImage(#imageLiteral(resourceName: "avatar").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(showUserInfo(_:)), for: .touchUpInside)
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        let rightBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = rightBarButton
        
        messageTextField.tintColor = UIColor.white
    }
 
    
    private func heightForLabel(width : CGFloat, text : String) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SanFranciscoText-Regular", size: 17)
        label.text = text
        label.sizeToFit()
        return label.bounds.size.height
    }
    
    @objc private func sendButtonAction(_ sender : UIButton){
        messageTextField.endEditing(true)
        if messageTextField.text != ""{
            let reference = FIRDatabase.database().reference().child("Messages").childByAutoId()
            
            let message = Message()
            let timestamp : NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
            let values = ["text" : messageTextField.text!, "sender" : CurrentUser.uid, "receiver" : receiver.uid, "time" : timestamp] as [String : AnyObject]
            message.receiver = receiver.uid!
            message.sender = CurrentUser.uid!
            message.text = messageTextField.text!
            message.time = timestamp
            self.messages.append(message)
            messageTextField.text = ""
            self.conversationCollectionView.reloadData()
            reference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let alerAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(alerAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            })
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Message Cell", for: indexPath) as! MessageCollectionViewCell
        cell.messageLabel.text = messages[indexPath.row].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: conversationCollectionView.bounds.size.width, height: 80)
    }
    
    func showUserInfo(_ sender : UIBarButtonItem){
        print("Succes")
        performSegue(withIdentifier: "Show User Info", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show User Info"{
            let destinationVC = segue.destination as! UserProfileViewController
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            destinationVC.isFromConversation = true
        }
    }
    
}
