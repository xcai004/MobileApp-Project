//
//  ListViewController.swift
//  MobileAppProject
//
//  Created by Chris Elias on 7/24/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController{
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScrollView.frame = view.frame
        // create tap gesture recognizer
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
    
        
        for i in 0..<10{
            

            
            let image = UIImageView()
            //let image = UIImage(named: "Login.png")
            image.image = #imageLiteral(resourceName: "Login")
           // image.contentMode = .scaleAspectFit
            let yPosition2 = self.view.frame.height * CGFloat(i)/3.5
           // image.frame = CGRect(x: self.myScrollView.frame.width/2, y: yPosition2, width:   self.myScrollView.frame.width/2, height: self.myScrollView.frame.height/2)
            myScrollView.contentSize.height = myScrollView.frame.height * (CGFloat(i + 1) / 3.5)
           // myScrollView.addSubview(image)
           // image.center.x = myScrollView.center.x - (myScrollView.frame.size.width * 0.045)
           // image.center.y -= myScrollView.frame.size.height * 0.175
            
            
//            // add it to the image view;
//            image.addGestureRecognizer(tapGesture)
//            // make sure imageView can be interacted with by user
//            image.isUserInteractionEnabled = true
            
            
            let button = UIButton(type: UIButtonType.custom) as UIButton
            button.frame = CGRect(x: self.myScrollView.frame.width/2, y: yPosition2, width:   self.myScrollView.frame.width/2, height: self.myScrollView.frame.height/2)
            button.setImage(image.image, for: [])
            button.imageView?.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(btnTouched), for:.touchUpInside)
            myScrollView.addSubview(button)
            button.center.x = myScrollView.center.x - (myScrollView.frame.size.width * 0.045)
            button.center.y -= myScrollView.frame.size.height * 0.175
            
            let label = UILabel(frame: CGRect(x: self.myScrollView.frame.width/2, y: yPosition2, width: 230, height: 21))
            label.textAlignment = .center
            label.text = "Cartoon T-shirt $20" + String(i)
            myScrollView.addSubview(label)
            label.center.x = myScrollView.center.x - (myScrollView.frame.size.width * 0.045)
            label.center.y -= myScrollView.frame.size.height * 0.055
        }
        
    }
    
    @objc func btnTouched() {
        // if the tapped view is a UIImageView then set it to imageview
        print("something")

    }
    
    
    
    
}

