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


    //Acess user input text field
    @IBOutlet weak var orderDetailsTextField: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    //Display order total
    @IBOutlet weak var totalLabel: UILabel!
    
    //Dismiss keyboard after user pressed enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self

        //Create cart singleton
        let MyModel = CartModel.sharedInstance
        
        //used to access items in order.
        let cart = MyModel.getCart()

        //Ensure text field is initialized to empty string
        orderDetailsTextField.text = ""
        var total = 0.0;  //Holds total price of order
        
        //Go through items and get/prepare information for orderDetail text
        for cartItem in cart {
            //Get the price of each item
            let price = (Double(cartItem.price)! * Double(cartItem.quantity)!)
            
            //Add price to previous running total
            total = total + price

            //Create item string
            let text = cartItem.name + " " + cartItem.size + ": x" + cartItem.quantity + " $" + String(price) + "\n"
            
            //add item string to previous items
            orderDetailsTextField.text = orderDetailsTextField.text + text
        }
        //Display order total
        totalLabel.text = "$" + String(total)
        
    }
    


    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        
        //Simple empty string validation
        if (phoneTextField.text == "" || nameTextField.text == "" || addressTextField.text == "")
        {
            //one of the textField's is empty. Display error
            let alert = UIAlertController(title: "Error", message: "Please fill in your name, address and phone number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        
        }
        
        //Text Field validation completed successfully ask User to validate order submission
        
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

    //Send order information to OrderReviewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "submitSegue" {
           let reviewPage = segue.destination as! OrderReviewController
            
            var reviewText = "Phone: " + phoneTextField.text! + "\n"
            reviewText += "Name: " + nameTextField.text! + "\n"
            reviewText += "Address: " + addressTextField.text! + "\n"
            reviewText += orderDetailsTextField.text + "\n" + "Total: " + totalLabel.text!
            
            reviewPage.details =  reviewText
        
            
        }
        
    }
    
}

