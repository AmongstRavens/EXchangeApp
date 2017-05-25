//
//  UserOffersViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/23/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import SWRevealViewController
import UIKit

class UserOffersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    private var segmentState : Int = 0
    var data : [(image : UIImage, item : String)] = [
        (image : #imageLiteral(resourceName: "saucepan"), item : "Saucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan"),
        (image : #imageLiteral(resourceName: "saucepan"), item : "Saucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan"),
        (image : #imageLiteral(resourceName: "saucepan"), item : "SaucepanSaucepanSaucepanSaucepanSaucepanSaucepan"),
        (image : #imageLiteral(resourceName: "pan"), item : "Pan")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonGestureRecognizer(for: menuButton)
        setCustomNavigationBar()
        segmentControl.addTarget(self, action: #selector(changeCollectionView(sender:)), for: .valueChanged)
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
    }
    
    func changeCollectionView(sender : UISegmentedControl){
        if segmentState == 1{
            segmentState = 0
            offersCollectionView.reloadData()
            print("SOMETHING")
            return
        } else {
            print("n`OTHING")
            segmentState = 1
            offersCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentState == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Income Offers Cell", for: indexPath) as! IncomeOffersCollectionViewCell
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.leftImageView.image = data[indexPath.row].image
            cell.leftLabel.text = data[indexPath.row].item
            cell.rightImageView.image = #imageLiteral(resourceName: "pan")
            cell.acceptButton.addTarget(self, action: #selector(acceptButtonPressed(sender:)), for: .touchUpInside)
            cell.declineButton.addTarget(self, action: #selector(declineButtonPressed(sender:)), for: .touchUpInside)
            cell.rightLabel.text = "Pan"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Outcome Offers Cell", for: indexPath) as! OutcomeOffersCollectionViewCell
            cell.leftImageView.image = data[indexPath.row].image
            cell.leftLabel.text = data[indexPath.row].item
            cell.rightImageVIew.image = #imageLiteral(resourceName: "saucepan")
            cell.rightLabel.text = "Saucepan"
            cell.deleteButton.addTarget(self, action: #selector(declineButtonPressed(sender:)), for: .touchUpInside)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentState == 0 {
            return CGSize(width: offersCollectionView.bounds.size.width, height: offersCollectionView.bounds.size.width * 3/4)
        } else {
            return CGSize(width: offersCollectionView.bounds.size.width, height: offersCollectionView.bounds.size.width * 3/4)
        }
    }
    
    func acceptButtonPressed(sender : UIButton){
        
    }
    
    func declineButtonPressed(sender : UIButton){
        
    }
    
    func deleteButtonPressed(sender : UIButton){
        
    }
}
