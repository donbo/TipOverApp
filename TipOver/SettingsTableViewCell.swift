//
//  SettingsTableViewCell.swift
//  TipOver
//
//  Created by Kyle Barker on 8/18/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCellName: UILabel!
    @IBOutlet weak var titleCellImage: UIImageView!
    @IBOutlet weak var incrementPoor: UIButton!
    @IBOutlet weak var poorPercentage: UILabel!
    @IBOutlet weak var decrementPoor: UIButton!
    @IBOutlet weak var incrementGood: UIButton!
    @IBOutlet weak var goodPercentage: UILabel!
    @IBOutlet weak var decrementGood: UIButton!
    @IBOutlet weak var incrementAmazing: UIButton!
    @IBOutlet weak var amazingPercentage: UILabel!
    @IBOutlet weak var decrementAmazing: UIButton!
    @IBOutlet weak var settingsContentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
