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
    
    //let array: [String] = ["http://gdurl.com/tBNY","2.jpg","3.jpeg", "4.jpg", "5.jpeg","1.jpg","2.jpg","3.jpeg", "4.jpg", "5.jpeg","1.jpg","2.jpg","3.jpeg", "4.jpg", "5.jpeg"]
    // create variable of selectedPictures, name, price, decs and ID
    var Shirts: [ShirtItem]?
    var selectedPicture = ""
    var selectedName = ""
    var selectedPrice = ""
    var selectedDesc = ""
    var selectedId = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // remove left buttons (in case you added some)
        //        self.navigationItem.leftBarButtonItems = []
        
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
        // twp picture in one row
        let itemSize = UIScreen.main.bounds.width/2 - 3
        // set the layout of the pictures
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        myCollectionView.collectionViewLayout = layout
        // get the items from the model
        let MyModel = ShirtsModel.sharedInstance
        MyModel.fetchShirts()
        Shirts = MyModel.getShirts()
        
    }
    
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Shirts!.count
    }
    
    //populate views
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        
        let url = URL(string: (Shirts?[indexPath.row].picture)!)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.myImageView.image = image
        }else{
            
            //cell.myImageView.image = UIImage(named: Shirts[indexPath.row])
        }
        
        return cell
    }
    // get tshirt details to the details view by the tshirt ID
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        selectedPicture = (Shirts?[indexPath.row].picture)!
//        selectedName = (Shirts?[indexPath.row].name)!
//        selectedPrice = (Shirts?[indexPath.row].price)!
//        selectedDesc = (Shirts?[indexPath.row].desc)!
        selectedId = (Shirts?[indexPath.row].id)!
        
        self.performSegue(withIdentifier: "detailsSegue", sender: self);
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailsSegue"){
            let DetailsController = segue.destination as! detailsViewController
             DetailsController.tshirtID = selectedId
//             DetailsController.tshirtPictureURL = selectedPicture
//             DetailsController.tshirtName = selectedName
//             DetailsController.tshirtPrice = selectedPrice
//             DetailsController.tshirtDescription = selectedDesc
            
        }
    }
    
}
