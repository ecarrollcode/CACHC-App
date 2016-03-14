//
//  ThirdViewController.swift
//  CACHC App
//
//  Created by Ed Carroll on 8/21/15.
//  Copyright (c) 2015 Ed Carroll. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class ThirdViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var twitButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var instaButton: UIButton!
    @IBOutlet weak var donorViewButton: UIButton!
    @IBOutlet weak var volButton: UIButton!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func twitButton(sender: AnyObject) {
        let twitURL = "twitter://user?screen_name=cachc"
        let normURL = "https://twitter.com/cachc"
        
        //checks if Twitter app is installed, and if it is not, opens url in Safari
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: twitURL)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: twitURL)!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: normURL)!)
        }
    }
    
    @IBAction func fbButton(sender: AnyObject) {
        let fbURL = "fb://profile/77355790001"
        let normURL = "https://www.facebook.com/CACofHamiltonCounty"
        
        //checks if Facebook app is installed, and if it is not, opens url in Safari
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: fbURL)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: fbURL)!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: normURL)!)
        }
    }
    
    @IBAction func instaButton(sender: AnyObject) {
        let instaURL = "instagram://user?username=childrens_advocacy_center"
        let normURL = "https://instagram.com/childrens_advocacy_center/"
        
        //checks if Instagram is installed, and if it is not, opens url in Safari
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: instaURL)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: instaURL)!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: normURL)!)
        }
    }
    
    @IBAction func donorViewButton(sender: AnyObject) {
        let donateURL = "http://bit.ly/1ikJhEY"
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: donateURL)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: donateURL)!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: donateURL)!)
        }
    }
    
    @IBAction func volButton(sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    //MARK: Email Functions
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["info@cachc.org"])
        mailComposerVC.setSubject("Volunteer")
        mailComposerVC.setMessageBody("I would like to volunteer! How do I get involved?", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}