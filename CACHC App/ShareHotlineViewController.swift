//
//  FifthViewController.swift
//  CACHC
//
//  Created by Ed Carroll on 9/26/15.
//  Copyright © 2015 Ed Carroll. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class ShareHotlineViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var sendHotline: UIButton!
    
    //MARK: Variables
    // intialize empty string to be filled with number or url
    var numOrUrlString = String(),
        messageText = String()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial dial number + selection set for Tennessee
        messageText = "Call this number to report child abuse in the state of Tennessee: " +
                      HotlineData.stateInfosPhoneDict["Tennessee"]!;
        sendHotline.setTitle("Send hotline number", forState: UIControlState.Normal)
        statePicker.selectRow(43, inComponent: 0, animated: true)
    }
    
    
    //MARK: Picker Function
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HotlineData.stateNames.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HotlineData.stateNames[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemSelected = HotlineData.stateNames[row]
        let phoneDictValue = HotlineData.stateInfosPhoneDict[itemSelected]
        let webDictValue = HotlineData.stateInfosWebDict[itemSelected]
        
        if (phoneDictValue != nil) {
            //accounts for special cases of DC and Puerto Rico
            if itemSelected == "District of Columbia" {
                messageText = "Call this number to report child abuse in the District of Columbia: " + phoneDictValue!;
                sendHotline.setTitle("Send hotline number", forState: UIControlState.Normal)
            } else if itemSelected == "Puerto Rico" {
                messageText = "Call this number to report child abuse in Puerto Rico: " + phoneDictValue!;
                sendHotline.setTitle("Send hotline number", forState: UIControlState.Normal)
            } else {
                messageText = "Call this number to report child abuse in the state of " +
                              itemSelected + ": " + phoneDictValue!;
                sendHotline.setTitle("Send hotline number", forState: UIControlState.Normal)
            }
        } else if (webDictValue != nil) {
            messageText = "Follow this link for a list of hotlines to report child abuse in the state of " +
                          itemSelected + ": " + webDictValue!
            sendHotline.setTitle("Send hotline list", forState: UIControlState.Normal)
        }
    }

    //MARK: Actions
    @IBAction func sendHotline(sender: AnyObject) {
        if MFMessageComposeViewController.canSendText() == false {
            print("Cannot send text")
            return
        }
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = messageText;
        messageVC.recipients = [" "];
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: false, completion: nil)
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
