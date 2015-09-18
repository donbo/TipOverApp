//
//  TipOverKeyboardView.swift
//  TipOver
//
//  Created by Don Wilson on 9/5/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

// Protocol that defines interface required from controllers that use this numeric keyboard
protocol HasNumericKeyboard {
    func handleKeyboardInput(key:Int)
}

class TipOverKeyboardView: UIView {

    var delegate: HasNumericKeyboard?
    
    let gap:Int = 2
    let keyboardInset:CGFloat = 167
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let viewProperties = ViewProperties()
        self.backgroundColor = viewProperties.textBackgroundColor
        
    }
    
    func setup(serviceType: String) {
        
        let viewProperties = ViewProperties()
        
        // Setup the keyboard view, based on the device size and current screen background color
        // Get the screen size of the user's device
        let screenRect = UIScreen.mainScreen().bounds
        
        self.frame = CGRectMake(0, keyboardInset, screenRect.width, screenRect.height-keyboardInset)
        
        // Determine the button heights and widths
        let buttonHeight:Int = Int((screenRect.height - 179) / 5)
        
        let buttonThirdWidth:Int = Int((screenRect.width - 8)/3)
        let buttonHalfWidth:Int = Int((screenRect.width - 6)/2)
        
        // Create the 3x3 number pad buttons
        let button1 = UIButton()
        let button2 = UIButton()
        let button3 = UIButton()
        let button4 = UIButton()
        let button5 = UIButton()
        let button6 = UIButton()
        let button7 = UIButton()
        let button8 = UIButton()
        let button9 = UIButton()
        
        let number1 = UILabel()
        let number2 = UILabel()
        let number3 = UILabel()
        let number4 = UILabel()
        let number5 = UILabel()
        let number6 = UILabel()
        let number7 = UILabel()
        let number8 = UILabel()
        let number9 = UILabel()
        
        // First row
        button7.frame = CGRectMake(CGFloat(gap), CGFloat(gap), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button8.frame = CGRectMake(CGFloat((2*gap)+buttonThirdWidth), CGFloat(gap), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button9.frame = CGRectMake(CGFloat((3*gap)+(2*buttonThirdWidth)), CGFloat(gap), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button7.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button8.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button9.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        
        button7.tag = 7
        button8.tag = 8
        button9.tag = 9
        
        button7.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button7.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        button8.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button8.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        button9.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button9.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        
        number7.text = "7"
        number7.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number7.textAlignment = NSTextAlignment.Center
        number7.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number7.textColor = viewProperties.textBackgroundColor
        button7.addSubview(number7)
        
        number8.text = "8"
        number8.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number8.textAlignment = NSTextAlignment.Center
        number8.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number8.textColor = viewProperties.textBackgroundColor
        button8.addSubview(number8)
        
        number9.text = "9"
        number9.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number9.textAlignment = NSTextAlignment.Center
        number9.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number9.textColor = viewProperties.textBackgroundColor
        button9.addSubview(number9)
        
        self.addSubview(button7)
        self.addSubview(button8)
        self.addSubview(button9)
        
        // Second row
        button4.frame = CGRectMake(CGFloat(gap), CGFloat((2*gap)+buttonHeight), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button5.frame = CGRectMake(CGFloat((2*gap)+buttonThirdWidth), CGFloat((2*gap)+buttonHeight), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button6.frame = CGRectMake(CGFloat((3*gap)+(2*buttonThirdWidth)), CGFloat((2*gap)+buttonHeight), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button4.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button5.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button6.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        
        button4.tag = 4
        button5.tag = 5
        button6.tag = 6
        
        button4.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button5.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button6.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button4.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        button5.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        button6.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        
        number4.text = "4"
        number4.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number4.textAlignment = NSTextAlignment.Center
        number4.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number4.textColor = viewProperties.textBackgroundColor
        button4.addSubview(number4)
        
        number5.text = "5"
        number5.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number5.textAlignment = NSTextAlignment.Center
        number5.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number5.textColor = viewProperties.textBackgroundColor
        button5.addSubview(number5)
        
        number6.text = "6"
        number6.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number6.textAlignment = NSTextAlignment.Center
        number6.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number6.textColor = viewProperties.textBackgroundColor
        button6.addSubview(number6)
        
        self.addSubview(button4)
        self.addSubview(button5)
        self.addSubview(button6)

        // Third row
        button1.frame = CGRectMake(CGFloat(gap), CGFloat((3*gap)+(2*buttonHeight)), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button2.frame = CGRectMake(CGFloat((2*gap)+buttonThirdWidth), CGFloat((3*gap)+(2*buttonHeight)), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button3.frame = CGRectMake(CGFloat((3*gap)+(2*buttonThirdWidth)), CGFloat((3*gap)+(2*buttonHeight)), CGFloat(buttonThirdWidth), CGFloat(buttonHeight))
        button1.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button2.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button3.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        
        button1.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button2.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button3.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button1.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        button2.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        button3.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        
        number1.text = "1"
        number1.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number1.textAlignment = NSTextAlignment.Center
        number1.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number1.textColor = viewProperties.textBackgroundColor
        button1.addSubview(number1)
        
        number2.text = "2"
        number2.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number2.textAlignment = NSTextAlignment.Center
        number2.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number2.textColor = viewProperties.textBackgroundColor
        button2.addSubview(number2)
        
        number3.text = "3"
        number3.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), CGFloat(buttonThirdWidth), 46)
        number3.textAlignment = NSTextAlignment.Center
        number3.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number3.textColor = viewProperties.textBackgroundColor
        button3.addSubview(number3)
        
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        
        // Create the full width zero button
        let button0 = UIButton()
        let number0 = UILabel()
        
        button0.frame = CGRectMake(CGFloat(gap), CGFloat((4*gap)+(3*buttonHeight)), screenRect.width-4, CGFloat(buttonHeight))
        button0.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        button0.tag = 0
        button0.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        button0.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        
        number0.text = "0"
        number0.frame = CGRectMake(0, CGFloat((buttonHeight/2)-20), screenRect.width-4, 46)
        number0.textAlignment = NSTextAlignment.Center
        number0.font = UIFont(name: "AvenirNext-Regular", size: 40)
        number0.textColor = viewProperties.textBackgroundColor
        button0.addSubview(number0)
        
        self.addSubview(button0)
        
        // Create the two keyboard action buttons (backspace and done)
        let buttonBack = UIButton()
        let buttonBackImage = UIImage(named: "KeyboardBackArrow.png")
        let buttonBackImageView = UIImageView()
        
        buttonBack.frame = CGRectMake(CGFloat(gap), CGFloat((5*gap)+(4*buttonHeight)), CGFloat(buttonHalfWidth), CGFloat(buttonHeight))
        buttonBack.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        buttonBack.tag = 10
        buttonBack.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        buttonBack.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        
        buttonBackImageView.image = buttonBackImage
        buttonBackImageView.frame = CGRectMake(CGFloat((buttonHalfWidth/2) - 34), CGFloat((buttonHeight/2)-20), 68, 38)
        
        buttonBack.addSubview(buttonBackImageView)
        self.addSubview(buttonBack)
        
        let buttonDone = UIButton()
        let buttonDoneImage = UIImage(named: "KeyboardCheck.png")
        let buttonDoneImageView = UIImageView()
        
        buttonDone.frame = CGRectMake(CGFloat(2*gap+buttonHalfWidth), CGFloat((5*gap)+(4*buttonHeight)), CGFloat(buttonHalfWidth), CGFloat(buttonHeight))
        buttonDone.backgroundColor = viewProperties.serviceBackgroundColor[serviceType]
        buttonDone.tag = 11
        buttonDone.addTarget(self, action: Selector("handleButtonTap:"), forControlEvents: .TouchUpInside)
        buttonDone.addTarget(self, action: Selector("handleButtonTouchDown:"), forControlEvents: .TouchDown)
        
        buttonDoneImageView.image = buttonDoneImage
        buttonDoneImageView.frame = CGRectMake(CGFloat((buttonHalfWidth/2) - 24), CGFloat((buttonHeight/2)-20), 48, 40)
        
        buttonDone.addSubview(buttonDoneImageView)
        self.addSubview(buttonDone)
    }
    
    func handleButtonTouchDown(sender: UIButton) {
        sender.alpha = 0.5
    }

    
    func handleButtonTap(sender: UIButton) {
        sender.alpha = 1.0
        TapSound.sharedInstance.play()
        print("in handleButtonTap ")
        delegate?.handleKeyboardInput(sender.tag)
    }
    
}
