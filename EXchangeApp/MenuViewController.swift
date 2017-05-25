//
//  MenuViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 4/6/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import FirebaseAuth
import SWRevealViewController

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var logOutButton: UIButton!
    private let veilView = UIView()
    private let menuData : [(description : String, image : UIImage)] = [
        (description : "Items Roll", image : #imageLiteral(resourceName: "box")),
        (description : "Offers", image : #imageLiteral(resourceName: "exchange")),
        (description : "My items", image : #imageLiteral(resourceName: "my_items")),
        (description : "Messages", image : #imageLiteral(resourceName: "mail")),
        (description : "Settings", image : #imageLiteral(resourceName: "settings"))
    ]
    @IBOutlet weak var menuTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVeilView()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.tableFooterView = UIView(frame: .zero)
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.menuTableView.bounds.size.width, height: self.menuTableView.bounds.size.height))
        backgroundView.backgroundColor = UIColor.black
        self.menuTableView.backgroundView = backgroundView
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        let buttonImage = #imageLiteral(resourceName: "sign_out").withRenderingMode(.alwaysTemplate)
        logOutButton.setBackgroundImage(buttonImage, for: .normal)
        
        logOutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.revealViewController() != nil{
            self.revealViewController().frontViewController.view.addSubview(veilView)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        veilView.removeFromSuperview()
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        cell.linkLabel.text = menuData[indexPath.item].description
        cell.menuImageView.image = menuData[indexPath.item].image
        cell.backgroundColor = UIColor.black
        cell.linkLabel.textColor = UIColor.white
        cell.menuImageView.image = cell.menuImageView.image!.withRenderingMode(.alwaysTemplate)
        cell.menuImageView.tintColor = UIColor.white
        cell.selectionStyle = .none
        cell.separatorInset.left = 60
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = (tableView.cellForRow(at: indexPath) as! MenuTableViewCell).linkLabel.text
        performSegue(withIdentifier: "Show" + link!, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    private func setVeilView(){
        veilView.frame = CGRect(x: 0, y: 0, width: self.revealViewController().rearViewController.view.bounds.size.width, height: self.revealViewController().rearViewController.view.bounds.size.height)
        veilView.layer.isOpaque = true
        veilView.backgroundColor = UIColor.black.withAlphaComponent(0)
        veilView.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        veilView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @objc private func handleLogout(){
        do{
            try FIRAuth.auth()?.signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartNavigationController") as? UINavigationController
            self.present(vc!, animated: true, completion: nil)
        } catch let logOutError{
            let alertController = UIAlertController(title: "Error", message: logOutError.localizedDescription, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
