//
//  ScrollTableViewCell.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ScrollTableViewCell: UITableViewCell {
    
    var delegate: DefaultSettings?
    
    @IBOutlet weak var scrollSwitch: UISwitch!
    
    @IBAction func switchSwitched(_ sender: UISwitch) {
        UserDefaultWrapper.manager.set(vScroll: sender.isOn)
        UserDefaults.standard.synchronize()
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
