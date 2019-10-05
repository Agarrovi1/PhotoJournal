//
//  UserDefaults.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
class UserDefaultWrapper {
    
    private init () {}
    
    static let manager = UserDefaultWrapper()
    
    //MARK: Keys
    private let darkModeKey = "darkMode"
    private let scrollKey = "scroll"
    
    //MARK: Sets
    func set(darkMode: Bool) {
        UserDefaults.standard.set(darkMode, forKey: darkModeKey)
    }
    func set(vScroll: Bool) {
        UserDefaults.standard.set(vScroll, forKey: scrollKey)
    }
    
    //MARK: Gets
    func getDarkMode() -> Bool? {
        if let darkMode = UserDefaults.standard.value(forKey: darkModeKey) as? Bool {
            return darkMode
        }
        return nil
    }
    func getVerticalScroll() -> Bool? {
        if let vScroll = UserDefaults.standard.value(forKey: scrollKey) as? Bool {
            return vScroll
        }
        return nil
    }

}
