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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var tshirtID: String = ""
    var tshirtName: String = ""
    var tshirtPictureURL: String = ""
    var tshirtPrice: String = ""
    var tshirtDescription: String = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var sizes = ["Small", "Medium", "Large", "X-Large", "2X-Large", "3X-Large" ,"4X-Large" ,"5X-Large" ,"6X-Large"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        if(tshirtPictureURL != ""){
            let url = URL(string: tshirtPictureURL)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                imageView.image = image
            }else{
                
            }
        }
        
        if(tshirtName != ""){
            nameLabel.text = tshirtName
        }
        
        if(tshirtPrice != ""){
            priceLabel.text = tshirtPrice
        }
        
        if(tshirtDescription != ""){
            descLabel.text = tshirtDescription
        }
        
        if(tshirtID != ""){
            
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeLabel.text = sizes[row]
        sizeLabel.textColor = UIColor.black
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizes[row]
    }
    
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        quantityLabel.text = String(Int(sender.value))
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Success", message: "Item succesfully added to cart", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        

        
    }
}
