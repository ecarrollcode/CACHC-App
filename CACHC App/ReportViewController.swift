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
        callOrUrlButton.setTitle(HotlineData.stateInfosPhoneDict["Tennessee"], for: [.normal])
        statePicker.selectRow(43, inComponent: 0, animated: true)
    }
    
    //MARK Picker Functions
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
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
            callOrUrlButton.setTitle(HotlineData.stateInfosPhoneDict[itemSelected], for: [.normal])
            urlString.removeAll()
        } else if (webDictValue != nil) {
            callOrUrlButton.setTitle("See hotline list", for: [.normal])
            urlString = HotlineData.stateInfosWebDict[itemSelected]!
        }
    }
    @IBAction func callOrUrlButton(_ sender: Any) {
        //removes special characters from string
        let charSet = CharacterSet(charactersIn: "1234567890").inverted
        let unformatted = callOrUrlButton.currentTitle
        let cleanedString = unformatted!.components(separatedBy: charSet).joined(separator: "")
        let number = URL(string: "tel://" + cleanedString)
        
        if !urlString.isEmpty {
            let url = NSURL(string: self.urlString)! as URL
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number!)
            } else {
                UIApplication.shared.openURL(number!)
            }
        }
    }
}
