//
//  CartViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/28/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
   let MyModel = CartModel.sharedInstance
    var Cart: [CartItem] = []

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyModel.listCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let index = indexPath.row
        cell.textLabel?.text = Cart[index].name
        
        if(Cart[index].picture != ""){
            let url = URL(string: Cart[index].picture)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                  cell.imageView?.image = image
            }
        }
        cell.imageView?.image = UIImage(named: "Login.png")

      
        return (cell)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         Cart = MyModel.getCart()
        
    }
}
