//
//  ManicureViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/9/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class ManicureViewController: UIViewController {

    let viewProperties = ViewProperties()
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = viewProperties.serviceBackgroundColor["Manicure"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    @IBAction func handleBackButton(sender: UIButton) {
        self.performSegueWithIdentifier("unwindManicure", sender: self)
    }


}
