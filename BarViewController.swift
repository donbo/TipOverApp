//
//  BarViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/26/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class BarViewController: UIViewController {

    let viewProperties = ViewProperties()
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = viewProperties.serviceBackgroundColor["Bar"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.performSegueWithIdentifier("unwindBar", sender: self)
    }

}
