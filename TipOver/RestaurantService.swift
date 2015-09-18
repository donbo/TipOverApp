//
//  mathModel.swift
//  TipOver
//
//  Created by Kyle Barker on 8/10/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import Foundation

class RestaurantService {
    var billAmount: Int
    var tipPercentage: Int
    var partySize: Int
    var splitPay: Int
    
    init() {
        billAmount = 0
        tipPercentage = 0
        partySize = 1
        splitPay = 0
    }
    
    func tipAmount() -> Double {
        return (Double(billAmount)/100.0) * (Double(tipPercentage)/100.0)
    }
    
    func totalAmount() -> Double {
        return (Double(billAmount)/100.0) + tipAmount()
    }
    
    func splitAmount() -> Double {
        if partySize == 1 {
            return self.totalAmount()
        } else {
            return (self.totalAmount()/Double(partySize))
        }
    }
    
    func decrementPartySize() -> Int {
        if partySize > 1 {
        partySize = partySize - 1
        }
        return partySize
    }
    
    func incrementPartySize() -> Int {
        partySize = partySize + 1
        return partySize
    }
    
}
