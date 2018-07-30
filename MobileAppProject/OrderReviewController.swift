//
//  OrderReviewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/29/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class OrderReviewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CartModel.sharedInstance.clearCart()
    }
    
    
    
}
