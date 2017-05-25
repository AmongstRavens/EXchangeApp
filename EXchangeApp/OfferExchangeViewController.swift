//
//  OfferExchangeViewController.swift
//  Pods
//
//  Created by Sergey on 5/21/17.
//
//

import UIKit

class OfferExchangeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var exchangeCollectionView: UICollectionView!
    @IBOutlet weak var exchangeButton: UIButton!
    
    var data : [(image : UIImage, item : String)] = [
        (image : #imageLiteral(resourceName: "saucepan"), item : "Saucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan"),
        (image : #imageLiteral(resourceName: "saucepan"), item : "Saucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan"),
        (image : #imageLiteral(resourceName: "saucepan"), item : "SaucepanSaucepanSaucepanSaucepanSaucepanSaucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan")
    ]
    var itemForExchange : (image : UIImage, item : String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeCollectionView.delegate = self
        exchangeCollectionView.dataSource = self
        exchangeCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        exchangeCollectionView.layer.borderWidth = 1
        exchangeCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        rightImageView.image = #imageLiteral(resourceName: "saucepan")
        setCustomNavigationBar()
        navigationItem.title = "My offer"
    }
    
    @IBAction func exchangeButtonPressed(_ sender: UIButton) {
        //set exchanging
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item Cell", for: indexPath) as! ItemCollectionViewCell
        cell.itemImageView.image = data[indexPath.row].image
        cell.itemLabel.text = data[indexPath.row].item
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        leftImageView.image = data[indexPath.row].image
        leftLabel.text = data[indexPath.row].item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = exchangeCollectionView.bounds.size.width / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
