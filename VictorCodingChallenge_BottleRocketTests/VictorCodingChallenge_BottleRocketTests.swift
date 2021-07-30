//
//  VictorCodingChallenge_BottleRocketTests.swift
//  VictorCodingChallenge_BottleRocketTests
//
//  Created by Victor Monteiro on 7/30/21.
//

import XCTest
@testable import VictorCodingChallenge_BottleRocket

class VictorCodingChallenge_BottleRocketTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchRestaurantsReturnedData() throws {
        
        let dataService = DataServiceRestaurant()
        let expectRestaurant = XCTestExpectation(description: "Restaurant")
        
        dataService.fetchRestaurant { response in
            switch response {
            case .failure(let error):
               XCTFail("Failed Fetching Data \(error)")
               expectRestaurant.fulfill()
            case .success(let restaurant):
                XCTAssert(restaurant.restaurants.count > 0, "Failed data is Empty")
                expectRestaurant.fulfill()
        
            }
        }
        
        wait(for: [expectRestaurant], timeout: 15.0)
        
    }

}
