//
//  BarViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/26/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class BarViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, HasNumericKeyboard {

    let viewProperties = ViewProperties()
    // Outlets for entire VC
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var coverView: UIView!
    
    
    // Outlets for Single Drink View
    @IBOutlet weak var singleDrinkView: UIView!
    @IBOutlet weak var tabOrDrinkSC: UISegmentedControl!
    @IBOutlet weak var drinkType1SC: UISegmentedControl!
    @IBOutlet weak var drinkType2SC: UISegmentedControl!
    @IBOutlet weak var serviceRatingSC: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var faceView: UIImageView!
    
    // Outlets for Bar Tab View
    @IBOutlet weak var barTabView: UIView!
    @IBOutlet weak var tabAmountTextField: UITextField!
    @IBOutlet weak var tabTipPercentageLabel: UILabel!
    @IBOutlet weak var tabServiceRatingSC: UISegmentedControl!
    @IBOutlet weak var tabTipIncrementButton: UIButton!
    @IBOutlet weak var tabTipDecrementButton: UIButton!
    @IBOutlet weak var tabFaceView: UIImageView!
    @IBOutlet weak var tabTipAmountLabel: UILabel!
    @IBOutlet weak var tabTotalAmountLabel: UILabel!
    
    var smileView : SmileView = SmileView.init(frame: CGRectMake(6,31 , 52, 24))
    var tabSmileView : SmileView = SmileView.init(frame: CGRectMake(6,31 , 52, 24))
    var keyboardView: TipOverKeyboardView = TipOverKeyboardView()
    var tabServiceQuality: ServiceQuality = ServiceQuality.good
    var service: PercentageBasedService = PercentageBasedService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        scrollView.delegate = self
        
        // Set up the Single Drink View
        // Add the smile view
        smileView.backgroundColor = UIColor.clearColor()
        faceView.addSubview(smileView)

        view.backgroundColor = viewProperties.serviceBackgroundColor["Bar"]
        scrollView.backgroundColor = viewProperties.serviceBackgroundColor["Bar"]
        coverView.backgroundColor = viewProperties.serviceBackgroundColor["Bar"]
        barTabView.backgroundColor = viewProperties.serviceBackgroundColor["Bar"]
        singleDrinkView.backgroundColor = viewProperties.serviceBackgroundColor["Bar"]
        
        tabOrDrinkSC.selectedSegmentIndex = UISegmentedControlNoSegment
        drinkType1SC.selectedSegmentIndex = UISegmentedControlNoSegment
        drinkType2SC.selectedSegmentIndex = UISegmentedControlNoSegment
        
        self.tabOrDrinkSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Bar"]
        self.drinkType1SC.backgroundColor = viewProperties.serviceBackgroundLightColor["Bar"]
        self.drinkType2SC.backgroundColor = viewProperties.serviceBackgroundLightColor["Bar"]
        self.serviceRatingSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Bar"]
        self.serviceRatingSC.selectedSegmentIndex = 1
        smileView.updateSmile(serviceRatingSC.selectedSegmentIndex)
        
        tabOrDrinkSC.layer.cornerRadius = 3;
        tabOrDrinkSC.layer.masksToBounds = true;
        drinkType1SC.layer.cornerRadius = 3;
        drinkType1SC.layer.masksToBounds = true;
        drinkType2SC.layer.cornerRadius = 3;
        drinkType2SC.layer.masksToBounds = true;
        serviceRatingSC.layer.cornerRadius = 3;
        serviceRatingSC.layer.masksToBounds = true;
        
        
        // Set up the Bar Tab View
        tabSmileView.backgroundColor = UIColor.clearColor()
        tabFaceView.addSubview(tabSmileView)
        tabSmileView.updateSmile(tabServiceRatingSC.selectedSegmentIndex)
        
        self.tabAmountTextField.textColor = viewProperties.serviceBackgroundLightColor["Bar"]
        self.tabAmountTextField.backgroundColor = viewProperties.textBackgroundColor
        self.tabServiceRatingSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Bar"]
        
        tabServiceRatingSC.layer.cornerRadius = 3;
        tabServiceRatingSC.layer.masksToBounds = true;
        
        // Set up the text field
        tabAmountTextField.delegate = self
        
        // Set up the keyboard view
        keyboardView.setup(205, keyGap: 2, serviceType: "Bar")
        keyboardView.delegate = self
        tabAmountTextField.inputView = keyboardView
        
        // Put the views in the correct order in the view hierarchy
        arrangeViews(UISegmentedControlNoSegment)
        
    }

    override func viewDidAppear(animated: Bool) {
        
        // Update current tip values
        setTabTipPercentageFromServiceQuality()
        let billValue = Double(service.billAmount)/100.0
        tabAmountTextField.text = "$" + String(format: "%03.2f", billValue)
        
    }
    
    override func viewDidLayoutSubviews() {
        var scrollRect = UIScreen.mainScreen().bounds
        
        if scrollRect.size.height < viewProperties.iPhone5Height {
            
            // If this is an iPhone 4s, allow the view to scroll
            scrollRect.size.height = viewProperties.iPhone5Height
            scrollView.contentSize = scrollRect.size
        }
        
    }
    
    // Overall view controller actions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        //TapSound.sharedInstance.play()
        tabAmountTextField.resignFirstResponder()
        self.performSegueWithIdentifier("unwindBar", sender: self)
    }

    @IBAction func handleTabOrDrink(sender: UISegmentedControl) {
        TapSound.sharedInstance.play()
        
        arrangeViews(sender.selectedSegmentIndex)
        
        //if sender.selectedSegmentIndex == 1 {
            UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
        
                self.coverView.alpha = 0.0
        
                },
                completion: { (finished: Bool) in})
        //}
    }
    
    @IBAction func handleSettingsButton(sender: UIButton) {
        TapSound.sharedInstance.play()
        self.performSegueWithIdentifier("showSettingsFromBar", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "showSettingsFromBar" {
            let controller = segue.destinationViewController as? SettingsViewController
            controller?.myServiceType = ServiceType.Bar
        }
    }

    
    // Single Drink View Actions
    
    @IBAction func handleChooseYourDrink(sender: UISegmentedControl) {
        TapSound.sharedInstance.play()
        if sender.tag == 0 {
            drinkType2SC.selectedSegmentIndex = UISegmentedControlNoSegment
        } else {
            drinkType1SC.selectedSegmentIndex = UISegmentedControlNoSegment
        }
        
        updateTipAmount()
    }
    
    @IBAction func handleServiceRating(sender: UISegmentedControl) {
        TapSound.sharedInstance.play()
        updateTipAmount()   
    }
    
    func arrangeViews(selectedView:Int) {
        
        //print ("in arrangeViews")
        
        if selectedView == 0 {
            // Bar Tab View selected
            scrollView.bringSubviewToFront(barTabView)
            //scrollView.bringSubviewToFront(coverView)
            
            // Set the text field into editing mode to bring up the keyboard
            tabAmountTextField.becomeFirstResponder()
            //let billValue = Double(service.billAmount)/100.0
            //billAmountTextField.text = "$" + String(format: "%03.2f", billValue)
            
        } else if selectedView == 1 {
            // Single Drink View selected
            scrollView.bringSubviewToFront(singleDrinkView)
            //scrollView.bringSubviewToFront(coverView)
            tabAmountTextField.resignFirstResponder()
            
        } else if selectedView == UISegmentedControlNoSegment {
            scrollView.bringSubviewToFront(coverView)
        }
    }
    
    func updateTipAmount() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var drinkTipDefaultKey: String = String()
        
        switch drinkType1SC.selectedSegmentIndex {
        case 0:
            drinkTipDefaultKey = "Beer"
        case 1:
            drinkTipDefaultKey = "SimpleCocktail"
        case 2:
            drinkTipDefaultKey = "Wine"
        default:
            break
        }
        
        switch drinkType2SC.selectedSegmentIndex {
        case 0:
            drinkTipDefaultKey = "Shot"
        case 1:
            drinkTipDefaultKey = "FancyCocktail"
        case 2:
            drinkTipDefaultKey = "Soda"
        default:
            break
        }
        
        switch serviceRatingSC.selectedSegmentIndex {
        case 0:
            drinkTipDefaultKey = drinkTipDefaultKey + "Poor"
        case 1:
            drinkTipDefaultKey = drinkTipDefaultKey + "Good"
        case 2:
            drinkTipDefaultKey = drinkTipDefaultKey + "Amazing"
        default:
            break
        }
        
        // Update the tip amount based on the key if a drink type was chosen
        if ((drinkType1SC.selectedSegmentIndex != UISegmentedControlNoSegment) || (drinkType2SC.selectedSegmentIndex != UISegmentedControlNoSegment)) {
            tipAmountLabel.text = "$" + (defaults.stringForKey(drinkTipDefaultKey))!
        }
        smileView.updateSmile(serviceRatingSC.selectedSegmentIndex)
    }
    
    // Bar Tab View Actions
    
    func setTabTipPercentageFromServiceQuality() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var serviceQualityDefaultKey:String = String()
        
        switch tabServiceRatingSC.selectedSegmentIndex {
        case 0:
            tabServiceQuality = .poor
            serviceQualityDefaultKey = "BarPoor"
        case 1:
            tabServiceQuality = .good
            serviceQualityDefaultKey = "BarGood"
        case 2:
            tabServiceQuality = .amazing
            serviceQualityDefaultKey = "BarAmazing"
        default:
            tabServiceQuality = .good
        }
        
        service.tipPercentage = (defaults.integerForKey(serviceQualityDefaultKey))
        tabSmileView.updateSmile(tabServiceRatingSC.selectedSegmentIndex)
        updateTip()
    }
    
    func setBillAmount() {
        let tabString: String = tabAmountTextField.text!
        var billAmount: Double = (tabString as NSString).doubleValue
        billAmount = billAmount*100
        
        let tabValue = Double(billAmount)/100.0
        tabAmountTextField.text = "$" + String(format: "%03.2f", tabValue)
    }
    
    func updateTip() {
        
        tabTipAmountLabel.text = "$" + String(format: "%03.2f", service.tipAmount())
        tabTotalAmountLabel.text = "$" + String(format: "%03.2f", service.totalAmount())
        tabTipPercentageLabel.text = "\(service.tipPercentage)%"
        
    }
    
    @IBAction func handleTabServiceRatingChange(sender: UISegmentedControl) {
        TapSound.sharedInstance.play()
        setTabTipPercentageFromServiceQuality()
    }
    
    @IBAction func handleTabIncrementTipPercentage(sender: UIButton) {
        TapSound.sharedInstance.play()
        service.tipPercentage += 1
        updateTip()
    }
    
    @IBAction func handleTabDecrementTipPercentage(sender: UIButton) {
        TapSound.sharedInstance.play()
        if service.tipPercentage >= 1 {
            service.tipPercentage -= 1
            updateTip()
        }
    }
    

    
    // Has Numeric Keyboard Protocol Functions
    func handleKeyboardInput(key:Int) {
        
        if (key >= 0 && key <= 9) {
            // Numeric input
            service.billAmount = service.billAmount*10 + key
            let billValue = Double(service.billAmount)/100.0
            tabAmountTextField.text = "$" + String(format: "%03.2f", billValue)
        } else if (key == 10) {
            service.billAmount = service.billAmount / 10
            let billValue = Double(service.billAmount)/100.0
            tabAmountTextField.text = "$" + String(format: "%03.2f", billValue)
        } else if (key == 11) {
            // Done key
            setTabTipPercentageFromServiceQuality()
            tabAmountTextField.resignFirstResponder()
        }
    }
    
}
