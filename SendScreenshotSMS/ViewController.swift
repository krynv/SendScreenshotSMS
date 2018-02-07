//
//  ViewController.swift
//  SendScreenshotSMS
//
//  Created by Vitaliy Krynytskyy on 07/02/2018.
//  Copyright © 2018 Vitaliy Krynytskyy. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func smsButtonPressed(_ sender: UIButton) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if MFMessageComposeViewController.canSendText() && MFMessageComposeViewController.canSendAttachments() {

            let smsController = MFMessageComposeViewController()
            
            smsController.body = "Can you please tell me what colour this is?"
            let screenshotImageData: Data = UIImagePNGRepresentation(screenshotImage!)!
            smsController.addAttachmentData(screenshotImageData, typeIdentifier: "data", filename: "screenshotImage.png")
            smsController.messageComposeDelegate = self
            self.present(smsController, animated: true, completion: nil)
            
            
        } else {
            print("User cannot send texts or attachments")
        }
    }
    
    
}

