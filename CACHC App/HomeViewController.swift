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


class HomeViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var linkToYoutube: UIButton!
    @IBOutlet weak var linkToWebsite: UIButton!

    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creates custom back bar for Report and Support pages
        let backItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    //MARK: Actions
    @IBAction func linkToYoutube(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://www.youtube.com/channel/UCenGSAyhfiYa0HaiNxyeeKQ")!)
    }

    @IBAction func linkToWebsite(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "http://www.cachc.org/services.htm")!)
    }
}

