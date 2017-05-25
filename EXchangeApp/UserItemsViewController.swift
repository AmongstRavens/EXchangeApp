//
//  UserItemsViewController.swift
//  Pods
//
//  Created by Sergey on 5/21/17.
//
//

import UIKit

class UserItemsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var addItemBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var itemsCollectionView: UICollectionView!

    var data : [(title: String, image: UIImage?, description: String, time: String)] = [
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
        setCustomNavigationBar()
        addButtonGestureRecognizer(for: menuButton)
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item Cell", for: indexPath) as! ItemCollectionViewCell
        cell.itemImageView.image = data[indexPath.row].image!
        cell.itemLabel.text = data[indexPath.row].title
        cell.postingDateLabel.text = data[indexPath.row].time
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
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
        performSegue(withIdentifier: "Show Item Info", sender: indexPath)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Show Add Item", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Item Info"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let destinationVC = segue.destination as! ItemInfoViewController
            let index = sender as! IndexPath
            destinationVC.data = data[index.row]
        }
        if segue.identifier == "Show Add Item"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
        }
    }

}
