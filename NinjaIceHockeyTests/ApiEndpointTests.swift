//
//  NinjaIceHockeyTests.swift
//  NinjaIceHockeyTests
//
//  Created by Александр on 23.11.2022.
//

import XCTest
@testable import NinjaIceHockey

class ApiEndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTeamsUrl() {
        XCTAssertEqual(
            SofaScoreApiEndpoint.teams(tournamentId: 1, seasonId: 2).path, "https://api.sofascore.com/mobile/v4/unique-tournament/1/season/2/top-teams/overall"
        )
    }
    
    func testMatchesUrl() {
        XCTAssertEqual(
            SofaScoreApiEndpoint.matches(tournamentId: 1, seasonId: 2).path, "https://api.sofascore.com/mobile/v4/unique-tournament/1/season/2/events"
        )
    }
}
