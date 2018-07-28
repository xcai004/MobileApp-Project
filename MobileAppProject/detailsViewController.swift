//
//  detailsViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/28/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class detailsViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var quantityLabel: UILabel!
    var tshirtID: String = ""
    
    @IBOutlet weak var sizePicker: UIPickerView!
    
    
    var sizes = ["Small", "Medium", "Large", "X-Large", "2X-Large", "3X-Large" ,"4X-Large" ,"5X-Large" ,"6X-Large"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
}
