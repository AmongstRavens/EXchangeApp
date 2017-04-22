//
//  MainCollectionViewController.swift
//  EXchangeApp
//
//  Created by Sergey on 4/22/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import UIKit
import SWRevealViewController

class MainCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        return cell
    }

}
