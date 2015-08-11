//
//  TipOverViewController.swift
//  TipOver
//
//  Created by Don Wilson on 8/7/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class TipOverViewController: UICollectionViewController {

    private var serviceType: [String] = []
    let viewProperties = ViewProperties()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for service in ServiceType.allServiceTypes {
            serviceType.append(service.rawValue)
        }
        
        print("in TipOverViewController viewDidLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("in numberOfItemsInSection")
        return serviceType.count
    }
    
    @IBAction func handleSettingsButton(sender: AnyObject) {
        print("in handleSettingsButton")
    }
    
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        
        // Set the links back to the current view controller
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // UICollectionViewDataSource delegate functions
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        print("in Dequeue")
        
        let serviceCell: ServiceCell = collectionView.dequeueReusableCellWithReuseIdentifier("ServiceCell", forIndexPath: indexPath) as! ServiceCell
        
        // Set the service type
        serviceCell.serviceCellLabel?.text = serviceType[indexPath.row]
        
        // Set the image for the service type
        let imageFile = serviceType[indexPath.row] + ".png"
        let image = UIImage(named: imageFile)
        serviceCell.serviceCellImage.image = image
        
        return serviceCell
    }
    
    // UICollectionViewDelegate functions
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let segueType : String = "show" + serviceType[indexPath.row]
        
        print("segueType is ", segueType)
        self.performSegueWithIdentifier(segueType, sender: self)
        
    }
    
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        print(" in didSelectItemAtIndexPath")
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = viewProperties.highlightColor
        
    }
    
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        print(" in didSelectItemAtIndexPath")
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = viewProperties.backgroundColor
        
    }
}


