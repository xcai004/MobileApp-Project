//
//  detailsViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/28/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import CoreData
import UIKit

class detailsViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //connect label, picker and stepper
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //create variable t shirt ID and url of pictures
    var tshirtID: String = ""
    var pictureURL = ""

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //create different options of the pickerview
    var sizes = ["Small", "Medium", "Large", "X-Large", "2X-Large", "3X-Large" ,"4X-Large" ,"5X-Large" ,"6X-Large"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get data of the t-sirt name, price, desc and url by tshirt ID
        if(tshirtID != ""){
            
            let Shirt = ShirtsModel.sharedInstance.getShirtById(id: tshirtID)
            nameLabel.text = Shirt.name
            priceLabel.text = Shirt.price
            descLabel.text = Shirt.desc
            pictureURL = Shirt.picture
            let url = URL(string: pictureURL)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                imageView.image = image
            }
            
            
        }
        
        
    }
    // pass the value to size lable bu the changeing of the pickerview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeLabel.text = sizes[row]
        sizeLabel.textColor = UIColor.black
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizes[row]
    }
    
    // change the unmber of quantity by the pressing of stepper
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        quantityLabel.text = String(Int(sender.value))
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        
        
        // initial mymodel to model
        let MyModel = CartModel.sharedInstance
        // inital the size , url of picture, quantity, price, name and ID
        let size = sizeLabel.text
        let picture = pictureURL
        let quantity = quantityLabel.text
        let price = priceLabel.text
        let name = nameLabel.text
        let id = tshirtID
        
        // set alter for the customer not choose the size and quantity
        if size == "select your size" || quantity == "0" {
            
            let alert = UIAlertController(title: "Error", message: "Please select size and quantity before adding to cart", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        // pass the data to the cart
        MyModel.addToCart(price: price!, name: name!, size: size!, picture: picture, quantity: quantity!, id: id )
        
        // set notification for the data saved successfully
        var alertText = "Item succesfully added to cart"
        
        let alert = UIAlertController(title: "Success", message:  alertText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        

        
    }
}
