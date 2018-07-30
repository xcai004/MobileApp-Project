//
//  CartViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/28/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
   let MyModel = CartModel.sharedInstance
    var Cart: [CartItem] = []
    var index = 0;


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let index = indexPath.row
        let price = Double(Cart[index].price)
        let quantity = Double((Cart[index].quantity))
        let total = price! * quantity!
        //let price = 0
        let name = Cart[index].name
        let size = " size: " + Cart[index].size
        let quantityText = " x" + Cart[index].quantity
        let priceText = " $" + String(total)
        let text = name + size + quantityText + priceText
        
        cell.textLabel?.text = text
        
        if(Cart[index].picture != ""){
            let url = URL(string: Cart[index].picture)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                  cell.imageView?.image = image
            }
        }
        //cell.imageView?.image = UIImage(named: "Login.png")

      
        return (cell)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let index = indexPath.row
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            request.returnsObjectsAsFaults = false;
            do{
                let results = try context.fetch(request)
                
                if ((results[index] as? NSManagedObject) != nil)
                {
                    let result = results[index] as? NSManagedObject
                    context.delete(result!)
                }
                try context.save()
            } catch {
                
            }
            
            MyModel.fetchCart()
            Cart = MyModel.getCart()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        self.performSegue(withIdentifier: "detailsSegue", sender: self);
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailsSegue"){
            let DetailsController = segue.destination as! detailsViewController
            DetailsController.tshirtID = Cart[index].id
            
        }
    }
    
    
    
    @IBAction func checkOutPressed(_ sender: Any) {
        
        
        if  Cart.count == 0 {
            
            let alert = UIAlertController(title: "Error", message: "Please add something to your cart before checking out", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }else{
            self.performSegue(withIdentifier: "checkoutSegue", sender: self)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyModel.fetchCart()
        Cart = MyModel.getCart()
        
    }
}
