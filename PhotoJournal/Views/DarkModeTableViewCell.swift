//
//  DarkModeTableViewCell.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class DarkModeTableViewCell: UITableViewCell {
    var delegate: DefaultSettings?
    @IBOutlet weak var darkSwitch: UISwitch!
    
    @IBAction func darkModeSwitched(_ sender: UISwitch) {
        UserDefaultWrapper.manager.set(darkMode: sender.isOn)
        UserDefaults.standard.synchronize()
        delegate?.setupDarkModeDefaults()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

