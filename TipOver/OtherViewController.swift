//
//  OtherViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/26/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    let viewProperties = ViewProperties()
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = viewProperties.serviceBackgroundColor["Other"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.performSegueWithIdentifier("unwindOther", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
