//
//  SmtpViewController.swift
//  MobileAppProject
//
//  Created by COP4655 on 7/29/18.
//  Copyright © 2018 Chris Elias. All rights reserved.
//

import Foundation
import UIKit

class SmtpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

@IBAction func SendMailPressed(_ sender: Any) {
        //
        print("Tapped")
    let smtpSession:MCOSMTPSession = MCOSMTPSession()
    smtpSession.hostname = "smtp.gmail.com"
    smtpSession.port = 465
    smtpSession.username = "mail.cotton.app@gmail.com"
    smtpSession.password = "$%^SPWNM987@%er"
    smtpSession.authType = MCOAuthType.saslPlain
    smtpSession.connectionType = MCOConnectionType.TLS

    let builder:MCOMessageBuilder = MCOMessageBuilder()
    let from:MCOAddress = MCOAddress(displayName: "abc", mailbox: "mail.cotton.app@gmail.com")
    let to:MCOAddress = MCOAddress(displayName: nil, mailbox: "ruelasjacobo@gmail.com")
    builder.header.from = from
    builder.header.to = [to]
    builder.header.subject = "My Messgae"
    builder.htmlBody = "This is test message"
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


