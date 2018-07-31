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
    
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    var details = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTextView.text = details
        
        CartModel.sharedInstance.clearCart()
        
        
        let smtpSession:MCOSMTPSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.port = 465
        smtpSession.username = "mail.cotton.app@gmail.com"
        smtpSession.password = "$%^SPWNM987@%er"
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        
        let builder:MCOMessageBuilder = MCOMessageBuilder()
        let from:MCOAddress = MCOAddress(displayName: "abc", mailbox: "mail.cotton.app@gmail.com")
        let to:MCOAddress = MCOAddress(displayName: nil, mailbox: "xcai004@fiu.edu")
        builder.header.from = from
        builder.header.to = [to]
        builder.header.subject = "ORDER CONFIRMATION - ID: 0001"
        builder.htmlBody = details
        let rcf822Data = builder.data()
        let sendOperation:MCOSMTPSendOperation = smtpSession.sendOperation(with: rcf822Data)
        sendOperation.start { (error) -> Void in
            if (error != nil) {
                print("Error Sending Mail : \(error)")
            }else{
                print("Mail Sent Successfully")
            }
        }
        
        
    }
    
    
    
}
