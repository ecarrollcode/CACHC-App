//
//  FourthViewController.swift
//  CACHC
//
//  Created by Ed Carroll on 9/26/15.
//  Copyright © 2015 Ed Carroll. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class ShareViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var shareApp: UIButton!
    
    
    //MARK: Actions
    @IBAction func shareApp(sender: AnyObject) {
        if MFMessageComposeViewController.canSendText() == false {
            print("Cannot send text")
            return
        }
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Help fight child abuse. " +
                         "Learn, Report, Support and Share by downloading the CACHC app: " +
                         // link to the app itself on iOS App Store
                         "https://itunes.apple.com/us/app/cachc/id1055836556?ls=1&mt=8";
        messageVC.recipients = [" "];
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: true, completion: nil)
    }
    
    //MARK: SMS Message Functions
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result) {
        case .Cancelled:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case .Failed:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case .Sent:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
