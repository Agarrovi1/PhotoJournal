//
//  PhotoInfoPersistance.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/4/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
class PhotoInfoPersistance {
    static let manager = PhotoInfoPersistance()
    
    func save(newPhoto: PhotoInfo) throws {
        try persistanceHelper.save(newElement: newPhoto)
    }
    
    func getPhotos() throws -> [PhotoInfo] {
        return try persistanceHelper.getObjects()
    }
    
    
    
    private let persistanceHelper = PersistenceHelper<PhotoInfo>.init(fileName: "PhotoInfo.plist")
    
    private init() {}
}
