//
//  ApiTest.swift
//  NinjaIceHockeyTests
//
//  Created by Александр on 23.11.2022.
//

import XCTest
@testable import NinjaIceHockey


class ApiTest: XCTestCase {
    
//    private let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testLoadingTeamArray() {
//        let expectation = XCTestExpectation(description: "team loadind")
//
//        let tournamentId = 8
//        let seasonId = 42409
//
//        let api = Api()
//
//        var team = [Team]()
//
//        api.teams(tournamentId: tournamentId, seasonId: seasonId)
//            .subscribe(onNext: {
//                team = $0
//                expectation.fulfill()
//                XCTAssertEqual(team.count, 20)
//            })
//            .disposed(by: disposeBag)
//
//        wait(for: [expectation], timeout: 5.0)
//    }
    
//    func testTeamTest() {
//        let expectation = XCTestExpectation(description: "team loadind")
//
//        let api = Api()
//
//        DispatchQueue.global().async {
//            api.testTeam()
//        }
//
//
////        sleep(3)
//        wait(for: [expectation], timeout: 4.0)
//    }
}
