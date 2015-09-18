//
//  SettingsViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/9/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var serviceType: [String] = []
    private var viewProperties = ViewProperties()
    let defaults = NSUserDefaults.standardUserDefaults()
    var updatedPoorValue: Int = 0
    var updatedGoodValue: Int = 0
    var updatedAmazingValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        
        for service in ServiceType.allServiceTypes {
            serviceType.append(service.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    @IBAction func handleDoneButton(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Table View Data Source Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return serviceType.count
    }
    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> Int {
//        return 0
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let settingsCell: SettingsTableViewCell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath) as! SettingsTableViewCell
        
        settingsCell.titleCellName.text = serviceType[indexPath.row] + " Defaults"
        let imageString = serviceType[indexPath.row] + "Small.png"
        let titleCellImage = UIImage(named: imageString)
        settingsCell.titleCellImage.image = titleCellImage
        
        
        let settingsKeyPoor: String = serviceType[indexPath.row]+"Poor"
        let settingsKeyGood: String = serviceType[indexPath.row]+"Good"
        let settingsKeyAmazing: String = serviceType[indexPath.row]+"Amazing"
        
        let poorValue = defaults.integerForKey(settingsKeyPoor)
        let goodValue = defaults.integerForKey(settingsKeyGood)
        let amazingValue = defaults.integerForKey(settingsKeyAmazing)
        settingsCell.poorPercentage.text =  "\(poorValue)"
        settingsCell.goodPercentage.text = "\(goodValue)"
        settingsCell.amazingPercentage.text = "\(amazingValue)"
        
        settingsCell.decrementPoor.tag = indexPath.row
        settingsCell.incrementPoor.tag = indexPath.row
        settingsCell.decrementGood.tag = indexPath.row
        settingsCell.incrementGood.tag = indexPath.row
        settingsCell.decrementAmazing.tag = indexPath.row
        settingsCell.incrementAmazing.tag = indexPath.row
        
        settingsCell.decrementPoor.addTarget(self, action: "handleDecrementPoor:", forControlEvents: .TouchUpInside)
        settingsCell.incrementPoor.addTarget(self, action: "handleIncrementPoor:", forControlEvents: .TouchUpInside)
        settingsCell.decrementGood.addTarget(self, action: "handleDecrementGood:", forControlEvents: .TouchUpInside)
        settingsCell.incrementGood.addTarget(self, action: "handleIncrementGood:", forControlEvents: .TouchUpInside)
        settingsCell.decrementAmazing.addTarget(self, action: "handleDecrementAmazing:", forControlEvents: .TouchUpInside)
        settingsCell.incrementAmazing.addTarget(self, action: "handleIncrementAmazing:", forControlEvents: .TouchUpInside)
        
        //settingsCell.settingsContentView.backgroundColor = viewProperties.serviceBackgroundColor[serviceType[indexPath.row]]
        if (indexPath.row % 2 == 0) {
            settingsCell.settingsContentView.backgroundColor = viewProperties.backgroundColorLight
        } else {
            settingsCell.settingsContentView.backgroundColor = viewProperties.backgroundColor
        }
        
        return settingsCell
    }
    
    // Table View Delegate Functions
    
    

    @IBAction func handleIncrementPoor(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        let settingsKeyPoor: String = serviceType[sender.tag]+"Poor"
        updatedPoorValue = defaults.integerForKey(settingsKeyPoor)
        updatedPoorValue = updatedPoorValue + 1
        defaults.setInteger(updatedPoorValue, forKey: settingsKeyPoor)
        self.tableView.reloadData()
    }
    
    @IBAction func handleDecrementPoor(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        let settingsKeyPoor: String = serviceType[sender.tag]+"Poor"
        updatedPoorValue = defaults.integerForKey(settingsKeyPoor)
        if updatedPoorValue >= 1 {
            updatedPoorValue = updatedPoorValue - 1
            defaults.setInteger(updatedPoorValue, forKey: settingsKeyPoor)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func handleIncrementGood(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        let settingsKeyGood: String = serviceType[sender.tag]+"Good"
        updatedGoodValue = defaults.integerForKey(settingsKeyGood)
        updatedGoodValue = updatedGoodValue + 1
        defaults.setInteger(updatedGoodValue, forKey: settingsKeyGood)
        self.tableView.reloadData()
    }
    
    @IBAction func handleDecrementGood(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        let settingsKeyGood: String = serviceType[sender.tag]+"Good"
        updatedGoodValue = defaults.integerForKey(settingsKeyGood)
        if updatedGoodValue >= 1 {
            updatedGoodValue = updatedGoodValue - 1
            defaults.setInteger(updatedGoodValue, forKey: settingsKeyGood)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func handleIncrementAmazing(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        let settingsKeyAmazing: String = serviceType[sender.tag]+"Amazing"
        updatedAmazingValue = defaults.integerForKey(settingsKeyAmazing)
        updatedAmazingValue = updatedAmazingValue + 1
        defaults.setInteger(updatedAmazingValue, forKey: settingsKeyAmazing)
        self.tableView.reloadData()
    }
    
    @IBAction func handleDecrementAmazing(sender: UIButton) {
        
        TapSound.sharedInstance.play()
        
        let settingsKeyAmazing: String = serviceType[sender.tag]+"Amazing"
        updatedAmazingValue = defaults.integerForKey(settingsKeyAmazing)
        if updatedAmazingValue >= 1 {
            updatedAmazingValue = updatedAmazingValue - 1
            defaults.setInteger(updatedAmazingValue, forKey: settingsKeyAmazing)
            self.tableView.reloadData()
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
