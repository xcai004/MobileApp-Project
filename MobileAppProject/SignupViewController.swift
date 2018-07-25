//
//  SignupViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/24/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var SignupButton: UIButton!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SignupButton.backgroundColor = UIColor(red:0.00, green:0.60, blue:1.00, alpha:1.0)
        SignupButton.setTitleColor(UIColor.white, for: .normal)
        
        
    }
    @IBAction func SignupPressed(_ sender: Any) {
        //
        print("Tapped")
        
    }

    
    
    
    
}
