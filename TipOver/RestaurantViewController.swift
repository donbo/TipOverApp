//
//  RestaurantViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/9/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var billAmountRestaurantTextField: UITextField!
    @IBOutlet weak var serviceRatingRestaurantSC: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tipPercentageRestaurantLabel: UILabel!
    @IBOutlet weak var incrementTipPercentageButton: UIButton!
    @IBOutlet weak var decrementTipPercentageButton: UIButton!
    @IBOutlet weak var tipAmountRestaurantLabel: UILabel!
    @IBOutlet weak var totalAmountRestaurantLabel: UILabel!
    @IBOutlet weak var splitCheckRestaurantButton: UIButton!
    @IBOutlet weak var faceView: UIImageView!
    var myServiceType: ServiceType = ServiceType.Restaurant
    var service: RestaurantService = RestaurantService()
    var serviceQuality: ServiceQuality = ServiceQuality.good
    var smileView : SmileView = SmileView.init(frame: CGRectMake(5,31 , 52, 24))
    private var coverView: UIView = UIView()
    let viewProperties = ViewProperties()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the smile view
        smileView.backgroundColor = UIColor.clearColor()
        faceView.addSubview(smileView)

        setRestaurantTipPercentageFromServiceQuality()
        
        billAmountRestaurantTextField.delegate = self
        
        tipAmountRestaurantLabel.text = "$\(service.tipAmount())"
        totalAmountRestaurantLabel.text = "$\(service.totalAmount())"
        tipPercentageRestaurantLabel.text =  "\(service.tipPercentage)%"
        coverView.backgroundColor = viewProperties.serviceBackgroundColor["Restaurant"]
        coverView.frame = self.view.frame
        coverView.frame.origin.y += 64
        
        self.view.addSubview(coverView)
    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, animations: {
            self.coverView.alpha = 0
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
   
    func setRestaurantTipPercentageFromServiceQuality() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        switch serviceRatingRestaurantSC.selectedSegmentIndex {
        case 0: serviceQuality = .poor
        case 1: serviceQuality = .good
        case 2: serviceQuality = .amazing
        default: serviceQuality = .good
        }
        
        switch serviceQuality {
        case .poor:
            service.tipPercentage = (defaults.integerForKey("restaurantPoor"))
        case .good:
            service.tipPercentage = (defaults.integerForKey("restaurantGood"))
        case .amazing:
            service.tipPercentage = (defaults.integerForKey("restaurantAmazing"))
        }
        
        smileView.updateSmile(serviceRatingRestaurantSC.selectedSegmentIndex)
        
    }
    
    func setBillAmount() {
        let billstring : String = billAmountRestaurantTextField.text!
        service.billAmount = (billstring as NSString).doubleValue
        
        //Update the text field after value entered
        billAmountRestaurantTextField.text = "$" + String(format: "%03.2f", service.billAmount)
    }
    
    func updateTip() {
        
        tipAmountRestaurantLabel.text = "$" + String(format: "%03.2f", service.tipAmount())
        totalAmountRestaurantLabel.text = "$" + String(format: "%03.2f", service.totalAmount())
        tipPercentageRestaurantLabel.text = "\(service.tipPercentage)%"
        
    }

    @IBAction func handleBackButton(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion:nil)
        self.performSegueWithIdentifier("unwindRestaurant", sender: self)
        
    }
    
    @IBAction func unwindToTipOver(sender: UIStoryboardSegue)
    {
        print("in unwindToTipOver")
    }
    
    @IBAction func handleSettingsButton(sender: AnyObject) {
        print ("in handleSettingsButton")
        self.performSegueWithIdentifier("showSettings", sender: self)
    }
    
    
    @IBAction func handleIncrementTipPercentage(sender: AnyObject) {
        service.tipPercentage += 1
        updateTip()
    }
    
    @IBAction func handleDecrementTipPercentage(sender: AnyObject) {
        if service.tipPercentage >= 1 {
            service.tipPercentage -= 1
            updateTip()
        }
        
    }
    
    
    @IBAction func handleServiceRating(sender: AnyObject) {
        setRestaurantTipPercentageFromServiceQuality()
        updateTip()
    }
    
    // Text View Delegate Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        setBillAmount()
        updateTip()
        textField.resignFirstResponder()
        return true
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.view.endEditing(true)
//    }
    
}
