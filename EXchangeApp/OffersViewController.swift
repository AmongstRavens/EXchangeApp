//
//  OffersViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/1/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import AVFoundation
import UIKit

class OffersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, OffersLayoutDelegate{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    private var data : [(title: String, image: UIImage?, description: String, time: String)] = [
        (title: "Tiny pan", image: #imageLiteral(resourceName: "pan"), description : "Sheffield Classic Aluminum Non-Stick Frying Pan, Green, 13 Inches, Hard-Anodised", time : "September, 18"),
        (title: "Beautyfull saucepan", image: #imageLiteral(resourceName: "saucepan"), description : "King International Stainless Steel Silver Tadka Pan Set Of 1 Piece", time : "December, 20"),
        (title: "Shiny lamp", image: #imageLiteral(resourceName: "lamp"), description : "Lampe de Sol Arme Fusil M16 Inspirée Philippe Starck Design Luxe Loft Pop Art", time : "June, 11"),
        (title: "Beautyfull saucepan", image: #imageLiteral(resourceName: "saucepan"), description : "King International Stainless Steel Silver Tadka Pan Set Of 1 Piece", time : "December, 20"),
        (title: "Shiny lamp", image: #imageLiteral(resourceName: "lamp"), description : "Lampe de Sol Arme Fusil M16 Inspirée Philippe Starck Design Luxe Loft Pop Art", time : "June, 11"),
        (title: "Beautyfull saucepan", image: #imageLiteral(resourceName: "saucepan"), description : "King International Stainless Steel Silver Tadka Pan Set Of 1 Piece", time : "December, 20"),
        (title: "Shiny lamp", image: #imageLiteral(resourceName: "lamp"), description : "Lampe de Sol Arme Fusil M16 Inspirée Philippe Starck Design Luxe Loft Pop Art", time : "June, 11"),
        (title: "Tiny pan", image: #imageLiteral(resourceName: "pan"), description : "Sheffield Classic Aluminum Non-Stick Frying Pan, Green, 13 Inches, Hard-Anodised", time : "September, 18"),
        (title: "Tiny pan", image: #imageLiteral(resourceName: "pan"), description : "Sheffield Classic Aluminum Non-Stick Frying Pan, Green, 13 Inches, Hard-Anodised", time : "September, 18")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonGestureRecognizer(for: menuButton)
        offerCollectionView.dataSource = self
        offerCollectionView.delegate = self
        
        if let layout = offerCollectionView.collectionViewLayout as? OffersCollectionViewControllerLayout{
            layout.delegate = self
        }
        setCustomNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OfferCollectionViewCell
        
        cell.offerImageView.image = data[indexPath.item].image
        cell.dateLabel.text = data[indexPath.item].time
        cell.offerLabel.text = data[indexPath.item].title
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.9).cgColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        
        cell.userImageView.image = #imageLiteral(resourceName: "avatar").withRenderingMode(.alwaysTemplate)
        cell.userImageView.tintColor = UIColor.black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(collectionView: UICollectionView, heightForTopLabelAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat{
        return data[indexPath.item].title.height(withConstrainedWidth: width, font: UIFont(name: "SanFranciscoText-Regular", size: 18)!)
    }
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat{
        if let image = data[indexPath.item].image{
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
            return rect.size.height
        } else {
            return 0
        }
    }
    
    
}
