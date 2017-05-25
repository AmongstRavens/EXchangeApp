//
//  MessagesTableViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/17/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import Firebase

class MessagesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var messagesDictionary = [String : Message]()
    var messages = [(User, Message)]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var messagesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMessages()
        addButtonGestureRecognizer(for: menuButton)
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Message Cell") as! MessagesTableViewCell
        let image = messages[indexPath.row].0.profileImage
        cell.personImageView.image = image
        cell.personNameLabel.text = messages[indexPath.row].0.name
        cell.lastMessageLabel.text = messages[indexPath.row].1.text
        
        let seconds = messages[indexPath.row].1.time.doubleValue
        let timestampDate = NSDate(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        cell.dateLabel.text = timestampDate.description
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        performSegue(withIdentifier: "Show Conversation", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Conversation"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let destinationVC = segue.destination as! ConversationViewController
            
        }
    }
    
    func fetchMessages(){
        let reference = FIRDatabase.database().reference().child("Messages")
        reference.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                let message = Message()
                message.receiver = dictionary["receiver"] as! String
                message.sender = dictionary["sender"] as! String
                message.text = dictionary["text"] as! String
                message.time = dictionary["time"] as! NSNumber
                
                self.messagesDictionary[message.receiver] = message
                
                for (key, value) in self.messagesDictionary{
                    let user = self.getUserByUid(uid: key)
                    self.messages.append((user, value))
                }
                self.messages.sort(by: { (firstTuple, secondTuple) -> Bool in
                    return firstTuple.1.time.intValue > secondTuple.1.time.intValue
                })
                DispatchQueue.main.async {
                    self.messagesTableView.reloadData()
                }
            }

        }, withCancel: nil)
    }
    
    func getUserByUid(uid : String) -> User{
        var createdUser = User()
        var load : Bool = false
            let reference = FIRDatabase.database().reference().child("users").child(uid)
            reference.observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject]{
                    createdUser.uid = uid
                    createdUser.avatarReference = dictionary["image"] as! String
                    createdUser.email = dictionary["email"] as! String
                    createdUser.name = dictionary["name"] as! String
                    createdUser.profileImage = self.fetchImageFromUrl(inputString: createdUser.avatarReference!)
                    load = true
                }
            }, withCancel: nil)
        

        
        return createdUser
    }
    
  
}
