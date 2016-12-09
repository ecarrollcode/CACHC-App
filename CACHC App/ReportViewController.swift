//
//  SecondViewController.swift
//  Child Abuse App
//
//  Created by Ed Carroll on 8/11/15.
//  Copyright (c) 2015 Ed Carroll. All rights reserved.
//

import UIKit
import Foundation

class ReportViewController: UIViewController, UIPickerViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var callOrUrlButton: UIButton!
    
    
    //MARK: Variables and Arrays
    //intialize empty string to be filled with url
    var urlString = String()
    
    //MARK Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial dial number + selection set for Tennessee
        callOrUrlButton.setTitle(HotlineData.stateInfosPhoneDict["Tennessee"], forState: UIControlState.Normal)
        statePicker.selectRow(43, inComponent: 0, animated: true)
    }
    
    //MARK Picker Functions
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
            callOrUrlButton.setTitle(HotlineData.stateInfosPhoneDict[itemSelected], forState: UIControlState.Normal)
            urlString.removeAll()
        } else if (webDictValue != nil) {
            callOrUrlButton.setTitle("See hotline list", forState: UIControlState.Normal)
            urlString = HotlineData.stateInfosWebDict[itemSelected]!
        }
    }
    
    //MARK: Actions
    @IBAction func callOrUrlButton(sender: AnyObject) {
        
        //removes special characters from string
        let charSet = NSCharacterSet(charactersInString: "1234567890").invertedSet
        let unformatted = callOrUrlButton.currentTitle
        let cleanedString = unformatted!.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
        
        //create and configure alert controller
        let alertController = UIAlertController(title: unformatted, message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        alertController.addAction(cancelAction)
        
        let CallAction = UIAlertAction(title: "Call", style: .Default) { (action) in
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://" + cleanedString)!)
        }
        alertController.addAction(CallAction)
        
        
        if (urlString.isEmpty) {
            self.presentViewController(alertController, animated: true) {
            }
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        }
    }
}
