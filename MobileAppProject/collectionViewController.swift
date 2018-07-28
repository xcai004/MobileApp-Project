//
//  collectionViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/27/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import UIKit

class collectionViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate{
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let array: [String] = ["1.jpg","2.jpg","3.jpeg", "4.jpg", "5.jpeg","1.jpg","2.jpg","3.jpeg", "4.jpg", "5.jpeg","1.jpg","2.jpg","3.jpeg", "4.jpg", "5.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width/2 - 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        myCollectionView.collectionViewLayout = layout
    }
    
    
    //number of views 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    //populate views
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.myImageView.image = UIImage(named: array[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "detailsSegue", sender: self);
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let DetailsController = segue.destination as! detailsViewController
        DetailsController.tshirtID = "123" // replace with real id
        
        
        
    }
    
}
