//
//  Protocols.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/4/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
protocol DefaultSettings {
    var darkMode: Bool? {get}
    var verticalScroll: Bool? {get}
    func setupDarkModeDefaults()
    func setupScrollDefaults()
}
protocol PhotoEntryCellDelegate {
    func showActionSheet(tag: Int)
}
