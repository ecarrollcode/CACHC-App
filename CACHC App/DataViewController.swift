//
//  DataViewController.swift
//  Child Abuse App
//
//  Created by Ed Carroll on 5/21/15.
//  Copyright (c) 2015 Ed Carroll. All rights reserved.
//

import UIKit
import MessageUI
import Foundation


class DataViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var linkToYoutube: UIButton!
    @IBOutlet weak var linkToWebsite: UIButton!

    
    //MARK: Variables
    //called in ModelController.swift
    var dataObject: AnyObject?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creates custom back bar for Report and Support pages
        let backItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    //MARK: Actions
    @IBAction func linkToYoutube(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.youtube.com/channel/UCenGSAyhfiYa0HaiNxyeeKQ")!)
    }

    @IBAction func linkToWebsite(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.cachc.org/services.htm")!)
    }
}

