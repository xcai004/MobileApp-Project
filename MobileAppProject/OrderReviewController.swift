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
    
    //Used to display order summary before final submittion
    @IBOutlet weak var detailsTextView: UITextView!
    
    //Will hold order summary text updated via prepare segue from
    //checkoutView
    var details = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTextView.text = details   //transfer received text to textView
        
        CartModel.sharedInstance.clearCart() //remove items from cart
        
        //Set SMTP connection settings
        let smtpSession:MCOSMTPSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.port = 465
        smtpSession.username = "mail.cotton.app@gmail.com"
        //FUTURE-Encryp username and password
        smtpSession.password = "$%^SPWNM987@%er"
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        
        //Create E-mail Message
        let builder:MCOMessageBuilder = MCOMessageBuilder()
        let from:MCOAddress = MCOAddress(displayName: "abc", mailbox: "mail.cotton.app@gmail.com")
        let to:MCOAddress = MCOAddress(displayName: nil, mailbox: "xcai004@fiu.edu")
        builder.header.from = from
        builder.header.to = [to]
        builder.header.subject = "ORDER CONFIRMATION - ID: 0001"
        builder.htmlBody = details
        let rcf822Data = builder.data()
        let sendOperation:MCOSMTPSendOperation = smtpSession.sendOperation(with: rcf822Data)
        
        //Send the Email
        sendOperation.start { (error) -> Void in
            if (error != nil) {
                print("Error Sending Mail : \(error)")
            }else{
                print("Mail Sent Successfully")
            }
        }
        
        
    }
    
    
    
}
