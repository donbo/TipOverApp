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
    @IBOutlet weak var backButtonRestaurant: UIButton!
    @IBOutlet weak var settingsButtonRestaurant: UIButton!
    @IBOutlet weak var tipPercentageRestaurantLabel: UILabel!
    @IBOutlet weak var incrementTipPercentageRestaurantButton: UIButton!
    @IBOutlet weak var decrementTipPercentageRestaurantButton: UIButton!
    @IBOutlet weak var tipAmountRestaurantLabel: UILabel!
    @IBOutlet weak var totalAmountRestaurantLabel: UILabel!
    @IBOutlet weak var splitCheckRestaurantButton: UIButton!
    var mathModel: MathModel = MathModel()
    var serviceQuality: ServiceQuality = ServiceQuality.good
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipAmountRestaurantLabel.text = "\(mathModel.tipAmount())"
        totalAmountRestaurantLabel.text = "\(mathModel.totalAmount())"
        tipPercentageRestaurantLabel.text =  "\(mathModel.tipPercentage)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func setRestaurantTipPercentage() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        switch serviceQuality {
        case .poor:
            mathModel.tipPercentage = Double(defaults.integerForKey("restaurantPoor"))
        case .good:
            mathModel.tipPercentage = Double(defaults.integerForKey("restaurantGood"))
        case .amazing:
            mathModel.tipPercentage = Double(defaults.integerForKey("restaurantAmazing"))
        }
    }
    
    func updateViewFromServiceQuality() {
        setRestaurantTipPercentage()
        tipAmountRestaurantLabel.text = "\(mathModel.tipAmount())"
        totalAmountRestaurantLabel.text = "\(mathModel.totalAmount())"
        tipPercentageRestaurantLabel.text = "\(mathModel.tipPercentage)"
    }


}
