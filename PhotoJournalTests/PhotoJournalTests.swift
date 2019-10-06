//
//  PhotoJournalTests.swift
//  PhotoJournalTests
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import XCTest
@testable import PhotoJournal

class PhotoJournalTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testPhotoInfoCanChange() {
        var sample = PhotoInfo(imageData: Data(), summary: "")
        if let newData = UIImage(named: "blankImage")?.pngData() {
            sample.imageData = newData
            XCTAssertTrue(sample.imageData != Data())
        }
        sample.summary = "new summary"
        XCTAssertTrue(sample.summary != "")
    }
    func testPersistanceHelper() {
        do {
            let array = try PhotoInfoPersistance.manager.getPhotos()
            XCTAssertTrue(array.count != 0)
        } catch {
            XCTAssertTrue(false, "Error: \(error)")
        }
    }
    func testUserDefaults() {
        if let aDefaultValue = UserDefaultWrapper.manager.getDarkMode() {
            XCTAssertTrue(aDefaultValue == true || aDefaultValue == false)
        } else {
            XCTAssertNil(nil, "no default Value")
        }
    }

}
