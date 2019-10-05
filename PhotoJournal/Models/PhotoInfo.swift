//
//  PhotoInfo.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/4/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
struct PhotoInfo: Codable {
    static var count = 0
    var favorited: Bool
    let imageData: Data
    var summary: String
    let date: Date
    let id: Int
    
    init(imageData: Data,summary: String) {
        id = PhotoInfo.count
        self.imageData = imageData
        date = Date()
        favorited = false
        self.summary = summary
        PhotoInfo.count += 1
    }
}
