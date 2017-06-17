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
    @IBAction func shareApp(_ sender: Any) {
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
        
        self.present(messageVC, animated: true, completion: nil)
    }
    
    //MARK: SMS Message Functions
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
