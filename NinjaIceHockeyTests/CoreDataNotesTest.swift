//
//  CoreDataNotesTest.swift
//  NinjaIceHockeyTests
//
//  Created by Александр on 26.11.2022.
//

import XCTest
@testable import NinjaIceHockey

class CoreDataNotesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadNotes() {
        let coreDataService = CoreDataService()
        let notes = coreDataService.notes()
        
        print(notes)
    }

    func testSaveNotes() {
        let coreDataService = CoreDataService()
        coreDataService.createNote(title: "note 1", content: "contetn 1")
    }
}
