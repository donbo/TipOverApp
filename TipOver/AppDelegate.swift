//
//  AppDelegate.swift
//  TipOver
//
//  Created by Don Wilson on 8/7/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Initialize user defaults
        let defaults = ["RestaurantPoor": 10,"RestaurantGood": 20, "RestaurantAmazing": 25, "HairstylePoor": 10, "HairstyleGood": 15, "HairstyleAmazing": 20, "TaxiPoor": 10, "TaxiGood":15, "TaxiAmazing":20, "DeliveryPoor":8, "DeliveryGood":10, "DeliveryAmazing":15, "ManicurePoor":10, "ManicureGood":15, "ManicureAmazing": 20,
            "BeerPoor":0, "ShotPoor":0, "SodaPoor":0, "BeerGood":1, "ShotGood":1, "SodaGood":1, "BeerAmazing":2, "ShotAmazing":2, "SodaAmazing":2, "SimpleCocktailPoor":0, "SimpleCocktailGood":2, "SimpleCocktailAmazing":3, "WinePoor":0, "WineGood":2, "WineAmazing":3, "FancyCocktailPoor":0, "FancyCocktailGood":3, "FancyCocktailAmazing":4, "BarPoor": 10, "BarGood":15, "BarAmazing":20, "CarValetPoor":1, "CarValetGood":2, "CarValetAmazing":5, "soundOn": true]
        
        
        NSUserDefaults.standardUserDefaults().registerDefaults(defaults)
        
        // Set the status bar style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //let controller = self.window?.rootViewController as! TipOverViewController
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

