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
        sendHotline.setTitle("Send hotline number", for: [.normal])
        statePicker.selectRow(43, inComponent: 0, animated: true)
    }
    
    
    //MARK: Picker Function
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HotlineData.stateNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HotlineData.stateNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemSelected = HotlineData.stateNames[row]
        let phoneDictValue = HotlineData.stateInfosPhoneDict[itemSelected]
        let webDictValue = HotlineData.stateInfosWebDict[itemSelected]
        
        if (phoneDictValue != nil) {
            //accounts for special cases of DC and Puerto Rico
            if itemSelected == "District of Columbia" {
                messageText = "Call this number to report child abuse in the District of Columbia: " + phoneDictValue!;
                sendHotline.setTitle("Send hotline number", for: [])
            } else if itemSelected == "Puerto Rico" {
                messageText = "Call this number to report child abuse in Puerto Rico: " + phoneDictValue!;
                sendHotline.setTitle("Send hotline number", for: [])
            } else {
                messageText = "Call this number to report child abuse in the state of " +
                              itemSelected + ": " + phoneDictValue!;
                sendHotline.setTitle("Send hotline number", for: [])
            }
        } else if (webDictValue != nil) {
            messageText = "Follow this link for a list of hotlines to report child abuse in the state of " +
                          itemSelected + ": " + webDictValue!
            sendHotline.setTitle("Send hotline list", for: [])
        }
    }

    //MARK: Actions
    @IBAction func sendHotline(_ sender: Any) {
        if MFMessageComposeViewController.canSendText() == false {
            print("Cannot send text")
            return
        }
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = messageText;
        messageVC.recipients = [" "];
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
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
