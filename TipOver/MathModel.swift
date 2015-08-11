//
//  mathModel.swift
//  TipOver
//
//  Created by Kyle Barker on 8/10/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import Foundation

class MathModel {
    var billAmount: Double
    var tipPercentage: Double
    var partySize: Int
    var splitPay: Double
    
    init() {
        billAmount = 0
        tipPercentage = 0
        partySize = 1
        splitPay = 0
    }
    
    func tipAmount() -> Double {
        return billAmount * (tipPercentage/100)
    }
    
    func totalAmount() -> Double {
        return billAmount + tipAmount()
    }
    
    func splitAmount() -> Double {
        return totalAmount() / Double(partySize)
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
