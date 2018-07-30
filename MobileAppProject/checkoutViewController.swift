//
//  checkoutViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/29/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class checkoutViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var orderDetailsTextField: UITextView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let MyModel = CartModel.sharedInstance
        let cart = MyModel.getCart()
        orderDetailsTextField.text = ""
        var total = 0.0;
        for cartItem in cart {
            var price = (Double(cartItem.price)! * Double(cartItem.quantity)!)
            total = total + price
            let text = cartItem.name + " " + cartItem.size + ": x" + cartItem.quantity + " $" + String(price) + "\n"
            orderDetailsTextField.text = orderDetailsTextField.text + text
            
        }
        
        totalLabel.text = "$" + String(total)
        
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        
        
        if (phoneTextField.text == "" || nameTextField.text == "" || addressTextField.text == "")
        {
            
            let alert = UIAlertController(title: "Error", message: "Please fill in your name, address and phone number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        
        }
        
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Checkout", message: "Are you sure you want to submit this order?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.performSegue(withIdentifier: "submitSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
}

