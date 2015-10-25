//
//  TipOverViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/7/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit
import AVFoundation

class TipOverViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    private var statusBarShouldHide:Bool = false
    
    private var serviceType: [String] = []
    let viewProperties = ViewProperties()
    private var explodingView: UIView = UIView()
    private var explodingLabel: UILabel = UILabel()
    private var explodingImage: UIImageView = UIImageView()
    
    private var buttons: [UIButton] = []
    private var restaurantButton: UIButton = UIButton()
    private var barButton: UIButton = UIButton()
    private var buttonPositions: [CGPoint] = []
    private var viewAppearingFromSegueUnwind: Bool = false
    private var serviceTypeIndex = 0
    
    private var openSound: NSURL = NSURL()
    private var closeSound: NSURL = NSURL()
    private var openSoundPlayer: AVAudioPlayer = AVAudioPlayer()
    private var closeSoundPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for service in ServiceType.allServiceTypes {
            serviceType.append(service.rawValue)
        }
        
        // Create the service buttons and animate them onto the screen when app is first loaded
        createButtons()
        animateButtonsIntoPosition()
        
        // Initialize this transform to a large size - 1.2, so that it can toggle back to normal position when buttons are first tapped.
        self.explodingLabel.transform = CGAffineTransformScale(explodingLabel.transform, 1.2, 1.2)
        
        openSound = NSBundle.mainBundle().URLForResource("tap-professional", withExtension: "aif")!
        do { openSoundPlayer =  try AVAudioPlayer(contentsOfURL: openSound, fileTypeHint: nil) }
        catch _ {print("open error"); return}
        
        openSoundPlayer.prepareToPlay()
        
        closeSound = NSBundle.mainBundle().URLForResource("slide-rock", withExtension: "aif")!
        do { closeSoundPlayer =  try AVAudioPlayer(contentsOfURL: closeSound, fileTypeHint: nil) }
        catch _ {return}
        
        scrollView.delegate = self
        
        closeSoundPlayer.prepareToPlay()
        
    }
    
    override func viewWillAppear(animated:Bool) {
        explodingView.removeFromSuperview()
        explodingLabel.removeFromSuperview()
        
        // Animate a shrinking view back to the button if we are returning from a service view controller
        if viewAppearingFromSegueUnwind {
            
            // Build and animate a cover view - a circle centered on the screen
            let screenRect = UIScreen.mainScreen().bounds
            let coverView: UIView = UIView()
            coverView.backgroundColor = viewProperties.serviceBackgroundColor[serviceType[serviceTypeIndex]]
            coverView.frame = CGRectMake((screenRect.width - screenRect.height)/2, 0, screenRect.height, screenRect.height)
            coverView.layer.cornerRadius = screenRect.height/2
            self.view.addSubview(coverView)
        
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1.0
                , initialSpringVelocity: 0.3, options: [], animations: {
                    coverView.frame = CGRectMake(self.buttons[self.serviceTypeIndex].frame.origin.x+140, self.buttons[self.serviceTypeIndex].frame.origin.y+20, 10, 10)
                    coverView.layer.cornerRadius = 5
                
                    //self.explodingLabel.frame = CGRectMake(141, 24, 116, 33)
                
                    // Set the target location for the label to the center of the screen
                    //self.explodingLabel.center = CGPointMake(CGFloat(screenRect.width/2), 40)
                
                    // Use a transform to animate the label size - font size is not animatable
                    //self.explodingLabel.transform = CGAffineTransformScale(self.explodingLabel.transform, 1.2, 1.2)
                
                    //self.view.backgroundColor = self.viewProperties.serviceBackgroundColor[self.serviceType[sender.tag]]
                }, completion: {
                    (finished: Bool) in
                    coverView.removeFromSuperview()
            })
            
            //closeSoundPlayer.play()
            TapSound.sharedInstance.play()
        }
        
        viewAppearingFromSegueUnwind = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return statusBarShouldHide
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
    
    func createButtons() {
        
        // Get the screen size of the user's device
        let contentSize:CGSize = scrollContentSize()
        
        
        // Set insets based on screen size
        var topButtonInset = 0
        var bottomButtonInset = 0
        var verticalButtonSpace = 0
        let totalButtonHeight = serviceType.count * viewProperties.buttonImageHeight
        
        if contentSize.height <= viewProperties.iPhone5Height {
            topButtonInset = viewProperties.topTitleBarInset
            bottomButtonInset = viewProperties.bottomInset / 2
            
            verticalButtonSpace = (Int(viewProperties.iPhone5Height) - (topButtonInset + totalButtonHeight + bottomButtonInset)) / (serviceType.count-1)
            
            //print("iPhone 5  vertSpace = \(verticalButtonSpace)")
            
        } else if contentSize.height <= viewProperties.iPhone6Height {
            topButtonInset = viewProperties.topTitleBarInset + viewProperties.topInset
            bottomButtonInset = viewProperties.bottomInset
            
            verticalButtonSpace = (Int(viewProperties.iPhone6Height) - (topButtonInset + totalButtonHeight + bottomButtonInset)) / (serviceType.count-1)
            
            //print("iPhone 6  vertSpace = \(verticalButtonSpace)")
            
        } else {
            topButtonInset = viewProperties.topTitleBarInset + viewProperties.topInset + 30
            bottomButtonInset = viewProperties.bottomInset
            
            verticalButtonSpace = (Int(viewProperties.iPhone6PlusHeight) - (topButtonInset + totalButtonHeight + bottomButtonInset)) / (serviceType.count-1)
            
            //print("iPhone 6 Plus  vertSpace = \(verticalButtonSpace)")
        }
        
        
        var buttonY: CGFloat = CGFloat(topButtonInset) - CGFloat(verticalButtonSpace)
        
        for serviceCount in 0...serviceType.count-1 {
            var buttonX: CGFloat = contentSize.width - CGFloat(viewProperties.leftInset + 180)
            let nextButton = UIButton()
            buttons.append(nextButton)
            let imageString = serviceType[serviceCount] + "Button.png"
            let buttonImage = UIImage(named: imageString)
            buttons[serviceCount].setImage(buttonImage, forState: UIControlState.Normal)
            buttons[serviceCount].setTitle(serviceType[serviceCount], forState: UIControlState.Normal)
            buttons[serviceCount].titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 20)
            buttons[serviceCount].titleLabel!.textAlignment = NSTextAlignment.Right
            buttons[serviceCount].contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right;
            
            buttons[serviceCount].imageEdgeInsets = UIEdgeInsetsMake(0.0, 114, 0.0, 0.0)
            buttons[serviceCount].titleEdgeInsets = UIEdgeInsetsMake(0, -76, 0, 76)
            
            // Set the tag so we can identify the button when it is selected
            buttons[serviceCount].tag = serviceCount
            buttons[serviceCount].addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            // Modify the final x position to make an arc
            var insetIndex = 3 - serviceCount
            if insetIndex < 0 {insetIndex = -insetIndex}
            insetIndex = 3 - insetIndex
            
            switch insetIndex {
            case 0:
                // Do nothing
                break
            case 1:
                buttonX = buttonX - 50
            case 2:
                buttonX = buttonX - 80
            case 3:
                buttonX = buttonX - 100
            default:
                // Do nothing
                break
            }
            
            let buttonPositon = CGPointMake(buttonX, buttonY)
            buttonPositions.append(buttonPositon)
            
            buttons[serviceCount].frame = CGRectMake(-180, buttonY, 180, 66)
            
            self.view.addSubview(buttons[serviceCount])
            
            buttonY = buttonY + CGFloat(verticalButtonSpace + viewProperties.buttonImageHeight)
            
        }
        
        
/*
        let xpos: CGFloat = -60
        
        var ypos: CGFloat = 100
        let image = UIImage(named: "RestaurantButton.png")
        restaurantButton.setImage(image, forState: UIControlState.Normal)
        restaurantButton.frame = CGRectMake(xpos,ypos, 180,66)
        restaurantButton.setTitle("Bar", forState: UIControlState.Normal)
        restaurantButton.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 20)
        restaurantButton.titleLabel!.textAlignment = NSTextAlignment.Right
        restaurantButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right;
        
        restaurantButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 114, 0.0, 0.0)
        restaurantButton.titleEdgeInsets = UIEdgeInsetsMake(0, -76, 0, 76)
        //restaurantButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        restaurantButton.addTarget(self, action: "handleButtonTap:", forControlEvents: UIControlEvents.TouchUpInside);
        restaurantButton.tag = 4
        self.view.addSubview(restaurantButton)
        
        ypos += 80
        let barimage = UIImage(named: "BarButton.png")
        barButton.setImage(barimage, forState: UIControlState.Normal)
        barButton.frame = CGRectMake(xpos,ypos, 66,66)
        barButton.addTarget(self, action: "handleButtonTap:", forControlEvents: UIControlEvents.TouchUpInside);
        barButton.tag = 5
        self.view.addSubview(barButton)
*/
    
    }
    
    func scrollContentSize() -> CGSize {
        var scrollRect = UIScreen.mainScreen().bounds
        
        if scrollRect.size.height < viewProperties.iPhone5Height {
            
            // If this is an iPhone 4s, allow the TipOver view to scroll, so buttons will fit
            scrollRect.size.height = viewProperties.iPhone5Height
            scrollView.contentSize = scrollRect.size
        }
        
        return scrollRect.size
    }

    
    func animateButtonsIntoPosition() {
        
        var animationDelay: Double = 0.1
        
        for serviceCount in 0...serviceType.count-1 {
            UIView.animateWithDuration(0.5, delay: animationDelay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [], animations: {
                self.buttons[serviceCount].frame.origin.x = self.buttonPositions[serviceCount].x},
                completion: { (finished: Bool) in})
            animationDelay += 0.05
        }
    }
    
        
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        
        // Set the links back to the current view controller
        switch segue.identifier! {
        case "showRestaurant":
            let controller = segue.destinationViewController as? PercentageServiceViewController
            controller?.segueFromTipOverRoot = true
            controller?.myServiceType = ServiceType.Restaurant
        case "showHairstyle":
            let controller = segue.destinationViewController as? PercentageServiceViewController
            controller?.segueFromTipOverRoot = true
            controller?.myServiceType = ServiceType.HairStyle
        case "showTaxi":
            let controller = segue.destinationViewController as? PercentageServiceViewController
            controller?.segueFromTipOverRoot = true
            controller?.myServiceType = ServiceType.Taxi
        case "showDelivery":
            let controller = segue.destinationViewController as? PercentageServiceViewController
            controller?.segueFromTipOverRoot = true
            controller?.myServiceType = ServiceType.Delivery
        case "showManicure":
            let controller = segue.destinationViewController as? PercentageServiceViewController
            controller?.segueFromTipOverRoot = true
            controller?.myServiceType = ServiceType.Manicure
        default:
            break
        }
        
    }
    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        return true
    }
    
    @IBAction func unwindToTipOver(sender: UIStoryboardSegue)
    {
        let sourceViewController = sender.sourceViewController
        
        viewAppearingFromSegueUnwind = true
        
        if sourceViewController.isKindOfClass(PercentageServiceViewController) {
            let myViewController = sourceViewController as! PercentageServiceViewController
            if myViewController.myServiceType == ServiceType.Restaurant {
                serviceTypeIndex = 0
            } else if myViewController.myServiceType == ServiceType.HairStyle {
                serviceTypeIndex = 2
            } else if myViewController.myServiceType == ServiceType.Taxi {
                serviceTypeIndex = 3
            } else if myViewController.myServiceType == ServiceType.Delivery {
                serviceTypeIndex = 4
            } else if myViewController.myServiceType == ServiceType.Manicure {
                serviceTypeIndex = 5
            }
        } else if sourceViewController.isKindOfClass(BarViewController) {
            serviceTypeIndex = 1
        } else if sourceViewController.isKindOfClass(HairstyleViewController) {
            serviceTypeIndex = 2
        } else if sourceViewController.isKindOfClass(TaxiViewController) {
            serviceTypeIndex = 3
        } else if sourceViewController.isKindOfClass(DeliveryViewController) {
            serviceTypeIndex = 4
        } else if sourceViewController.isKindOfClass(ManicureViewController) {
            serviceTypeIndex = 5
        } else if sourceViewController.isKindOfClass(ValetViewController) {
            serviceTypeIndex = 6
        }
    }

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func handleButtonTap (sender: UIButton) {
        let segueType : String = "show" + self.serviceType[sender.tag]
        
        // Get the screen size of the user's device
        let screenRect = UIScreen.mainScreen().bounds
        
        // Create a view that will expand before we make the modal transition to the new view controller. Place this view on top of the
        // button that was selected and set its color the same as the button.
        explodingView.backgroundColor = self.viewProperties.serviceBackgroundColor[self.serviceType[sender.tag]]
        explodingView.frame = CGRectMake(buttons[sender.tag].frame.origin.x+125, buttons[sender.tag].frame.origin.y+5, 55, 55)
        
        // Place a label on top of the view in order to animate it onto the new controller
        self.explodingLabel.transform = CGAffineTransformScale(explodingLabel.transform, 0.8333, 0.8333)
        let labelXPosition = self.buttons[sender.tag].frame.origin.x + viewProperties.serviceLabelXOffset[serviceType[sender.tag]]!
            self.explodingLabel.frame = CGRectMake(labelXPosition, self.buttons[sender.tag].frame.origin.y + 14, 116, 33)
        let newFont = UIFont(name: "AvenirNext-Regular", size: 20)
        self.explodingLabel.font = newFont
        self.explodingLabel.textColor = UIColor.whiteColor()
        self.explodingLabel.text = self.serviceType[sender.tag]
        self.explodingLabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(explodingView)
        self.view.addSubview(explodingLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0
            , initialSpringVelocity: 0.3, options: [], animations: {
            self.explodingView.frame = self.view.frame
            //self.explodingLabel.frame = CGRectMake(141, 24, 116, 33)
            
            // Set the target location for the label to the center of the screen
            self.explodingLabel.center = CGPointMake(CGFloat(screenRect.width/2), 40)
            
            // Use a transform to animate the label size - font size is not animatable
            self.explodingLabel.transform = CGAffineTransformScale(self.explodingLabel.transform, 1.2, 1.2)
            
            }, completion: {
                (finished: Bool) in
                self.performSegueWithIdentifier(segueType, sender: self)
        })
        
        TapSound.sharedInstance.play()

    }
    
    // UIScrollView delegate functions
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // Remove the status bar from the screen when scrolling on an iPhone 4s
        if scrollView.contentOffset == CGPointZero {
            statusBarShouldHide = false
        } else {
            statusBarShouldHide = true
        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
}


