//
//  UserProfileViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/23/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    var data : [(image : UIImage, item : String)] = [
        (image : #imageLiteral(resourceName: "saucepan"), item : "Saucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan"),
        (image : #imageLiteral(resourceName: "saucepan"), item : "Saucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan"),
        (image : #imageLiteral(resourceName: "saucepan"), item : "SaucepanSaucepanSaucepanSaucepanSaucepanSaucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan")
    ]
    var isFromConversation : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar()
        navigationItem.title = "User profile"
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.layer.borderWidth = 1
        itemsCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        itemsCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width / 2
        avatarImageView.clipsToBounds = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if isFromConversation == true{
            contactButton.isHidden = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item Cell", for: indexPath) as! ItemCollectionViewCell
        cell.itemImageView.image = data[indexPath.row].image
        cell.postingDateLabel.text = "September, 1"
        cell.itemLabel.text = data[indexPath.row].item
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemsCollectionView.bounds.size.width / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Exchange", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Excnage"{
            let destinationVC = segue.destination as! OfferExchangeViewController
            let index = sender as! IndexPath
            destinationVC.itemForExchange = data[index.row]
        }
    }
    
}
