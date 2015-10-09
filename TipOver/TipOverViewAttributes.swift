//
//  TipOverViewAttributes.swift
//  TipOver
//
//  Created by Don Wilson on 8/9/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import Foundation
import UIKit

struct ViewProperties {
    let backgroundColor = UIColor.init(red:0.404, green:0.404, blue:0.839, alpha:1)
    let backgroundColorLight = UIColor.init(red:0.444, green:0.444, blue:0.924, alpha:1)
    let highlightColor = UIColor.init(red:0.38, green:0.38, blue:0.77, alpha:1)
    let textBackgroundColor = UIColor.init(red:0.290, green:0.227, blue:0.549, alpha:1)
    
    let serviceBackgroundColor: [String : UIColor] =
    ["Restaurant" : UIColor.init(red:0.282, green:0.804, blue:0.686, alpha:1),
    "Bar" : UIColor.init(red:0.984, green:0.294, blue:0.224, alpha:1),
    "Hairstyle" : UIColor.init(red:0.847, green:0.698, blue:0.373, alpha:1),
    "Taxi" : UIColor.init(red:0.612, green:0.702, blue:0.396, alpha:1),
    "Delivery" : UIColor.init(red:0.992, green:0.604, blue:0.247, alpha:1),
    "Manicure" : UIColor.init(red:0.984, green:0.345, blue:0.475, alpha:1),
    "Valet" : UIColor.init(red:0.349, green:0.733, blue:0.918, alpha:1)]
    
    let serviceBackgroundLightColor: [String : UIColor] =
    ["Restaurant" : UIColor.init(red:0.282, green:0.804, blue:0.686, alpha:1),
        "Bar" : UIColor.init(red:0.99, green:0.38, blue:0.29, alpha:1),
        "Hairstyle" : UIColor.init(red:0.9, green:0.88, blue:0.46, alpha:1),
        "Taxi" : UIColor.init(red:0.77, green:0.88, blue:0.51, alpha:1),
        "Delivery" : UIColor.init(red:0.992, green:0.77, blue:0.33, alpha:1),
        "Manicure" : UIColor.init(red:0.984, green:0.55, blue:0.69, alpha:1),
        "Valet" : UIColor.init(red:0.46, green:0.9, blue:0.98, alpha:1)]
    
    let serviceLabelXOffset: [String : CGFloat] =
    ["Restaurant" : -1,
        "Bar" : 31,
        "Hairstyle" : 8,
        "Taxi" : 30,
        "Delivery" : 10,
        "Manicure" : 5,
        "Valet" : 21]
    
    let topTitleBarInset = 64
    let topInset = 20
    let bottomInset = 30
    let leftInset = 30
    let leftMaximumInset = 140
    
    let iPhone5Height: CGFloat = 568.0
    let iPhone6Height: CGFloat = 667.0
    let iPhone6PlusHeight: CGFloat = 736.0
    let buttonImageHeight:Int = 66
    
    init () {
        
    }
}
