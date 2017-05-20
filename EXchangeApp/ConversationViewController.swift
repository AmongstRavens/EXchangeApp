//
//  ConversationViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/18/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    enum messageSender{
        case left
        case right
    }
    
    private var messageYOffset : CGFloat = 10
    var personData : (image: UIImage, name: String, lastMessage: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationbar()
        messageTextField.delegate = self
        messageTextField.keyboardType = .alphabet
        NotificationCenter.default.addObserver(self, selector: #selector(ConversationViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConversationViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        sendButton.addTarget(self, action: #selector(sendButtonAction(_:)), for: UIControlEvents.touchUpInside)
    }
    
    private func setNavigationbar(){
        navigationItem.title = personData.name
        let barImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        barImage.image = #imageLiteral(resourceName: "avatar").withRenderingMode(.alwaysTemplate)
        barImage.tintColor = UIColor.black
        barImage.layer.cornerRadius = barImage.bounds.size.width / 2
        
        let rightBarButton = UIBarButtonItem(customView: barImage)
        navigationItem.rightBarButtonItem = rightBarButton
        
        messageTextField.tintColor = UIColor.white
    }
    
    private func display(message: String, sender : messageSender){
        let messageLabel = UILabel()
        if sender == messageSender.left{
            messageLabel.frame = CGRect(x: 10, y: messageYOffset, width: scrollView.bounds.size.width / 2 - 15, height: heightForLabel(width: scrollView.bounds.size.width / 2 - 15, text: message) + 10)
            messageLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        } else {
            let labelWidth = scrollView.bounds.size.width / 2 - 15
            messageLabel.frame = CGRect(x: scrollView.bounds.size.width - labelWidth - 15, y: messageYOffset, width: labelWidth, height: heightForLabel(width: labelWidth, text: message) + 10)
            messageLabel.backgroundColor = UIColor.white
        }
        messageLabel.numberOfLines = 20
        messageLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        messageLabel.layer.borderWidth = 2
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont(name: "SanFranciscoText-Regular", size: 17)
        
        messageYOffset += messageTextField.bounds.size.height + 20
        scrollView.addSubview(messageLabel)
        print(message)
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
    
    @objc private func sendButtonAction(_ sender : UIButton){
        messageTextField.endEditing(true)
        if (messageTextField.text != nil){
            display(message: messageTextField.text!, sender: messageSender.right)
        }
    }
    
}
