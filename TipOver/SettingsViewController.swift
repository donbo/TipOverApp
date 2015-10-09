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
    
    var myServiceType: ServiceType = ServiceType.Restaurant
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        
        tableView.registerNib(UINib(nibName: "SettingsSoundTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsSoundCell")
        tableView.registerNib(UINib(nibName: "SettingsVersionTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsVersionCell")
        tableView.registerNib(UINib(nibName: "SettingsAcknowledgementsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsAcknowledgementsCell")
        
        for service in ServiceType.allServiceTypes {
            serviceType.append(service.rawValue)
        }
        
        // Scroll the table view so that the settings for the requesting service view controller are displayed
        var serviceIndex:Int = 0
        switch myServiceType {
        case .Restaurant:
            serviceIndex = 0
        case .Bar:
            serviceIndex = 1
        case .HairStyle:
            serviceIndex = 2
        case .Taxi:
            serviceIndex = 3
        case .Delivery:
            serviceIndex = 4
        case .Manicure:
            serviceIndex = 5
        case .Valet:
            serviceIndex = 6
        }
        
        let indexPath1 = NSIndexPath(forRow: serviceIndex, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath1, atScrollPosition: .Top, animated: true)
        
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
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return serviceType.count
        } else {
            return 3
        }
    }
    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> Int {
//        return 0
//    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Service Type Settings"
        } else {
            return "App Settings and Information"
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        } else if (indexPath.row == 0 || indexPath.row == 1) {
            return 60
        } else {
            return 100
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        viewProperties = ViewProperties()
        
        view.tintColor = viewProperties.backgroundColor
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.font = UIFont(name: "AvenirNext-Regular", size: 20)
        //header.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        header.textLabel!.textColor = UIColor.whiteColor()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            // Determine the service type and table cell type based on the index path
            if serviceType[indexPath.row] == "Valet" {
                let settingsValetCell: SettingsValetTableViewCell = tableView.dequeueReusableCellWithIdentifier("settingsValetCell", forIndexPath: indexPath) as! SettingsValetTableViewCell
                
                settingsValetCell.settingsValetServiceLabel.text = "Car Valet Defaults"
                let valetCellImage = UIImage(named: "CarValetSmall.png")
                settingsValetCell.settingsValetServiceImage.image = valetCellImage
                
                let settingsKeyPoor: String = "CarValetPoor"
                let settingsKeyGood: String = "CarValetGood"
                let settingsKeyAmazing: String = "CarValetAmazing"
                
                let poorValue = defaults.integerForKey(settingsKeyPoor)
                let goodValue = defaults.integerForKey(settingsKeyGood)
                let amazingValue = defaults.integerForKey(settingsKeyAmazing)
                settingsValetCell.settingsValetPoorTipValue.text =  "$" + "\(poorValue)"
                settingsValetCell.settingsValetGoodTipValue.text = "$" + "\(goodValue)"
                settingsValetCell.settingsValetAmazingTipValue.text = "$" + "\(amazingValue)"
                
                //settingsValetCell.settingsValetPoorDecrementButton.addTarget(self, action: "handleValetDecrementPoor:", forControlEvents: .TouchUpInside)
                //settingsValetCell.settingsValetPoorIncrementButton.addTarget(self, action: "handleValetIncrementPoor:", forControlEvents: .TouchUpInside)
                //settingsValetCell.settingsValetGoodDecrementButton.addTarget(self, action: "handleValetDecrementGood:", forControlEvents: .TouchUpInside)
                //settingsValetCell.settingsValetGoodIncrementButton.addTarget(self, action: "handleValetIncrementGood:", forControlEvents: .TouchUpInside)
                //settingsValetCell.settingsValetAmazingDecrementButton.addTarget(self, action: "handleValetDecrementAmazing:", forControlEvents: .TouchUpInside)
                //settingsValetCell.settingsValetAmazingIncrementButton.addTarget(self, action: "handleValetIncrementAmazing:", forControlEvents: .TouchUpInside)

                
                // Set the background colors of the cells to alternate colors - light and darker
                if (indexPath.row % 2 == 0) {
                    settingsValetCell.settingsValetContentView.backgroundColor = viewProperties.backgroundColorLight
                } else {
                    settingsValetCell.settingsValetContentView.backgroundColor = viewProperties.backgroundColor
                }

                return settingsValetCell
                
            } else {
            
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
                settingsCell.poorPercentage.text =  "\(poorValue)" + "%"
                settingsCell.goodPercentage.text = "\(goodValue)" + "%"
                settingsCell.amazingPercentage.text = "\(amazingValue)" + "%"
                
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
                
                // Set the background colors of the cells to alternate colors - light and darker
                if (indexPath.row % 2 == 0) {
                    settingsCell.settingsContentView.backgroundColor = viewProperties.backgroundColorLight
                } else {
                    settingsCell.settingsContentView.backgroundColor = viewProperties.backgroundColor
                }
                
                return settingsCell
            }
        
        } else {
            
            // Return cells for section 1 - App Settings and Information
            if indexPath.row == 0 {
                let soundCell: SettingsSoundTableViewCell = tableView.dequeueReusableCellWithIdentifier("settingsSoundCell", forIndexPath: indexPath) as! SettingsSoundTableViewCell
                
                soundCell.contentView.backgroundColor = viewProperties.backgroundColorLight
                
                if defaults.boolForKey("soundOn") {
                    soundCell.settingsSoundSwitch.setOn(true, animated: true)
                } else {
                    soundCell.settingsSoundSwitch.setOn(false, animated: true)
                }
                
                soundCell.settingsSoundSwitch.addTarget(self, action: "handleSoundSwitch:", forControlEvents: .ValueChanged)
                
                return soundCell
            } else if (indexPath.row == 1) {
                let versionCell: SettingsVersionTableViewCell = tableView.dequeueReusableCellWithIdentifier("settingsVersionCell", forIndexPath: indexPath) as! SettingsVersionTableViewCell
                
                    versionCell.contentView.backgroundColor = viewProperties.backgroundColor
                
                    versionCell.settingsVersionLabel.text = "1.0"
                
                return versionCell
            } else {
                let ackCell: SettingsAcknowledgementsTableViewCell = tableView.dequeueReusableCellWithIdentifier("settingsAcknowledgementsCell", forIndexPath: indexPath) as! SettingsAcknowledgementsTableViewCell
                
                ackCell.contentView.backgroundColor = viewProperties.backgroundColorLight
                
                return ackCell
            }
        }
    
    }
    
    
    // Table View Delegate Functions

    // Handle button presses for most cells (except valet)
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
    
    
    @IBAction func handleValetIncrementPoor(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        let settingsKeyValetPoor: String = "CarValetPoor"
        updatedPoorValue = defaults.integerForKey(settingsKeyValetPoor)
        updatedPoorValue = updatedPoorValue + 1
        defaults.setInteger(updatedPoorValue, forKey: settingsKeyValetPoor)
        self.tableView.reloadData()

    }
    
    @IBAction func handleValetDecrementPoor(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        let settingsKeyValetPoor: String = "CarValetPoor"
        updatedPoorValue = defaults.integerForKey(settingsKeyValetPoor)
        if updatedPoorValue >= 1 {
            updatedPoorValue = updatedPoorValue - 1
            defaults.setInteger(updatedPoorValue, forKey: settingsKeyValetPoor)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func handleValetIncrementGood(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        let settingsKeyValetGood: String = "CarValetGood"
        updatedGoodValue = defaults.integerForKey(settingsKeyValetGood)
        updatedGoodValue = updatedGoodValue + 1
        defaults.setInteger(updatedGoodValue, forKey: settingsKeyValetGood)
        self.tableView.reloadData()
    }
    
    @IBAction func handleValetDecrementGood(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        let settingsKeyValetGood: String = "CarValetGood"
        updatedGoodValue = defaults.integerForKey(settingsKeyValetGood)
        if updatedGoodValue >= 1 {
            updatedGoodValue = updatedGoodValue - 1
            defaults.setInteger(updatedGoodValue, forKey: settingsKeyValetGood)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func handleValetIncrementAmazing(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        let settingsKeyValetAmazing: String = "CarValetAmazing"
        updatedAmazingValue = defaults.integerForKey(settingsKeyValetAmazing)
        updatedAmazingValue = updatedAmazingValue + 1
        defaults.setInteger(updatedAmazingValue, forKey: settingsKeyValetAmazing)
        self.tableView.reloadData()
    }
    
    @IBAction func handleValetDecrementAmazing(sender: UIButton) {
        TapSound.sharedInstance.play()
        
        let settingsKeyValetAmazing: String = "CarValetAmazing"
        updatedAmazingValue = defaults.integerForKey(settingsKeyValetAmazing)
        if updatedAmazingValue >= 1 {
            updatedAmazingValue = updatedAmazingValue - 1
            defaults.setInteger(updatedAmazingValue, forKey: settingsKeyValetAmazing)
            self.tableView.reloadData()
        }
    }
    
    func handleSoundSwitch(sender: UISwitch) {
        
        let soundOn:Bool = sender.on
        defaults.setBool(soundOn, forKey: "soundOn")
        defaults.synchronize()
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
