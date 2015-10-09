//
//  ValetViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/26/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class ValetViewController: UIViewController {

    let viewProperties = ViewProperties()
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var carValetView: UIView!
    @IBOutlet weak var carTipAmountLabel: UILabel!
    @IBOutlet weak var carFaceView: UIImageView!
    @IBOutlet weak var carServiceQualitySC: UISegmentedControl!
    @IBOutlet weak var hotelValetView: UIView!
    @IBOutlet weak var bagDecrementButton: UIButton!
    @IBOutlet weak var bagIncrementButton: UIButton!
    @IBOutlet weak var bagCountLabel: UILabel!
    @IBOutlet weak var hotelTipAmountLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    var smileView : SmileView = SmileView.init(frame: CGRectMake(6,31 , 52, 24))
    var bagCount:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = viewProperties.serviceBackgroundColor["Valet"]

        // Add the smile view
        smileView.backgroundColor = UIColor.clearColor()
        carFaceView.addSubview(smileView)
        
        carServiceQualitySC.layer.cornerRadius = 3;
        carServiceQualitySC.layer.masksToBounds = true;
        
        carValetView.layer.cornerRadius = 5;
        carValetView.layer.masksToBounds = true;
        
        hotelValetView.layer.cornerRadius = 5;
        hotelValetView.layer.masksToBounds = true;
        
    }

    override func viewDidAppear(animated: Bool) {
        updateCarTipAmount()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.performSegueWithIdentifier("unwindValet", sender: self)
    }
    
    @IBAction func handleCarServiceQualityChange(sender: UISegmentedControl) {
        TapSound.sharedInstance.play()
        updateCarTipAmount()
    }
    
    func updateCarTipAmount() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var serviceQualityDefaultKey:String = String()
        var carTipAmount:Int = 0
        
        switch carServiceQualitySC.selectedSegmentIndex {
        case 0:
            serviceQualityDefaultKey = "CarValet" + "Poor"
        case 1:
            serviceQualityDefaultKey = "CarValet" + "Good"
        case 2:
            serviceQualityDefaultKey = "CarValet" + "Amazing"
        default:
            break
        }
        
        carTipAmount = defaults.integerForKey(serviceQualityDefaultKey)
        carTipAmountLabel.text = "$" + "\(carTipAmount)"
        
        smileView.updateSmile(carServiceQualitySC.selectedSegmentIndex)
    
    }
    
    @IBAction func handleChangeBagCount(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        if sender.tag == 0 {
            // Decrement button
            if bagCount >= 1 {
                bagCount--
            }
        } else {
            // Increment Button
            bagCount++
        }
        
        // Update bag count label
        bagCountLabel.text = "\(bagCount)"
        
        // Update tip amount label
        var tipAmount:Int = 2
        if bagCount >= 2 {
            tipAmount = tipAmount + (bagCount-1)
        }
        
        hotelTipAmountLabel.text = "$" + "\(tipAmount)"
    }
    
    @IBAction func handleSettingsButton(sender: UIButton) {
        TapSound.sharedInstance.play()
        self.performSegueWithIdentifier("showSettingsFromValet", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "showSettingsFromValet" {
            let controller = segue.destinationViewController as? SettingsViewController
            controller?.myServiceType = ServiceType.Valet
        }
    }

}
