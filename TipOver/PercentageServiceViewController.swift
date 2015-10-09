//
//  PercentageServiceViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/9/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class PercentageServiceViewController: UIViewController, UITextFieldDelegate, HasNumericKeyboard {
    
    
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var amountTextFieldLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var serviceRatingSC: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var incrementTipPercentageButton: UIButton!
    @IBOutlet weak var decrementTipPercentageButton: UIButton!
    var tipAmountLabel: UILabel = UILabel()
    var tipAmountServiceLabel: UILabel = UILabel()
    var totalAmountLabel: UILabel = UILabel()
    var totalAmountServiceLabel: UILabel = UILabel()
    @IBOutlet weak var splitCheckButton: UIButton!
    @IBOutlet weak var faceView: UIImageView!
    var myServiceType: ServiceType = ServiceType.Restaurant
    var service: PercentageBasedService = PercentageBasedService()
    var serviceQuality: ServiceQuality = ServiceQuality.good
    var smileView : SmileView = SmileView.init(frame: CGRectMake(6,31 , 52, 24))
    private var coverView: UIView = UIView()
    let viewProperties = ViewProperties()
    var keyboardView: TipOverKeyboardView = TipOverKeyboardView()
    var segueFromTipOverRoot: Bool = false
    var splitCheckActive: Bool = false
    var space1:CGFloat = 32.0
    var space2:CGFloat = 80.0
    var space3:CGFloat = 112.0
    var numberInPartyQuantity: UILabel = UILabel()
    var totalEachQuantity: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the smile view
        smileView.backgroundColor = UIColor.clearColor()
        faceView.addSubview(smileView)
        
        serviceRatingSC.layer.cornerRadius = 3;
        serviceRatingSC.layer.masksToBounds = true;

        // Add the tip amount and total amount labels
        // These are added programatically so they can be adjusted to screen size, and animated for a split check
        // Lack of constraints makes this easier
        addTotalLabels()
        
        setTipPercentageFromServiceQuality()
        
        billAmountTextField.delegate = self
        billAmountTextField.clearsOnBeginEditing = false
        
        tipAmountServiceLabel.text = "$" + String(format: "%03.2f", service.tipAmount())
        totalAmountServiceLabel.text = "$" + String(format: "%03.2f", service.totalAmount())
        tipPercentageLabel.text =  "\(service.tipPercentage)%"
        coverView.frame = self.view.frame
        coverView.frame.origin.y += 64
        
        self.view.addSubview(coverView)
        
        
        // Set up characteristics based on the service type
        switch myServiceType {
        case ServiceType.Restaurant:
                self.coverView.backgroundColor = self.viewProperties.serviceBackgroundColor["Restaurant"]
                self.view.backgroundColor = self.viewProperties.serviceBackgroundColor["Restaurant"]
                keyboardView.setup(167, keyGap: 2, serviceType: "Restaurant")
        case ServiceType.HairStyle:
            self.serviceTypeLabel.text = "Hairstyle"
            self.amountTextFieldLabel.text = "Bill Amount"
            self.coverView.backgroundColor = self.viewProperties.serviceBackgroundColor["Hairstyle"]
            self.view.backgroundColor = self.viewProperties.serviceBackgroundColor["Hairstyle"]
            keyboardView.setup(167, keyGap: 2, serviceType: "Hairstyle")
            self.splitCheckButton.setTitle(" ", forState: UIControlState.Normal)
            self.splitCheckButton.enabled = false
            self.serviceRatingSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Hairstyle"]
            self.billAmountTextField.textColor = viewProperties.serviceBackgroundLightColor["Hairstyle"]
        case ServiceType.Taxi:
            self.serviceTypeLabel.text = "Taxi"
            self.amountTextFieldLabel.text = "Fare Amount"
            self.coverView.backgroundColor = self.viewProperties.serviceBackgroundColor["Taxi"]
            self.view.backgroundColor = self.viewProperties.serviceBackgroundColor["Taxi"]
            keyboardView.setup(167, keyGap: 2, serviceType: "Taxi")
            self.splitCheckButton.setTitle("Split Fare", forState: UIControlState.Normal)
            self.serviceRatingSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Taxi"]
            self.billAmountTextField.textColor = viewProperties.serviceBackgroundLightColor["Taxi"]
        case ServiceType.Delivery:
            self.serviceTypeLabel.text = "Delivery"
            self.amountTextFieldLabel.text = "Bill Amount"
            self.coverView.backgroundColor = self.viewProperties.serviceBackgroundColor["Delivery"]
            self.view.backgroundColor = self.viewProperties.serviceBackgroundColor["Delivery"]
            keyboardView.setup(167, keyGap: 2, serviceType: "Delivery")
            self.splitCheckButton.setTitle("Split Bill", forState: UIControlState.Normal)
            //self.splitCheckButton.enabled = false
            self.serviceRatingSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Delivery"]
            self.billAmountTextField.textColor = viewProperties.serviceBackgroundLightColor["Delivery"]
        case ServiceType.Manicure:
            self.serviceTypeLabel.text = "Manicure"
            self.amountTextFieldLabel.text = "Bill Amount"
            self.coverView.backgroundColor = self.viewProperties.serviceBackgroundColor["Manicure"]
            self.view.backgroundColor = self.viewProperties.serviceBackgroundColor["Manicure"]
            keyboardView.setup(167, keyGap: 2, serviceType: "Manicure")
            self.splitCheckButton.setTitle(" ", forState: UIControlState.Normal)
            self.splitCheckButton.enabled = false
            self.serviceRatingSC.backgroundColor = viewProperties.serviceBackgroundLightColor["Manicure"]
            self.billAmountTextField.textColor = viewProperties.serviceBackgroundLightColor["Manicure"]
        default:
            break
        }
        
        // Set up the rest of the keyboard view
        keyboardView.delegate = self
        billAmountTextField.inputView = keyboardView

    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, animations: {
            self.coverView.alpha = 0
        })
        
        if segueFromTipOverRoot {
            // Set the text field into editing mode to bring up the keyboard
            billAmountTextField.becomeFirstResponder()
            let billValue = Double(service.billAmount)/100.0
            billAmountTextField.text = "$" + String(format: "%03.2f", billValue)
            segueFromTipOverRoot = false
        }
        
        setTipPercentageFromServiceQuality()
        updateTip()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
   
    func setTipPercentageFromServiceQuality() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var serviceQualityDefaultKey:String = String()
        
        switch serviceRatingSC.selectedSegmentIndex {
        case 0:
            serviceQuality = .poor
            serviceQualityDefaultKey = self.serviceTypeLabel.text! + "Poor"
        case 1:
            serviceQuality = .good
            serviceQualityDefaultKey = self.serviceTypeLabel.text! + "Good"
        case 2:
            serviceQuality = .amazing
            serviceQualityDefaultKey = self.serviceTypeLabel.text! + "Amazing"
        default:
            serviceQuality = .good
        }
        
        service.tipPercentage = (defaults.integerForKey(serviceQualityDefaultKey))
        smileView.updateSmile(serviceRatingSC.selectedSegmentIndex)
        
    }
    
    func setBillAmount() {
        let billstring : String = billAmountTextField.text!
        let billAmount:Double = (billstring as NSString).doubleValue
        service.billAmount = Int(billAmount*100)
        
        //Update the text field after value entered
        let billValue = Double(service.billAmount)/100.0
        billAmountTextField.text = "$" + String(format: "%03.2f", billValue)
    }
    
    func updateTip() {
        
        tipAmountServiceLabel.text = "$" + String(format: "%03.2f", service.tipAmount())
        totalAmountServiceLabel.text = "$" + String(format: "%03.2f", service.totalAmount())
        tipPercentageLabel.text = "\(service.tipPercentage)%"
        
        if splitCheckActive {
            updateSplitCheckAmount()    
        }
        
    }
    
    func addTotalLabels() {
        let screenRect = UIScreen.mainScreen().bounds
        var yOffset:CGFloat = 0.0
        var space1:CGFloat = 32.0
        var space2:CGFloat = 80.0
        var space3:CGFloat = 112.0
        
        if (screenRect.height >= viewProperties.iPhone6PlusHeight) {
            yOffset = 0.6
        } else if (screenRect.height >= viewProperties.iPhone6Height) {
            yOffset = 0.6
        } else if (screenRect.height >= viewProperties.iPhone5Height) {
            yOffset = 0.65
            space1 = 28.0
            space2 = 70.0
            space3 = 98.0
        } else {
            yOffset = 0.75
        }
        
        let centerFrame:CGFloat = screenRect.width/2
        let initialY:CGFloat = screenRect.height * yOffset
        let labelWidth:CGFloat = 150.0
        let labelHeight:CGFloat = 50.0
        
        // Add tip labels
        tipAmountLabel.text = "Tip Amount"
        let labelFont = UIFont(name: "AvenirNext-Regular", size: 20)
        tipAmountLabel.font = labelFont
        tipAmountLabel.textAlignment = NSTextAlignment.Center
        tipAmountLabel.textColor = UIColor.whiteColor()
        tipAmountLabel.frame = CGRectMake((centerFrame - labelWidth/2.0), initialY, labelWidth, labelHeight)
        self.view.addSubview(tipAmountLabel)
    
        tipAmountServiceLabel.text = "$0.00"
        let labelBigFont = UIFont(name: "AvenirNext-Regular", size: 32)
        tipAmountServiceLabel.font = labelBigFont
        tipAmountServiceLabel.textAlignment = NSTextAlignment.Center
        tipAmountServiceLabel.textColor = viewProperties.textBackgroundColor
        tipAmountServiceLabel.frame = CGRectMake(tipAmountLabel.frame.origin.x, initialY + space1, labelWidth, labelHeight)
        self.view.addSubview(tipAmountServiceLabel)
        
        // Add total labels
        totalAmountLabel.text = "Total Amount"
        totalAmountLabel.font = labelFont
        totalAmountLabel.textAlignment = NSTextAlignment.Center
        totalAmountLabel.textColor = UIColor.whiteColor()
        totalAmountLabel.frame = CGRectMake((centerFrame - labelWidth/2.0), initialY + space2, labelWidth, labelHeight)
        self.view.addSubview(totalAmountLabel)
        
        totalAmountServiceLabel.text = "$0.00"
        totalAmountServiceLabel.font = labelBigFont
        totalAmountServiceLabel.textAlignment = NSTextAlignment.Center
        totalAmountServiceLabel.textColor = viewProperties.textBackgroundColor
        totalAmountServiceLabel.frame = CGRectMake(tipAmountLabel.frame.origin.x, initialY + space3, labelWidth, labelHeight)
        self.view.addSubview(totalAmountServiceLabel)
        
    }

    @IBAction func handleBackButton(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion:nil)
        self.performSegueWithIdentifier("unwindRestaurant", sender: self)
        
        // Resign the keyboard first responder, in case the keyboard is displayed.  
        billAmountTextField.resignFirstResponder()
    }
    
    @IBAction func unwindToTipOver(sender: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func handleSettingsButton(sender: AnyObject) {
        TapSound.sharedInstance.play()
        self.performSegueWithIdentifier("showSettings", sender: self)
    }
    
    
    @IBAction func handleIncrementTipPercentage(sender: AnyObject) {
        
        TapSound.sharedInstance.play()
        
        service.tipPercentage += 1
        updateTip()
    }
    
    @IBAction func handleDecrementTipPercentage(sender: AnyObject) {
        
        TapSound.sharedInstance.play()
        
        if service.tipPercentage >= 1 {
            service.tipPercentage -= 1
            updateTip()
        }
        
    }
    
    
    @IBAction func handleServiceRating(sender: AnyObject) {
        
        TapSound.sharedInstance.play()
        
        setTipPercentageFromServiceQuality()
        updateTip()
    }
    
    // Text View Protocol Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        setBillAmount()
        updateTip()
        textField.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "showSettings" {
            let controller = segue.destinationViewController as? SettingsViewController
            controller?.myServiceType = myServiceType
        }
    }
    
    @IBAction func handleSplitCheck(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        let screenRect = UIScreen.mainScreen().bounds
        
        // Don't add split check labels if button already selected
        if !splitCheckActive {

            // Set split check indicator to true
            splitCheckActive = true
            
            // Create new labels and buttons
            let numberInPartyLabel: UILabel = UILabel()
            var frame1: CGRect = tipAmountLabel.frame
            numberInPartyLabel.text = "Number in Party"
            var labelFont = UIFont(name: "AvenirNext-Regular", size: 20)
            numberInPartyLabel.font = labelFont
            numberInPartyLabel.textAlignment = NSTextAlignment.Center
            numberInPartyLabel.textColor = UIColor.whiteColor()
            numberInPartyLabel.frame = CGRectMake(-150, frame1.origin.y, 150, frame1.height)
            self.view.addSubview(numberInPartyLabel)
            
            service.partySize = 1
            frame1 = tipAmountServiceLabel.frame
            numberInPartyQuantity.text = "1"
            labelFont = UIFont(name: "AvenirNext-Regular", size: 32)
            numberInPartyQuantity.font = labelFont
            numberInPartyQuantity.textAlignment = NSTextAlignment.Center
            numberInPartyQuantity.textColor = viewProperties.textBackgroundColor
            numberInPartyQuantity.frame = CGRectMake(-150, frame1.origin.y, 150, frame1.height)
            self.view.addSubview(numberInPartyQuantity)
            
            let numberInPartyDecrementButton = UIButton()
            let decrementImage = UIImage(named: "BackArrowDark.png")
            let decrementImageView = UIImageView()
            decrementImageView.image = decrementImage
            decrementImageView.frame = CGRectMake(CGFloat(0), CGFloat(12), 15, 25)
            
            numberInPartyDecrementButton.frame = CGRectMake(CGFloat(numberInPartyQuantity.frame.origin.x), CGFloat(numberInPartyQuantity.frame.origin.y), CGFloat(33.0), CGFloat(33.0))
            numberInPartyDecrementButton.tag = 1
            numberInPartyDecrementButton.addTarget(self, action: Selector("handlePartySizeChange:"), forControlEvents: .TouchUpInside)
            
            numberInPartyDecrementButton.addSubview(decrementImageView)
            self.view.addSubview(numberInPartyDecrementButton)
            
            let numberInPartyIncrementButton = UIButton()
            let incrementImage = UIImage(named: "ForwardArrowDark.png")
            let incrementImageView = UIImageView()
            incrementImageView.image = incrementImage
            incrementImageView.frame = CGRectMake(CGFloat(0), CGFloat(12), 15, 25)
            
            numberInPartyIncrementButton.frame = CGRectMake(CGFloat(numberInPartyQuantity.frame.origin.x), CGFloat(numberInPartyQuantity.frame.origin.y), CGFloat(33.0), CGFloat(33.0))
            numberInPartyIncrementButton.tag = 2
            numberInPartyIncrementButton.addTarget(self, action: Selector("handlePartySizeChange:"), forControlEvents: .TouchUpInside)
            
            numberInPartyIncrementButton.addSubview(incrementImageView)
            self.view.addSubview(numberInPartyIncrementButton)
            
            let totalEachLabel: UILabel = UILabel()
            var frame2: CGRect = totalAmountLabel.frame
            totalEachLabel.text = "Total per Person"
            labelFont = UIFont(name: "AvenirNext-Regular", size: 20)
            totalEachLabel.font = labelFont
            totalEachLabel.textAlignment = NSTextAlignment.Center
            totalEachLabel.textColor = UIColor.whiteColor()
            totalEachLabel.frame = CGRectMake(-150, frame2.origin.y, 150, frame2.height)
            self.view.addSubview(totalEachLabel)
            

            frame2 = totalAmountServiceLabel.frame
            totalEachQuantity.text = totalAmountServiceLabel.text
            labelFont = UIFont(name: "AvenirNext-Regular", size: 32)
            totalEachQuantity.font = labelFont
            totalEachQuantity.textAlignment = NSTextAlignment.Center
            totalEachQuantity.textColor = viewProperties.textBackgroundColor
            totalEachQuantity.frame = CGRectMake(-150, frame2.origin.y, 150, frame2.height)
            service.splitPay = Int(service.totalAmount()*100)
            self.view.addSubview(totalEachQuantity)
            
            // Animate new labels and buttons onto screen, also moving Tip Amount and Total Amount
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [], animations: {
                
                self.tipAmountLabel.center = CGPointMake(CGFloat(screenRect.width * 0.75), self.tipAmountLabel.center.y)
                self.tipAmountServiceLabel.center.x = CGFloat(screenRect.width * 0.75)
                self.totalAmountLabel.center.x = CGFloat(screenRect.width * 0.75)
                self.totalAmountServiceLabel.center.x = CGFloat(screenRect.width * 0.75)
                
                },
                completion: { (finished: Bool) in})
            
            // Animate new labels and buttons onto screen, also moving Tip Amount and Total Amount
            UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [], animations: {
                numberInPartyLabel.center.x = CGFloat(screenRect.width/3.8)
                self.numberInPartyQuantity.center.x = CGFloat(screenRect.width/3.8)
                totalEachLabel.center.x = CGFloat(screenRect.width/3.8)
                self.totalEachQuantity.center.x = CGFloat(screenRect.width/3.8)
                numberInPartyDecrementButton.center.x = CGFloat((screenRect.width/3.8) - 40)
                numberInPartyIncrementButton.center.x = CGFloat((screenRect.width/3.8) + 58)
                },
                completion: { (finished: Bool) in})
        }
    }
    
    // Has Numeric Keyboard Protocol Functions
    func handleKeyboardInput(key:Int) {
        if (key >= 0 && key <= 9) {
            // Numeric input
            service.billAmount = service.billAmount*10 + key
            let billValue = Double(service.billAmount)/100.0
            billAmountTextField.text = "$" + String(format: "%03.2f", billValue)
        } else if (key == 10) {
            service.billAmount = service.billAmount / 10
            let billValue = Double(service.billAmount)/100.0
            billAmountTextField.text = "$" + String(format: "%03.2f", billValue)
        } else if (key == 11) {
            // Done key
            updateTip()
            billAmountTextField.resignFirstResponder()
        }
    }
    
    
    // Handle split check actions
    func handlePartySizeChange(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        if sender.tag == 1 {
            if service.partySize > 1 {
                service.partySize--
                numberInPartyQuantity.text = ("\(service.partySize)")
            }
        } else if sender.tag == 2 {
            service.partySize++
            numberInPartyQuantity.text = ("\(service.partySize)")
        }
        
        updateSplitCheckAmount()
        
    }
    
    func updateSplitCheckAmount() {
        
        let splitInt:Int = Int((service.totalAmount() / Double(service.partySize))*100)
        var splitValue:Double = Double(splitInt/100)
        
        // The split total must equal or exceed the total amount
        while (splitValue * Double(service.partySize) < service.totalAmount()) {
            splitValue = splitValue + 0.0075
        }
        totalEachQuantity.text = "$" + String(format: "%03.2f", splitValue)
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.view.endEditing(true)
//    }
    
}
