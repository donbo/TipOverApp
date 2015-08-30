//
//  ServiceType.swift
//  TipOver
//
//  Created by Don Wilson on 8/9/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import Foundation

enum ServiceType: String {
    case    Restaurant = "Restaurant",
    Bar = "Bar",
    HairStyle = "Hairstyle",
    Taxi = "Taxi",
    Delivery = "Delivery",
    Manicure = "Manicure",
    Other = "Other"

    
    static let allServiceTypes = [Restaurant, Bar, HairStyle, Taxi, Delivery, Manicure, Other]
}



