//
//  SettingsValetTableViewCell.swift
//  TipOver
//
//  Created by Don Wilson on 10/4/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class SettingsValetTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsValetContentView: UIView!
    @IBOutlet weak var settingsValetServiceImage: UIImageView!
    @IBOutlet weak var settingsValetServiceLabel: UILabel!
    @IBOutlet weak var settingsValetPoorIncrementButton: UIButton!
    @IBOutlet weak var settingValetPoorDecrementButton: UIButton!
    @IBOutlet weak var settingsValetGoodIncrementButton: UIButton!
    @IBOutlet weak var settingsValetGoodDecrementButton: UIButton!
    @IBOutlet weak var settingsValetPoorDecrementButton: UIButton!
    @IBOutlet weak var settingsValetAmazingIncrementButton: UIButton!
    @IBOutlet weak var settingsValetAmazingDecrementButton: UIButton!
    
    @IBOutlet weak var settingsValetPoorTipValue: UILabel!
    @IBOutlet weak var settingsValetGoodTipValue: UILabel!
    @IBOutlet weak var settingsValetAmazingTipValue: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
