//
//  SettingsTableViewController.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "darkModeCell", for: indexPath) as? DarkModeTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            setDefaultSwitchPosition(cell: cell)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "scrollCell", for: indexPath) as? ScrollTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            setScrollDefaultSwitchPosition(cell: cell)
            return cell
        }
    }
    
    private func setDefaultSwitchPosition(cell: DarkModeTableViewCell) {
        if let darkMode = darkMode {
            cell.darkSwitch.isOn = darkMode
        }
    }
    private func setScrollDefaultSwitchPosition(cell: ScrollTableViewCell) {
        if let scroll = verticalScroll {
            cell.scrollSwitch.isOn = scroll
        }
    }
}

extension SettingsTableViewController: DefaultSettings {
    var darkMode: Bool? {
        UserDefaultWrapper.manager.getDarkMode()
    }
    
    var verticalScroll: Bool? {
    UserDefaultWrapper.manager.getVerticalScroll()
    }
    
    func setupDarkModeDefaults() {
        guard let darkMode = darkMode else {return}
        self.tableView.backgroundColor = darkMode ? .darkGray : .white
    }
    
    func setupScrollDefaults() {
        
    }
    
    
}
