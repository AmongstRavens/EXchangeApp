//
//  MessagesTableViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/17/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class MessagesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private var data : [(image: UIImage, name: String, lastMessage: String)] = [
        (image : #imageLiteral(resourceName: "avatar"), name : "John Snow", lastMessage: "I know nothing"),
        (image : #imageLiteral(resourceName: "avatar"), name : "John Snow", lastMessage: "I know nothing"),
        (image : #imageLiteral(resourceName: "avatar"), name : "John Snow", lastMessage: "I know nothing")
    ]
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var messagesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonGestureRecognizer(for: menuButton)
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Message Cell") as! MessagesTableViewCell
        let image = #imageLiteral(resourceName: "avatar").withRenderingMode(.alwaysTemplate)
        cell.personImageView.image = image
        cell.personImageView.tintColor = UIColor.black
        cell.personNameLabel.text = data[indexPath.row].name
        cell.lastMessageLabel.text = data[indexPath.row].lastMessage
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        performSegue(withIdentifier: "Show Conversation", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Conversation"{
            let destinationVC = segue.destination as! ConversationViewController
            destinationVC.personData = data[(sender as! IndexPath).row]
        }
    }
}
