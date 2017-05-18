//
//  OffersViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 5/1/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import AVFoundation
import UIKit

class OffersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, OffersLayoutDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    private var searchBar = UISearchBar()
    private var searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(addSearchBar(_:)))
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
    private var shouldUseFilteredArray : Bool = false
    private var filteredData = [(title: String, image: UIImage?, description: String, time: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonGestureRecognizer(for: menuButton)
        offerCollectionView.dataSource = self
        offerCollectionView.delegate = self
        
        if let layout = offerCollectionView.collectionViewLayout as? OffersCollectionViewControllerLayout{
            layout.delegate = self
        }
        
        searchButton.target = self
        searchButton.action = #selector(addSearchBar(_:))
        setCustomNavigationBar()
        setUpSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Offers"
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OfferCollectionViewCell
        
        var cellData : (title: String, image: UIImage?, description: String, time: String)!
        if shouldUseFilteredArray {
            cellData = filteredData[indexPath.row]
        } else {
            cellData = data[indexPath.row]
        }
        
        cell.offerImageView.image = cellData.image
        cell.dateLabel.text = cellData.time
        cell.offerLabel.text = cellData.title
        
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
        if shouldUseFilteredArray {
            return filteredData.count
        } else {
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Offer Info", sender: indexPath)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Offer Info"{
            navigationController?.navigationBar.tintColor = UIColor.black
            let indexPath = sender as! IndexPath
            let destinationVC = segue.destination as! OfferInfoViewController
            destinationVC.data = data[indexPath.row]
        }
        
    }
    
    @objc private func addSearchBar(_ sender : UIBarButtonItem){
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.removeFromSuperview()
        let navBarLabel = UILabel()
        navBarLabel.text = "Offers"
        navigationItem.titleView = navBarLabel
        navigationItem.rightBarButtonItem = searchButton
        shouldUseFilteredArray = false
        if filteredData.count != 0{
            filteredData.removeAll()
            offerCollectionView.reloadData()
            offerCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.removeFromSuperview()
        navigationItem.titleView = UIView()
        navigationItem.title = "Offers"
        navigationItem.rightBarButtonItem = searchButton
        
        if(filteredData.count != 0){
            shouldUseFilteredArray = true
            offerCollectionView.collectionViewLayout.invalidateLayout()
            offerCollectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        for tuple in data{
            let dataString = tuple.title
            if(dataString.range(of: searchText) != nil){
                filteredData.append(tuple)
            }
        }
        
        if (filteredData.count == 0){
            for tuple in data{
                let dataString = tuple.description
                if(dataString.range(of: searchText) != nil && searchText != ""){
                    filteredData.append(tuple)
                    print("Hello wad")
                }
            }
        }
        
    }
    
    private func setUpSearchBar(){
        searchBar.showsCancelButton = true
        searchBar.tintColor = UIColor.black
        searchBar.delegate = self
        searchButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = searchButton
    }
    
}
